import javax.servlet.Servlet;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
@WebServlet(urlPatterns = "/item")
public class customer extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        PrintWriter printWriter = resp.getWriter();
//        printWriter.write("<h1>Customer Saved</h1>");
        String name = req.getParameter("cusname");
        String id = req.getParameter("cusId");
        String address = req.getParameter("cusAddress");
        System.out.println(name);
        PrintWriter printWriter = resp.getWriter();
        printWriter.write(
                "<table><thead><tr><th>Customer Id</th><th>Customer Name</th><th>Address</th><tbody></tr></thead><tr><td>" +id+ "</td><td>" + name + "</td><td>" + address + "</td></tr></tbody></table> <style> body{ width: 97.5vw; height: 97.5vh; display: flex; flex-direction: column;} h1{font-size: 4em; color: crimson;} table{border-collapse: collapse;} table,tr,th,td{border: 1px solid black;} thead,tbody{padding: 10px;font-size: 20px;} thead{background: blue; color: white} th,td{width: 200px; height: 30px}</style>");

    }
}
