package servlet;

import data.Data;
import data.UserAccount;
import utils.AppUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "AuthorizeServlet", value = "/login")
public class AuthorizeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if(AppUtils.getAuthorizedUser(req.getSession()) != null) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }
        getServletContext().getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        UserAccount userAccount = Data.findUser(username, password);

        if(userAccount == null) {
            String errorMessage = "Invalid username or password.";
            req.setAttribute("errorMessage", errorMessage);
            getServletContext().getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        AppUtils.storeAuthorizedUser(req.getSession(), userAccount);
        resp.sendRedirect(req.getContextPath() + "/");
    }
}
