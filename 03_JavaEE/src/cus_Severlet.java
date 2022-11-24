import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/customer")
public class cus_Severlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String salary = req.getParameter("salary");
//        System.out.println(id+" "+name+" "+address+" "+salary);
//        System.out.println("Hello");
        try {
            Class.forName("com.mysql.jdbc.Driver");
           Connection connection= DriverManager.getConnection("jdbc:mysql://localhost:3306/ thogakade","root","1234");
            PreparedStatement pstm = connection.prepareStatement("insert into customer values (?,?,?,?)");
            pstm.setObject(1,id);
            pstm.setObject(2,name);
            pstm.setObject(3,address);
            pstm.setObject(4,salary);
            boolean b =pstm.executeUpdate()>0;
            PrintWriter writer = resp.getWriter();
            writer.write("<h1>Customer Added State : "+b+"</h1>");

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();

    }

}

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("Done");
    }
}
