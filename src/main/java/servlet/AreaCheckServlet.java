package servlet;

import data.Point;
import exception.IncorrectDataException;

import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "AreaCheckServlet", value = "/check")
public class AreaCheckServlet extends HttpServlet {

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        resp.setContentType("text/html");
        long startTime = System.nanoTime();

        String x = req.getParameter("x");
        String y = req.getParameter("y");
        String r = req.getParameter("r");
        double xValue, yValue, rValue;

        try {
            if(x == null || x.equals("")) throw new IncorrectDataException("x is not set");
            if(y == null || y.equals("")) throw new IncorrectDataException("y is not set");
            if(r == null || r.equals("")) throw new IncorrectDataException("r is not set");

            xValue = parseX(x.trim().replace("'", ""));
            yValue = parseY(y.trim().replace("'", ""));
            rValue = parseR(r.trim().replace("'", ""));

            boolean isInside = isInsideCircle(xValue, yValue, rValue) ||
                    isInsideTriangle(xValue, yValue, rValue) ||
                    isInsideSquare(xValue, yValue, rValue);

            long time = System.currentTimeMillis() / 1000000;

            String execTime = String.format("%.9f", (System.nanoTime() - startTime) / 1000000000.0);

            Object obj = req.getSession().getAttribute("table");
            List<Point> table;
            if(obj != null) {
                table = (List<Point>) obj;
            } else {
                table = new ArrayList<>();
            }
            Point pnt = new Point(xValue, yValue, rValue, execTime, isInside, time);
            table.add(pnt);
            req.getSession().setAttribute("table", table);
            req.getSession().setAttribute("point", pnt);

            getServletContext().getRequestDispatcher("/results.jsp").forward(req, resp);

        } catch (IncorrectDataException e) {
            req.setAttribute("err_msg", e.getMessage());
            getServletContext().getRequestDispatcher("/bad_data.jsp").forward(req, resp);
        }
    }

    private double parseX(String x) throws IncorrectDataException {
        double xTemp;
        xTemp = Double.parseDouble(x);
        if(xTemp < -5 || xTemp > 3) throw new IncorrectDataException("x(" + xTemp + ") is out of range [-5;3]");

        return xTemp;
    }

    private double parseY(String y) throws IncorrectDataException {
        double yTemp;
        yTemp = Double.parseDouble(y);
        if(yTemp < -3 || yTemp > 3) throw new IncorrectDataException("y(" + yTemp + ") is out of range [-3;3]");

        return yTemp;
    }

    private double parseR(String r) throws IncorrectDataException {
        double rTemp;
        rTemp = Double.parseDouble(r);
        if(rTemp < 1 || rTemp > 3) throw new IncorrectDataException("r(" + rTemp + ") is out of range [1;3]");

        return rTemp;
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