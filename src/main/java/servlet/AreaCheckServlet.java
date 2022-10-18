package servlet;

import data.Point;

import java.io.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "AreaCheckServlet", value = "/check")
public class AreaCheckServlet extends HttpServlet {
    private HttpServletRequest request;
    private HttpServletResponse response;

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        resp.setContentType("text/html");
        request = req;
        response = resp;
        long startTime = System.nanoTime();

        String x = req.getParameter("x");
        String y = req.getParameter("y");
        String r = req.getParameter("r");
        double xValue, yValue, rValue;

        if(x == null || x.equals(""))  {
            error("x is not set");
            return;
        }
        if(y == null || y.equals("")) {
            error("y is not set");
            return;
        }
        if(r == null || r.equals("")) {
            error("r is not set");
            return;
        }

        xValue = parseX(x.trim().replace("'", ""));
        yValue = parseY(y.trim().replace("'", ""));
        rValue = parseR(r.trim().replace("'", ""));

        boolean isInside = isInsideCircle(xValue, yValue, rValue) ||
                isInsideTriangle(xValue, yValue, rValue) ||
                isInsideSquare(xValue, yValue, rValue);

        long time = System.currentTimeMillis() / 1000000;

        String execTime = String.format("%.9f", (System.nanoTime() - startTime) / 1000000000.0);

        Object obj = req.getSession().getAttribute("table");
        List<Point> table = new ArrayList<>();
        if(obj != null) {
            table = (List<Point>) obj;
        }
        Point pnt = new Point(xValue, yValue, rValue, execTime, isInside, time);
        table.add(pnt);
        req.getSession().setAttribute("table", table);
        req.getSession().setAttribute("point", pnt);

        getServletContext().getRequestDispatcher("/results.jsp").forward(req, resp);
    }

    private double parseX(String x) throws ServletException, IOException {
        double xTemp;
        xTemp = Double.parseDouble(x);
        if(xTemp < -5 || xTemp > 3) {
            error("x(" + xTemp + ") is out of range [-5;3]");
            return -111;
        }

        return xTemp;
    }

    private double parseY(String y) throws ServletException, IOException {
        double yTemp;
        yTemp = Double.parseDouble(y);
        if(yTemp < -3 || yTemp > 3) {
            error("y(" + yTemp + ") is out of range [-3;3]");
            return -111;
        }

        return yTemp;
    }

    private double parseR(String r) throws ServletException, IOException {
        double rTemp;
        rTemp = Double.parseDouble(r);
        if(rTemp < 1 || rTemp > 3) {
            error("r(" + rTemp + ") is out of range [1;3]");
            return -111;
        }

        return rTemp;
    }

    private void error(String r) throws ServletException, IOException {
        request.setAttribute("err_msg", r);
        getServletContext().getRequestDispatcher("/bad_data.jsp").forward(request, response);
    }

    private boolean isInsideCircle(Double x, Double y, Double r) {
        return (x <= 0 && y >= 0) && (x*x + y*y <= r*r/4);
    }

    private boolean isInsideTriangle(Double x, Double y, Double r) {
        return (x <= 0 && y <= 0) && (Math.abs(x + y) <= r);
    }

    private boolean isInsideSquare(Double x, Double y, Double r) {
        return (x >= 0 && y <= 0) && (x <= r && -y <= r);
    }
}