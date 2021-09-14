<%@ page import="java.util.ArrayList" %>
<%@ page import="com.clinic.models.Appointments" %>

<%  String username = (String) request.getAttribute("session");
    String profile = (String) request.getAttribute("profile");
    String pic = (String) request.getAttribute("pic");
    ArrayList<Appointments> apps = (ArrayList<Appointments>) request.getAttribute("myapps");%>

<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        @import url('owl.carousel.css');
        * {
            box-sizing: border-box;
        }


        body {
            background: linear-gradient(to bottom, #0795ff,#30FFB7);
            color: #999;
            font-size: 15px;
            font-family: 'Source Sans Pro', sans-serif;
            line-height: 1.60857;
            margin: 0;
        }

        header {
        }

        .header-top {
            background-color: white;
            height: 180px;
        }

        .navbar-brand {
            width: 270px;
            height: 60px;
            margin-top: 100px;
            margin-left: 120px;
        }

        .session-info {
            float: right;
            width: 25%;
            margin-top:7%;
            height:40%;
        }

        #profile_link {
            background-size: cover;
            background-position:center;
            height: 60px;
            width: 60px;
            outline: none;
            margin-top:-25%;
            border-radius: 100%;
            cursor: pointer;
        }

        #profile_link:hover {
            box-shadow: 0 10px 14px 0 rgba(0,0,0,0.24), 0 15px 48px 0 rgba(0,0,0,0.19);
            transition: all 0.3s ease-in-out;
            transform: scale(1.1);
        }
        .profileinfo {
            float: left;
            font-size: 30px;
            font-weight:500;
            margin-top: 3%;
            color: #0795ff;
        }
        .userinfo {
            font-size: 20px;
            color: #121111;
            position: absolute;
            margin-top: 1.5%;
        }

        .header-bottom {
            position: sticky;
            width: 100%;
            background: linear-gradient(to right, #0795ff,#30FFB7);
            box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
            list-style-type: none;
            overflow: hidden;
        }

        .navbar {
            margin-top: 0;
            padding-left: 120px;
        }

        header a {
            float: left;
            margin-bottom: 5px;
            display: block;
            color: white;
            text-align: center;
            padding: 18px;
            font-size: 20px;
            text-decoration: none !important;
            outline: none !important;
            -webkit-transition: all .3s ease-in-out;
            -moz-transition: all .3s ease-in-out;
            -o-transition: all .3s ease-in-out;
            transition: all .3s ease-in-out;
        }

        .navbar > a:hover, .navbar > a:focus, .navbar > .active {
            color: #fff;
            background: #14d897;
            box-shadow: 5px 5px 0 0px #fff;
        }


        .header-bottom .login-container {
            float: right;
            margin-right: 60px;
            margin-top: 10px;
        }

        .login-container button {
            border-radius: 40px;
            background-color: #0795ff;
            color: #FFFFFF;
            border-color:aliceblue;
            outline:none;
            font-size: 18px;
            font-weight: bold;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: transform 80ms ease-in;
            cursor: pointer;
            -webkit-transition-duration: 0.4s;
            transition-duration: 0.4s;
            padding: 12px 40px;
        }

        .login-container button:active {
            transform: scale(0.95);
        }

        .login-container button:hover {
            transition: 0.3s ease-in-out;
            background: #14d897;
        }

    </style>
    <style>
        body {
            margin: 0;
        }

        .main {
            background: linear-gradient(to bottom, #0795ff,#30FFB7);
            background-size: cover;
            font-family: 'Source Sans Pro', sans-serif;
            height: 100vh;
        }

        .table-users {
            border: 1.5px solid rgba(0,0,0,0.4);
            border-radius: 10px;
            box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.4);
            max-width: calc(100% - 2em);
            margin: 1em auto;
            overflow: hidden;
            width: 100%;
            font-weight: 500;
        }

        .heading {
            background-color: #077cff;
            font-size: 28px;
            padding: 22px;
            font-weight: 500;
            color: rgba(0, 0, 0, 0.8);
            text-align: center;
        }

        table {
            width: 100%;
        }

        table td, table th {
            color: rgba(0,0,0,0.8);
            padding: 10px;
            font-size: 22px;
        }

        table td {
            text-align: center;
            vertical-align: middle;
            padding: 20px;
        }


        table th {
            background-color: #55b6ff;
            font-weight: 600;
        }

        table tr:nth-child(2n) {
            background-color: white;
        }

        table tr:nth-child(2n+1) {
            background-color: #e1e9ff;
        }

        .see_btn {
            border-radius: 40px;
            background-color: #ff2e2e;
            color: #FFFFFF;
            outline: none;
            font-size: 18px;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: transform 80ms ease-in;
            cursor: pointer;
            -webkit-transition-duration: 0.4s;
            transition-duration: 0.4s;
            padding: 12px 40px;
        }

        .see_btn:active {
            transform: scale(0.95);
        }

        .see_btn:hover {
            transition: 0.3s ease-in-out;
            background: #14d897;
        }

    </style>
</head>
<body>
    <header>
        <div class="header-top">

            <img class="navbar-brand" src="${pageContext.request.contextPath}/resources/imgs/logo black.png" alt="image" />
            <%if (username.length() != 0)
            {%>
                <div class="session-info">
                    <text class="profileinfo"><%=profile%>:</text>
                    <form>
                        <a href="DoctorProfile" target="_self"><img src="${pageContext.request.contextPath}/resources/Doctor pics/<%=pic%>" id="profile_link" /></a>
                        <text class="userinfo"><%=username%></text>
                    </form>
                </div>
            <%}%>

        </div>
        <div class="header-bottom">
            <div class="navbar">
                <a href="Home" target="_self">Home</a>
                <a class="active" href="DoctorAppointments" target="_self">My Appointments</a>
                <a href="Doctors" target="_self">Doctors</a>
                <a href="Reviews" target="_self">Reviews</a>
                <a data-scroll href="#footer-distributed">Contact</a>
                <a href="About">About us</a>
            </div>
            <div class="login-container">
                <%if (username.length() == 0)
                { %>
                    <form method="post" action="index.jsp">
                        <button type="submit">Login</button>
                    </form>
                <%}
                else
                {%>
                    <form method="post" action="Logout">
                        <button type="submit">Logout</button>
                    </form>
                <%}%>
            </div>
        </div>
    </header>
    <% if(apps != null){%>
    <div class="main">
        <form method="post" action="TakeAppointment">
            <div class="table-users">
                <div class="heading">MY APPOINTMENTS</div>
                <table cellspacing="0">
                    <tr>
                        <th>Patient</th>
                        <th>Date</th>
                        <th>Starting Time</th>
                        <th>Ending Time</th>
                        <th>Take</th>
                    </tr>
                    <% Appointments temp =  new Appointments();
                    for(int i = 0; i < apps.size(); i++)
                    { temp = apps.get(i);
                    %>
                <tr>
                    <td><%=temp.patient_name%></td>
                    <td><%=temp.app_date%></td>
                    <td><%=temp.starting_time%></td>
                    <td><%=temp.ending_time%></td>
                    <td><button type="submit" class="see_btn" name="see_btn" value=<%=temp.app_id%>>See</button></td>

                </tr>
                   <% } %>
                </table>
            </div>
        </form>
    </div>
<% } %>
</body>
</html>