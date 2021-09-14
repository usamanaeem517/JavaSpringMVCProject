<%@ page import="com.clinic.models.Doctor" %>
<%@ page import="java.util.ArrayList" %>

<% ArrayList<Doctor> Doctors = (ArrayList<Doctor>) request.getAttribute("doctors");
    String username = (String) request.getAttribute("session");
    String profile = (String) request.getAttribute("profile");
    String pic = (String) request.getAttribute("pic");
    String specialities=""; %>
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

            <img class="navbar-brand" src="${pageContext.request.contextPath}/resources/imgs/logo black.png" alt="image" />
            <% if (username.length() != 0)
            {%>
                <div class="session-info">
                    <text class="profileinfo"><%=profile%>:</text>
                    <% if (profile.charAt(0) == 'P')
                    {%>
                        <form>
                            <a href="PatientProfile" target="_self"><img src="${pageContext.request.contextPath}/resources/Patient pics/<%=pic%>" id="profile_link" /></a>
                            <text class="userinfo"><%=username%></text>
                        </form>
                    <%}
                    else if (profile.charAt(0) == 'D')
                    {%>
                        <form>
                            <a href="DoctorProfile" target="_self"><img src="${pageContext.request.contextPath}/resources/Doctor pics/<%=pic%>" id="profile_link" /></a>
                            <text class="userinfo"><%=username%></text>
                        </form>
                    <%}%>
                </div>
            <%}%>

        </div>
        <div class="header-bottom">
            <div class="navbar">
                <% if (profile.charAt(0) == 'D')
                {%>
                    <a href="Home" target="_self">Home</a>
                    <a href="DoctorAppointments" target="_self">My Appointments</a>
                    <a class="active" href="Doctors" target="_self">Doctors</a>
                    <a href="Reviews">Reviews</a>
                    <a data-scroll href="#footer-distributed">Contact</a>
                    <a data-scroll href="About">About us</a>
                <%}
                else
                {%>
                    <a href="Home" target="_self">Home</a>
                    <a href="Appointment" target="_self">Appointments</a>
                    <a class="active" href="Doctors" target="_self">Doctors</a>
                    <a href="Reviews">Reviews</a>
                    <a data-scroll href="#footer-distributed">Contact</a>
                    <a href="About">About us</a>
                <%}%>
            </div>
            <div class="login-container">
                <%if (username.length() == 0)
                {%>
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

    <div class="main-image">
    <div class="main-text">
        <h1 style="font-size:45px;width:600px">Professional Doctors</h1>
        <p>Our doctors are licensed health professionals who maintain
        and restore human health through the practice of medicine.
        They examine patients, review their medical history,
        diagnose illnesses or injuries, administer treatment
        and counsel patients on their health and well being.</p>
    </div>
    </div>
    <div class="main-container" style="background:#f4f3e5">
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
            </tr>
            <%
                Doctor temp = new Doctor();
            for (int i = 0; i < Doctors.size(); i++)
            {
                temp = Doctors.get(i); %>
                <tr>
                    <td>
                        <img src="${pageContext.request.contextPath}/resources/Doctor pics/<%=temp.img%>" alt="" />
                    </td>
                    <td><%= temp.Name%></td>

                    <%
                        String sp = "";
                    for (int j = 0; j < temp.specializations.size(); j++)
                    {
                        sp = temp.specializations.get(j);
                        specialities = specialities.concat(sp);
                        specialities = specialities.concat(" ");
                    }%>
                    <td><%=specialities%></td>
                    <td><%=temp.Age%></td>
                    <td><%=temp.Email%></td>
                    <td><%=temp.City%></td>
                </tr>
<%
                specialities = "";
            }%>
        </table>
    </div>
        </div>
</body>
</html>