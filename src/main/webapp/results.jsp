<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="data.Point" %>
<%
    Object obj = request.getSession().getAttribute("point");
    Point point = new Point();
    if(obj != null) {
        point = (Point) obj;
    }
%>
<html>
    <head>
        <title>Result check</title>
        <style>
            table {
            width: 100%;
            padding: 5%;
            }
        </style>
    </head>
    <body>
    <table>
        <tr>
            <td>X</td>
            <td>Y</td>
            <td>R</td>
            <td>Попадание</td>
            <td>Время работы скрипта, с</td>
        </tr>
        <tr>
            <td><%=point.getX()%></td>
            <td><%=point.getY()%></td>
            <td><%=point.getR()%></td>
            <td style='color:<%=(point.isInside() ? "lime" : "red")%>'>
                <%=point.isInside() ? "Попадание." : "Нет попадания."%></td>
            <td><%=point.getExecTime()%></td>
            <td class="form">
                <form method="GET" action="${pageContext.request.contextPath}">
                    <input type="submit" value='Вернуться на главную'>
                </form>
            </td>
        </tr>

    </table>

    </body>
</html>
