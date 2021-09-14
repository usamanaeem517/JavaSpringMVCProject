<%@ page import="com.clinic.models.Doctor" %>
<%@ page import="java.util.Locale" %>
<%  String username = (String) request.getAttribute("session");
    String profile = (String) request.getAttribute("profile");
    String pic = (String) request.getAttribute("pic");
    Doctor doc = (Doctor) request.getAttribute("doctorprofile");
    String specialities="";%>
<!DOCTYPE html>
<html>
<head>
    <link href="${pageContext.request.contextPath}/resources/Content/header.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/Content/doctorprofile.css" rel="stylesheet" />
</head>
<body>
    <header style="margin-top:-2%;">
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
           <% } %>

        </div>
        <div class="header-bottom">
            <div class="navbar">
                <a href="Home" target="_self">Home</a>
                <a href="DoctorAppointments" target="_self">My Appointments</a>
                <a href="Doctors" target="_self">Doctors</a>
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
    <div class="conatiner">

        <div class="hello_cell">
            <a class="hello">Profile</a>
        </div>
        <div class="profile">
            <div class="profile_picture">
                <a id="picture">
                    <img src="${pageContext.request.contextPath}/resources/Doctor pics/<%=doc.img%>" />
                </a>
            </div>
            <div class="information">
                <div class="profile_name">
                    <a class="name"><%=doc.Name%></a>
                </div>
                <div class="profile_cell">
                    <span>
                        <a class="pre_info">Gender :</a>
                        <a style="margin-left:10%; " class="info"><%=doc.Gender%></a>
                    </span>
                </div>

                <div class="profile_cell">
                    <span>
                        <a class="pre_info">Age :</a>
                        <a style="margin-left:13.5%;" class="info"><%=doc.Age%></a>
                    </span>
                </div>

                <div class="profile_cell">
                    <span>
                        <a class="pre_info">Email :</a>
                        <a style="margin-left:12%;" class="info"><%=doc.Email%></a>
                    </span>
                </div>

                <div class="profile_cell">
                    <span>
                        <a class="pre_info">Phone Number :</a>
                        <a style="margin-left:3.5%;" class="info"><%=doc.Phone%></a>
                    </span>
                </div>

                <div style="padding-bottom:1%; " class="profile_cell">
                    <span>
                        <a class="pre_info">Specializations :</a>
                        <% String sp = "";
                        for(int i = 0; i < doc.specializations.size(); i++)
                        {
                            sp = sp.concat(doc.specializations.get(i));
                            specialities = specialities.concat("(");
                            specialities = specialities.concat(sp);
                            specialities = specialities.concat(")");
                            specialities = specialities.concat(" ");
                            sp = "";
                        }%>
                        <a style="margin-left:3.5%;" class="info"><%=specialities%></a>
                    </span>
                </div>

            </div>

        </div>
    </div>
    <div class="time_container">
        <form method="post" action="UpdateDoctorTime" onsubmit="return time_check()">
            <a class="hello">Availability Time</a>
            <br />
            <br />
            <label style="font-size:24px;color:black;font-weight:600;margin-left:6%">Starting Time:</label>
            <text style="font-size:20px;margin-left:1%;"><%=doc.start_time%></text>

            <label style="font-size:24px;color:black;font-weight:600;margin-left:15%">Ending Time:</label>
            <text style="font-size:20px;margin-left:1%;"><%=doc.end_time%></text>
            <br />
            <br />
            <input type="text" placeholder="Starting time(HH:MM 24hrs 30 min slot)" class="box" id="start_box" name="start_box" required />
            <input type="text" placeholder="Ending time(HH:MM 24hrs 30 min slot)" class="box" id="end_box" name="end_box" required />
            <button id="update_bt" name="update_bt" value=<%=doc.DocID%> submit">Update</button>
        </form>
    </div>

    <script>
        function time_check()
        {
            var start = document.getElementById('start_box').value;
            var end = document.getElementById('end_box').value;
            var flag = true;

            var temp = start.slice(0,2);

            if (parseInt(temp) >= 8 && parseInt(temp) <= 22) {
                if (start[2] != ':') {
                    flag = false;
                }
                if (start[4] != '0')
                    flag = false;


                if (start[3] == '3' || start[3] == '0')
                    "sss";
                else
                    flag = false;

            }
            else {
                flag = false;
            }
            if (flag == false) {
                document.getElementById('start_box').value = "";
                document.getElementById('start_box').style.backgroundColor = "#fe4747";
            }
            else
                document.getElementById('start_box').style.backgroundColor = "#eee";

            var flag1 = true;
            temp = end.slice(0, 2);

            if (parseInt(temp) >= 8 && parseInt(temp) <= 22) {
                if (end[2] != ':')
                    flag1 = false;
                if (end[4] != '0')
                    flag1 = false;


                if (end[3] == '3' || end[3] == '0')
                    "sss";
                else
                    flag1=false;

            }
            else {
                flag1 = false;
            }
            if (flag1 == false) {
                document.getElementById('end_box').value = "";
                document.getElementById('end_box').style.backgroundColor = "#fe4747";
            }
            else
                document.getElementById('end_box').style.backgroundColor = "#eee";

            if (flag1 == false || flag == false)
                return false;
            else
                return true;
        }
    </script>
</body>
</html>