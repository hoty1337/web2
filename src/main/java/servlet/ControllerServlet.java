package servlet;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "ControllerServlet", value = "/controller")
public class ControllerServlet extends HttpServlet {
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        resp.setContentType("text/html");

        if(req.getParameter("x") != null && req.getParameter("y") != null
                && req.getParameter("r") != null) {
            getServletContext().getNamedDispatcher("AreaCheckServlet").forward(req, resp);
        } else {
            getServletContext().getRequestDispatcher("/main.jsp").forward(req, resp);
        }
    }
}