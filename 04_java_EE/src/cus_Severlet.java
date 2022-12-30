import Dto.customerDto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.ArrayList;

@WebServlet(urlPatterns = "/customer")
public class cus_Severlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/thogakade", "root", "1234");
            PreparedStatement pstm = connection.prepareStatement("select * from customer");
            ResultSet rst = pstm.executeQuery();
            String jsonArray="[";
            while (rst.next()) {
                String id = rst.getString("id");
                String name = rst.getString("name");
                String address = rst.getString("address");
                double salary = rst.getDouble("salary");
                jsonArray+="{\"id\":\""+id+"\",\"name\":\""+name+"\",\"address\":\""+address+"\",\"salary\":"+salary+"},";
            }
            String finalArray = jsonArray.substring(0, jsonArray.length() - 1);
            finalArray+="]";

            resp.addHeader("Content-Type","application/json");
            resp.addHeader("myHeader","ijse");
            resp.getWriter().write(finalArray);

//            resp.sendRedirect("customer.jsp");
//            req.setAttribute("customers",allcustomer);
//            req.getRequestDispatcher("customer.jsp").forward(req,resp);


        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }


    }


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String salary = req.getParameter("salary");
        String option = req.getParameter("Option");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ thogakade", "root", "1234");
        if (option.equals("Add")) {
                PreparedStatement pstm = connection.prepareStatement("insert into customer values (?,?,?,?)");
                pstm.setObject(1, id);
                pstm.setObject(2, name);
                pstm.setObject(3, address);
                pstm.setObject(4, salary);
                boolean b = pstm.executeUpdate() > 0;

        } else if (option.equals("remove")) {
            PreparedStatement pstm = connection.prepareStatement("delete from  customer where id=?");
            pstm.setObject(1, id);
            boolean b = pstm.executeUpdate() > 0;
        }else if (option.equals("update")){
            PreparedStatement pstm = connection.prepareStatement("update customer set name =?,address=?,salary=?where id=?");
            pstm.setObject(4, id);
            pstm.setObject(1, name);
            pstm.setObject(2, address);
            pstm.setObject(3, salary);
            boolean b = pstm.executeUpdate() > 0;
        }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

    }
}