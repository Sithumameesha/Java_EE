<%@ page import="java.util.ArrayList" %>
<%@ page import="Dto.customerDto" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Form</title>
    <link rel="stylesheet" href="./assects/boostrap_lib/css/bootstrap.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<%

//    ArrayList<customerDto>allcustomer = new ArrayList<>();
    ArrayList<customerDto>allcustomer =(ArrayList<customerDto>) request.getAttribute("customers");

%>










<header>
    <nav class="navbar navbar-expand-lg navbar-light shadow-lg posNavi position-relative rounded-bottom">
        <div class="container-fluid">
            <a class="navbar-brand text-dark fw-bold " >
                <img alt="Logo" class="d-inline-block align-text-center" height="44" src="./assects/img/pngwing.com%20(42).png">
                <span class="text-success"> Welocome </span>  System
            </a>
            <button aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"
                    class="navbar-toggler" data-bs-target="#navbarSupportedContent"
                    data-bs-toggle="collapse" type="button">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a aria-current="page" class="nav-link active" href="customer.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="customer.jsp" >Customer</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="item.html">Items</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="orders.html">Orders</a>
                    </li>
                </ul>
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <button class="btn btn-outline-primary btn-m" type="button"><i class="fa-solid fa-user-plus"></i>
                        Sign Up
                    </button>
                    <button class="btn btn-outline-secondary" type="button"><i
                            class="fa-solid fa-right-from-bracket"></i> Log Out
                    </button>
                </div>
            </div>
        </div>
    </nav>
</header>
<main class="container-fluid">
    <section class="row">
        <div class="col-4">
            <h1>Customer Registraion</h1>
            <form id="customerForm">
                <div class="form-group">
                    <label for="txtCustomerID">Customer ID</label>
                    <input class="form-control" id="txtCustomerID"  type="text" name="id">
                    <span class="control-error" id="lblcusid"></span>
                </div>
                <div class="form-group">
                    <label for="txtCustomerName">Customer Name</label>
                    <input class="form-control" id="txtCustomerName" type="text" name="name">
                    <span class="control-error" id="lblcusname"></span>
                </div>
                <div class="form-group">
                    <label for="txtCustomerAddress">Customer Address</label>
                    <input class="form-control" id="txtCustomerAddress" type="text" name="address">
                    <span class="control-error" id="lblcusaddress"></span>
                </div>
                <div class="form-group">
                    <label for="txtCustomerSalary">Customer Salary</label>
                    <input class="form-control" id="txtCustomerSalary" type="text" name="salary">
                    <span class="control-error" id="lblcussalary"></span>
                </div>
            </form>
            <div class="btn-group" style="margin: 20px ">
                <button class="btn btn-primary" type="button" id="btnCustomer">Save Customer</button>
                <button class="btn btn-danger" id="btnCusDelete"  >Remove</button>
                <button class="btn btn-warning" id="btnUpdate"   >Update</button>
                <button class="btn btn-success" id="btnGetAll" type="button" >Get All</button>
<%--                <button class="btn btn-danger" id="btn-clear1">Clear All</button>--%>
            </div>

        </div>
        <div class="col-8">
            <table class="table table-bordered table-hover">
                <thead class="bg-danger text-white">
                <tr>
                    <th>Customer ID</th>
                    <th>Customer Name</th>
                    <th>Customer Address</th>
                    <th>Customer Salary</th>
                </tr>
                </thead>
                <tbody id="tblCustomer">
                <%
                    if (allcustomer!=null){
                    for (customerDto customer : allcustomer) {
                %>
                <tr>
                    <td><%=customer.getId()%></td>
                    <td><%=customer.getName()%></td>
                    <td><%=customer.getAddress()%></td>
                    <td><%=customer.getSalary()%></td>
                </tr>
                <%
                        }
                    }
                %>
                </tbody>
            </table>
        </div>
    </section>
</main>

<script src="./assects/boostrap_lib/js/bootstrap.min.js"></script>
<script src="./assects/js/jQuery%20v3.6.1.js"></script>
<script>
    function bindrawEvent() {
        $("#tblCustomer>tr").click(function () {
            let id = $(this).children(":eq(0)").text();
            let name = $(this).children(":eq(1)").text();
            let address = $(this).children(":eq(2)").text();
            let salary = $(this).children(":eq(3)").text();


            $('#txtCustomerID').val(id);
            $('#txtCustomerName').val(name);
            $('#txtCustomerAddress').val(address);
            $('#txtCustomerSalary').val(salary);
        });
    }


</script>
<script>
    GetAllCustomer();
    $("#btnCustomer").click(function (){
        let formdata = $("#customerForm").serialize();
         $.ajax({
         url:"customer",
            method:"post",
         data:formdata,
             dataType:"json",
          success:function (res){
              console.log(res);
              alert(res.message);
              GetAllCustomer();
            },
             error:function (error){
                 console.log("Error Method Invoked");
                 console.log(JSON.parse(error.responseText));
                 alert(JSON.parse(error.responseText).message);

             }
        });
        console.log("Hello");
    });

    $("#btnCusDelete").click(function (){
        let id = $("#txtCustomerID").val();
        $.ajax({
            url: "customer?id= "+id+"",
            method: "delete",
            success: function (resp) {
                GetAllCustomer();
            }
        });
        console.log("Hello");
    });
    $("#btnUpdate").click(function (){
        let cusId = $("#txtCustomerID").val();
        let cusName = $("#txtCustomerName").val();
        let cusAddress = $("#txtCustomerAddress").val();
        let cusSalary = $("#txtCustomerSalary").val();
        var customerOb = {
            id: cusId,
            name: cusName,
            address: cusAddress,
            salary: cusSalary
        }
        $.ajax({
            url: "customer",
            method: "put",
            contentType:"application/json",
            data: JSON.stringify(customerOb),
            success: function (res) {
                GetAllCustomer();
            }
        });
    });
    $("#btnGetAll").click(function (){
GetAllCustomer();
    });
function GetAllCustomer(){
    $("#tblCustomer").empty();
    $.ajax({
        url:"customer",
        success:function (res){
            for (let c of res) {
                var cusId = c.id;
                let cusName = c.name;
                let cusAddress = c.address;
                let cusSalary =c.salary;
                let row = "<tr><td>"+cusId+"</td><td>"+cusName+"</td><td>"+cusAddress+"</td><td>"+cusSalary+"</td></tr>"
                $("#tblCustomer").append(row);
            }
            bindrawEvent();
        }
    });
}
</script>
</body>
</html>