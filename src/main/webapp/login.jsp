<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <div style="
    border-style: double;
    background: yellow;
    position: absolute;
    top: 50%;
    left: 50%;
    margin: 0 -50% 0 0;
    transform: translate(-50%, -50%);
    text-align: center;">
        <h2>Login Page</h2>
        <form method="POST" action="login">
            <table>
                <tr>
                    <td>User Name</td>
                    <td><input type="text" name="username"/></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td><input type="password" name="password"/></td>
                </tr>
                <tr>
                    <td colspan ="2">
                        <input type="submit" value= "Submit" />
                        <a href="">Cancel</a>
                    </td>
                </tr>
                <tr>
                    <p style="color: red;"> ${errorMessage}</p>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
