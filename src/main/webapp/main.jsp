<%@ page import="data.Point" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ru">
<head>
    <script src="js/jquery-3.5.1.min.js"></script>
    <title>Табличная вёрстка</title>
    <style>
        table#form {
            width: 100%;
            padding: 5%;
        }
        table#footer {
            border: 2px double;
            width: 100%;
        }
        input:hover {
            background-color: red;
        }
        body {
            background-color:maroon;
            color: aliceblue;
        }
        tr#header {
            font-family: serif;
            font-size: 30px;
        }
        img {
            border-radius: 90%;
        }

    </style>
</head>
<body>

<table id="form">
    <tr id="header">
        <th id="time" align="right"></th>
        <th colspan=2 align="left">Клименко Вячеслав P32081 Вар. 5432</th>
    </tr>
    <tr>
        <td>
            <canvas id="graph" alt="график"></canvas>
        </td>
        <td>
            <form>
                <fieldset>
                    <p>Введите X:
                        <input type="radio" name="X" value="-5" checked>-5
                        <% for(int i=-4;i<=3;i++) {
                            out.println("<input type='radio' name='X' class='X' value='"+ i +"'>"+ i);
                        }
                        %>
                    <p>Введите Y:<input type="text" placeholder="от -3 до 3" value="0" class="Y" pattern="^-?\d+.?\d*(?:e-?\d+)?$"></p>
                    <p>Введите R:
                        <input type="radio" name="R" value="1" checked>1
                        <% for(double i = 1.5; i <= 3; i += 0.5) {
                            out.println("<input type='radio' name='R' class='R' value='"+ i +"'>"+ i);
                        }
                        %>
                    </p>
                    <p id="coordinates"></p>
                    <input type="button" id="submit" value="Рассчитать" onclick="subm();">
                </fieldset>
            </form>
        </td>
    </tr>
    <script type="text/javascript">
        let xCoord = -5;
        let yCoord = 0;
        let rCoord = 1;
        let cnvs = document.getElementById('graph');
        let ctx = cnvs.getContext('2d');
        cnvs.height = cnvs.width;

        ctx.lineWidth = 2;
        ctx.moveTo(150,0);
        ctx.lineTo(150,300);
        ctx.stroke();
        ctx.moveTo(0, 150);
        ctx.lineTo(300, 150);
        ctx.stroke();
        ctx.fillStyle = 'rgb(51,153,255)';
        ctx.fillRect(150,150, 120, 120);
        ctx.strokeRect(150,150, 120, 120);
        ctx.beginPath();
        ctx.moveTo(30, 150);
        ctx.lineTo(150, 270);
        ctx.lineTo(150, 150);
        ctx.lineTo(30, 150);
        ctx.closePath();
        ctx.stroke();
        ctx.fillStyle = 'rgb(51,153,255)';
        ctx.fill();
        ctx.moveTo(150, 150);
        ctx.arc(150, 150, 60, Math.PI, Math.PI * 1.5);
        ctx.fillStyle = 'rgb(51,153,255)';
        ctx.fill();
        ctx.lineTo(150, 150);
        ctx.stroke();

        ctx.font = "14px Calibri";
        ctx.textAlign = "center";
        ctx.fillStyle = "black";
        ctx.moveTo(150 + 60, 150 - 5);
        ctx.lineTo(150 + 60, 150 + 5);
        ctx.stroke();
        ctx.fillText("R/2", 150 + 60, 140);
        ctx.moveTo(150 + 120, 150 - 5);
        ctx.lineTo(150 + 120, 150 + 5);
        ctx.stroke();
        ctx.fillText("R", 150 + 120, 140);
        ctx.moveTo(150 - 60, 150 - 5);
        ctx.lineTo(150 - 60, 150 + 5);
        ctx.stroke();
        ctx.fillText("-R/2", 150 - 60, 140);
        ctx.moveTo(150 - 120, 150 - 5);
        ctx.lineTo(150 - 120, 150 + 5);
        ctx.stroke();
        ctx.fillText("-R", 150 - 120, 140);

        ctx.textAlign = "left";
        ctx.moveTo(150 - 5, 150 - 120);
        ctx.lineTo(150 + 5, 150 - 120);
        ctx.stroke();
        ctx.fillText("R", 160, 150 - 120);
        ctx.moveTo(150 - 5, 150 - 60);
        ctx.lineTo(150 + 5, 150 - 60);
        ctx.stroke();
        ctx.fillText("R/2", 160, 150 - 60);
        ctx.moveTo(150 - 5, 150 + 60);
        ctx.lineTo(150 + 5, 150 + 60);
        ctx.stroke();
        ctx.fillText("-R/2", 160, 150 + 60);
        ctx.moveTo(150 - 5, 150 + 120);
        ctx.lineTo(150 + 5, 150 + 120);
        ctx.stroke();
        ctx.fillText("-R", 160, 150 + 120);

        function convertX(xTemp, rTemp) {
            return 150 + xTemp * (120 / rTemp);
        }

        function convertY(yTemp, rTemp) {
            return 150 + -yTemp * (120 / rTemp);
        }

        function drawDotOnGraph(tx, ty, hit) {
            console.log("x=" + tx);
            console.log("y=" + ty);
            ctx.fillStyle = hit ? 'lime' : 'red';
            ctx.fillRect(tx - 1, ty - 1, 5, 5);
        }

        function getMousePosition(e) {
            const rect = cnvs.getBoundingClientRect()
            const x = e.clientX - rect.left
            const y = e.clientY - rect.top
            return {x: x, y: y};
        }

        cnvs.addEventListener('click', (event) => {
            if (!isNaN(rCoord)) {
                const x = getMousePosition(event).x;
                const y = getMousePosition(event).y;
                const trueX = Math.round((x - 150) * rCoord / 120 * 1000) / 1000;
                const trueY = Math.round((y - 150) * -rCoord / 120 * 1000) / 1000;
                if(trueX < -5 || trueX > 3) {
                    alert("x coord out of range [-5;3]");
                    return;
                }
                if(trueY < -3 || trueY > 3) {
                    alert("y coord out of range [-3;3]");
                    return;
                }
                xCoord = trueX;
                yCoord = trueY;
                // console.log((x - 150) * rCoord / 120);
                // console.log((y - 150) * -rCoord / 120);
                window.location.replace("controller?x='"+xCoord+"'&y='"+yCoord+"'&r='"+rCoord+"'");
            } else {
                alert("Error: R field is incorrect!")
            }
        });

        function subm() {
            $.ajax({
                method: 'GET',
                url: 'controller',
                data: {x: xCoord, y: yCoord, r: rCoord},
                success: function(data){
                    window.location.replace("results.jsp");
                }
            });
        }

        function chooseX(e) {
            xCoord = parseFloat(e.target.value);
            updateValues();
        }

        function chooseY(e) {
            yCoord = parseFloat(e.target.value);
            submit.removeAttribute('disabled');
            if(isNaN(yCoord) || yCoord < -3 || yCoord > 3){
                submit.setAttribute('disabled', true);
            }
            updateValues();
        }

        function chooseR(e) {
            rCoord = parseFloat(e.target.value);
            updateValues();
        }

        function updateValues() {
            coordinates.innerHTML = "X= " + xCoord + "; Y= " + yCoord + "; R= " + rCoord;
        }

        updateValues();

        const xChoose = document.querySelectorAll(".X");
        for (let i = 0; i < xChoose.length; i++) {
            xChoose[i].onclick = chooseX;
        }

        const yChoose = document.querySelector(".Y");
        yChoose.oninput = chooseY;

        const rChoose = document.querySelectorAll(".R");
        for (let i = 0; i < rChoose.length; i++) {
            rChoose[i].onclick = chooseR;
        }

        function getTime() {
            const date = new Date();
            let hours = date.getHours();
            let min = date.getMinutes();
            let sec = date.getSeconds();

            if(hours < 10) {
                hours = '0' + hours;
            }
            if(min < 10) {
                min = '0' + min;
            }
            if(sec < 10) {
                sec = '0' + sec;
            }
            document.getElementById('time').innerHTML = hours + ':' + min + ':' + sec;
        }
        setInterval(getTime, 0);
    </script>
    <jsp:include page="full_table.jsp"/>
</table>
</body>
</html>
