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
    ArrayList<customerDto>allcustomer = new ArrayList<>();

    Class.forName("com.mysql.jdbc.Driver");
    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/thogakade", "root", "1234");
    PreparedStatement pstm = connection.prepareStatement("select * from customer");
    ResultSet rst = pstm.executeQuery();
    while (rst.next()) {
        String id = rst.getString("id");
        String name = rst.getString("name");
        String address = rst.getString("address");
        double salary = rst.getDouble("salary");
        allcustomer.add(new customerDto(id,name,address,salary));
    }



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
            <div class="btn-group">
                <button class="btn btn-primary" id="btnCustomer" form="customerForm" formaction="customer?Option=Add" formmethod="post">Save Customer</button>
                <button class="btn btn-danger" id="btnCusDelete" form="customerForm" formaction="customer?Option=remove" formmethod="post" >Remove</button>
                <button class="btn btn-warning" id="btnUpdate">Update</button>
                <button class="btn btn-success" id="btnGetAll" form="customerForm" formaction="customer.jsp">Get All</button>
                <button class="btn btn-danger" id="btn-clear1">Clear All</button>
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
                %>
                </tbody>
            </table>
        </div>
    </section>
</main>

<script src="./assects/boostrap_lib/js/bootstrap.min.js"></script>
<script src="./assects/js/jQuery%20v3.6.1.js"></script>
<!--<script>-->
<!--    var customerArray=[];-->
<!--    $("#btnCustomer").click(function (){-->

<!--        let customerId= $("#txtCustomerId").val();-->
<!--        let customerName=$("#txtCustomerName").val();-->
<!--        let customerAddress = $("#txtCustomerAddress").val();-->
<!--        let customerSalary =$("#txtCustomerSalary").val();-->

<!--     var customerObject ={-->
<!--      id:customerId,-->
<!--      name :customerName,-->
<!--      salary: customerSalary,-->
<!--      address :customerAddress,-->
<!--     }-->

<!--     customerArray.push(customerObject);-->

<!--        loadAllCustomers();-->
<!--    });-->


<!--    $("#txtCustomerId,#txtCustomerName,#txtCustomerAddress,#txtCustomerSalary").on("keydown",function (event){-->
<!--        if (event.key=="Tab"){-->
<!--            event.preventDefault();-->
<!--        }-->
<!--    });-->

<!--    function loadAllCustomers() {-->
<!--        $("#customerTable").empty();-->

<!--        for (var customer of customerArray) {-->

<!--            var row = "<tr><td>"+customer.id+"</td><td>"+customer.name+"</td><td> "+customer.address+"</td><td> "+customer.salary+" </td></tr>";-->
<!--                $("#customerTable").append(row);-->
<!--        }-->
<!--    }-->


<!--    $("#customerTable>tr").click(function () {-->
<!--        let rowData = $(this).text();-->
<!--        console.log(rowData);-->
<!--    });-->
<!--/*........................Search Customer.......................................*/-->

<!--    $("#txtCustomerId").on('keyup', function (event) {-->
<!--        if (event.code == "Enter") {-->
<!--            let typedId = $("#txtCustomerId").val();-->
<!--            let customer = searchCustomer(typedId);-->
<!--            if (customer != null) {-->
<!--                $("#txtCustomerId").val(customer.id);-->
<!--                $("#txtCustomerName").val(customer.name);-->
<!--                $("#txtCustomerAddress").val(customer.address);-->
<!--                $("#txtCustomerSalary").val(customer.salary);-->
<!--            } else {-->
<!--                alert("There is no customer");-->
<!--            }-->
<!--        }-->
<!--    });-->


<!--    function searchCustomer(cusID) {-->
<!--        for (let customer of customerArray) {-->
<!--            if (customer.id == cusID) {-->
<!--                return customer;-->
<!--            }-->
<!--        }-->
<!--        return null;-->
<!--    }-->

<!--    /*...................Delete Customer...........................................*/-->

<!--        $("#BtnDelete").click(function (){-->
<!--            let deleteID=$("#searchCustId").val();-->
<!--            DeleteCustomer(deleteID);-->

<!--        });-->


<!--    function DeleteCustomer(CustomerId){-->
<!--        let customer= searchCustomer(CustomerId)-->
<!--        if (CustomerId!=null){-->
<!--            let index=customerArray.indexOf(customer);-->
<!--            customerArray.splice(index,1);-->
<!--            loadAllCustomers();-->

<!--        }-->
<!--    }-->

<!--    $("#searchCustId").on('keyup', function (event) {-->
<!--        if (event.code == "Enter") {-->
<!--            let typedId = $("#searchCustId").val();-->
<!--            let customer = searchCustomer(typedId);-->
<!--            if (customer != null) {-->
<!--                $("#searchCustId").val(customer.id);-->
<!--                $("#disabledName").val(customer.name);-->
<!--                $("#disabledAddress").val(customer.address);-->
<!--                $("#disabledSalary").val(customer.salary);-->
<!--            } else {-->
<!--                alert("There is no customer");-->
<!--            }-->
<!--        }-->
<!--    });-->

<!--/*...................Update Customer....................................*/-->
<!--    $("#searchCustomerId").on('keyup', function (event) {-->
<!--        if (event.code == "Enter") {-->
<!--            let typedId = $("#searchCustomerId").val();-->
<!--            let customer = searchCustomer(typedId);-->
<!--            if (customer != null) {-->
<!--                $("#searchCustomerId").val(customer.id);-->
<!--                $("#Cusname").val(customer.name);-->
<!--                $("#address").val(customer.address);-->
<!--                $("#salary").val(customer.salary);-->
<!--            } else {-->
<!--                alert("There is no customer");-->
<!--            }-->
<!--        }-->
<!--    });-->

<!--    function UpdateCustomer(CustomerId){-->
<!--        let customer =searchCustomer(CustomerId);-->
<!--        if (customer!=null){-->
<!--            customer.id=$("#searchCustomerId").val();-->
<!--                customer.name=$("#Cusname").val();-->
<!--                    customer.address=$("#address").val();-->
<!--                        customer.salary=$("#salary").val();-->
<!--                        loadAllCustomers();-->
<!--        }-->
<!--    }-->


<!--    $("#btnUpdate").click(function (){-->
<!--        let ID=$("#searchCustomerId").val();-->
<!--        UpdateCustomer(ID);-->

<!--    });-->


<!--</script>-->
</body>
</html>