<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>${err_msg}</h1>
<form method="GET" action="${pageContext.request.contextPath}">
    <input type="submit" value='Вернуться на главную'>
</form>
</body>
</html>
