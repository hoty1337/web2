<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="data.Point" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%
    Object obj = request.getSession().getAttribute("table");
    List<Point> table = new ArrayList<>();
    if(obj != null) {
        table = (List<Point>) obj;
    }
%>
<html>
<head>
<%--    <script src="js/graph.js"></script>--%>
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
    <%  int i = 0;
        for(int j = table.size() - 1; j >= 0 && i++ < 10; j--) { Point point = table.get(j);%>
    <tr>
        <td><%=point.getX()%></td>
        <td><%=point.getY()%></td>
        <td><%=point.getR()%></td>
        <td style='color:<%=(point.isInside() ? "lime" : "red")%>'>
            <%=point.isInside() ? "Попадание." : "Нет попадания."%></td>
        <td><%=point.getExecTime()%></td>
    </tr>
    <script>drawDotOnGraph(convertX(<%=point.getX()%>, <%=point.getR()%>),
        convertY(<%=point.getY()%>, <%=point.getR()%>), <%=point.isInside()%>)</script>
    <%}%>
</table>

</body>
</html>
