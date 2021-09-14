<%@ page import="com.clinic.models.Doctor" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="javax.print.Doc" %>
<%  String username = (String) request.getAttribute("session");
    String profile = (String) request.getAttribute("profile");
    ArrayList<Doctor> Doctors = (ArrayList<Doctor>) request.getAttribute("Doctors");
    String specialities = "";%>

<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="${pageContext.request.contextPath}/resources/Content/doctors.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/Content/header.css" rel="stylesheet" />
</head>
<body>
    <header>
        <div class="header-top">

            <img class="navbar-brand" src="${pageContext.request.contextPath}/resources/Content/imgs/logo black.png" alt="image" />
            <%if (username.length() != 0)
            { %>
                <div class="session-info">
                    <text class="profileinfo"><%=profile%>:</text>
                    <text class="userinfo"><%=username%></text>
                </div>
            <%}%>

        </div>
        <div class="header-bottom">
            <div class="navbar">
                <a href="Home" target="_self">Home</a>
                <a href="Booked_Appointments">Booked Appointments</a>
                <a class="active" href="All_Doctors">Doctors</a>
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

    <div class="main-container" style="padding-top:1%;">
        <div class="add_button">
            <form method="post" action="Register_Doctor">
                <button class="bttn-jelly bttn-lg bttn-primary">Add Doctor</button>
            </form>
        </div>

        <div class="table-users">
            <div class="header">Doctors</div>

            <table cellspacing="0">
                <tr>
                    <th>Picture</th>
                    <th>Name</th>
                    <th>Specializations</th>
                    <th>Age</th>
                    <th>Email</th>
                    <th>City</th>
                    <th>Phone</th>
                    <th>Fee</th>
                </tr>

                <%
                Doctor temp =  new Doctor();
                for(int i = 0; i < Doctors.size(); i++)
                {  temp = Doctors.get(i);
                %>
            <tr>
                <td>
                    <img src="${pageContext.request.contextPath}/resources/Doctor pics/<%=temp.img%>" alt="Pic" />
                </td>
                <td><%=temp.Name%></td>
                <% String sp = "";
                for(int j = 0; j < temp.specializations.size(); j++)
                {
                    sp = temp.specializations.get(j);
                    specialities = specialities + sp;
                    specialities = specialities + " ";
                } %>
                <td><%=specialities%></td>
                <td><%=temp.Name%></td>
                <td><%=temp.Email%></td>
                <td><%=temp.City%></td>
                <td><%=temp.Phone%></td>
                <td><%=temp.Fee%></td>
            </tr>

                   <% specialities = "";
                }%>
            </table>
        </div>
    </div>
</body>
</html>