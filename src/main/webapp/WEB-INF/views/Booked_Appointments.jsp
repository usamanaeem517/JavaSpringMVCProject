<%@ page import="com.clinic.models.Appointments" %>
<%@ page import="java.util.ArrayList" %>

<%  String username = (String) request.getAttribute("session");
    String profile = (String) request.getAttribute("profile");
    ArrayList<Appointments> apps = (ArrayList<Appointments>) request.getAttribute("appointments");%>
<!DOCTYPE html>

<html lang="en">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="${pageContext.request.contextPath}/resources/Content/doctors.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/Content/header.css" rel="stylesheet" />
</head>

<body>
    <header>
        <div class="header-top">

            <img class="navbar-brand" src="${pageContext.request.contextPath}/resources/imgs/logo black.png" alt="image" />
            <%if (username.length() != 0)
            {%>
                <div class="session-info">
                    <text class="profileinfo"><%=profile%>:</text>
                    <text class="userinfo"><%=username%></text>
                </div>
            <%}%>

        </div>
        <div class="header-bottom">
            <div class="navbar">
                <a href="Home" target="_self">Home</a>
                <a class="active"href="Booked_Appointments">Booked Appointments</a>
                <a href="All_Doctors">Doctors</a>
                <a href="All_Patients">Patients</a>
                <a href="All_Bills_Info">Bills</a>
                <a href="Reviews">Reviews</a>
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

    <div class="main-container">
        <div class="add_button">
              <form method="post" action="AddAppointments">
                      <button class="bttn-jelly bttn-lg bttn-primary">Add Next Week Appointments</button>
                
            </form>
        </div>
        <div class="table-users">
            <div class="header">Booked Appointments</div>

            <table cellspacing="0">
                <tr>
                    <th>Date</th>
                    <th>Starting Time</th>
                    <th>Ending Time</th>
                    <th>Patient Name</th>
                    <th>Doctor Name</th>
                </tr>

                <% Appointments data = new Appointments();
                for(int i = 0; i < apps.size(); i++)
                {   data = apps.get(i);
                %>
                    <tr>
                        <td><%=data.app_date%></td>
                        <td><%=data.starting_time%></td>
                        <td><%=data.ending_time%></td>
                        <td><%=data.patient_name%></td>
                        <td><%=data.doctor_name%></td>
                    </tr>
                <%}%>
            </table>
        </div>
    </div>


</body>
</html>