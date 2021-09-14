<%@ page import="com.clinic.models.Doctor" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.clinic.models.Appointments" %>
<%@ page import="javax.print.Doc" %>
<%
    ArrayList<Doctor> app1 = (ArrayList<Doctor>) request.getAttribute("doctors");
    ArrayList<Appointments> app2 = (ArrayList<Appointments>) request.getAttribute("appointments");
    String username = (String) request.getAttribute("session");
    String profile = (String) request.getAttribute("profile");
    String pic = (String) request.getAttribute("pic");
    String specialities = "";%>

<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link href="${pageContext.request.contextPath}/resources/Content/appointment.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/Content/header.css" rel="stylesheet" />
</head>
<body style="
        background-image: url('${pageContext.request.contextPath}/resources/imgs/price-bg.png');
        background-size: 100%;">
    <header>
        <div class="header-top">
            <img class="navbar-brand" src="${pageContext.request.contextPath}/resources/imgs/logo black.png" alt="image" />
            <%if (username.length() != 0)
            {%>
                <div class="session-info">
                    <text class="profileinfo"><%=profile%>:</text>
                    <form>
                        <a href="PatientProfile" target="_self"><img src="${pageContext.request.contextPath}/resources/Patient pics/<%=pic%>" id="profile_link" /></a>
                        <text class="userinfo"><%=username%></text>
                    </form>     
                </div>
            <%}%>
        </div>
        <div class="header-bottom">
            <div class="navbar">
                <a href="Home" target="_self">Home</a>
                <a class="active" href="Appointment">Appointments</a>
                <a href="Doctors" target="_self">Doctors</a>
                <a href="Reviews">Reviews</a>
                <a data-scroll href="#footer-distributed">Contact</a>
                <a href="About">About us</a>
            </div>
            <div class="login-container">
                <% if (username.length() == 0)
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
    <div class="main">
        <%if (app2 == null)
        {%>

            <div id="booking" class="section">
                <div class="booking-cta">
                    <h1>Book your Appointments</h1>
                    <p>Your Health Your Choice</p>
                </div>
            </div>

            <form method="post" action="get_available_appointments">
                <div class="booking-form" id="c1" name="c1">
                    <div class="form-group">
                        <span class="form-label">Date For Appointment</span>
                        <input class="form-control" id="appointment_date" name="appointment_date" placeholder="Select Date" type="text" onfocus="(this.type='date')" required>
                    </div>
                    <div class="form-group">
                        <label class="l1" id="l1" name="l1">&nbsp;&nbsp;Available Doctors:&nbsp;&nbsp;&nbsp;&nbsp;</label>
                        <select name="doctor" id="doctor">
                            <%if (app1 != null)
                            {
                                Doctor temp = new Doctor();
                                for(int i = 0; i < app1.size(); i++)
                                {
                                    temp = app1.get(i);
                                    specialities = "";
                                    String temp2 = "";
                                    for(int j = 0; j < temp.specializations.size(); j++)
                                    {
                                        temp2 = temp.specializations.get(j);
                                        specialities = specialities + temp2;
                                        specialities = specialities + " ";
                                    } %>
                                    <option class="doctor_chosen" id="doctor_chosen" name="doctor_chosen" value="<%=temp.DocID%>"><%=temp.Name + "(" + specialities + ")"%></option>
                                <%}
                            }%>
                        </select>
                    </div>
                    <div class="form-btn">
                        <button class="submit-btn">Check Availability</button>
                    </div>
                </div>
            </form>
        <%}
        if (app2 != null)
        {%>
            <form method="post" action="book_appointments">
                <div class="table-users">
                    <div class="heading">AVAILABLE APPOINTMENTS</div>
                    <table cellspacing="0">
                        <tr>
                            <th>Starting Time</th>
                            <th>Ending Time</th>
                            <th>Doctor Name</th>
                            <th>Booking</th>
                        </tr>
                        <% Appointments temp3 = new Appointments();
                        for(int i =0; i < app2.size(); i++)
                        {   temp3 = app2.get(i);
                        %>
                            <tr>
                                <td><%=temp3.starting_time%></td>
                                <td><%=temp3.ending_time%></td>
                                <td><%=temp3.doctor_name%></td>
                                <td><button class="book_btn" name="book_btn" value="<%=temp3.starting_time%>">Book me</button></td>

                            </tr>
                        <%}%>
                    </table>
                </div>
            </form>
        <%}%>
    </div>
</body>
</html>