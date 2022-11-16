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
        printWriter.write("<table><tr><th>Name</th></tr><tr>"+name+"</tr><tr><th>CustomerId</th></tr><tr>"+id+"<tr/><tr>"+address+"<tr/><table/>");

    }
}
