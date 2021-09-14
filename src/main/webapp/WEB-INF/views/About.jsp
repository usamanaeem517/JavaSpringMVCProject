<%  String username = (String) request.getAttribute("session");
    String profile = (String) request.getAttribute("profile");
    String pic = (String) request.getAttribute("pic");%>
<!DOCTYPE html>

<html>
<head>
    <link href="${pageContext.request.contextPath}/resources/Content/header.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/Content/about.css" rel="stylesheet" />
</head>
<body>
    <header>
        <div class="header-top">

            <img class="navbar-brand" src="${pageContext.request.contextPath}/resources/imgs/logo black.png" alt="image" />
            <%if (username.length() != 0)
            {%>
                <div class="session-info">
                    <text class="profileinfo"><%=profile%>:</text>
                    <%if (profile.charAt(0) == 'P')
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
                    <%}
                    else
                    {%>
                        <form>
                            <text class="userinfo"><%=username%></text>
                        </form>
                    <%}%>
                </div>
            <%}%>

        </div>
        <div class="header-bottom">
            <div class="navbar">
                <%if (profile.charAt(0) == 'D')
                {%>
                    <a href="Home" target="_self">Home</a>
                    <a href="DoctorAppointments" target="_self">My Appointments</a>
                    <a href="Doctors" target="_self">Doctors</a>
                    <a href="Reviews">Reviews</a>
                    <a data-scroll href="#footer-distributed">Contact</a>
                    <a class="active" href="About">About us</a>
                <%}
                else if (profile.charAt(0) == 'A')
                {%>
                    <a href="Home" target="_self">Home</a>
                    <a href="Booked_Appointments">Booked Appointments</a>
                    <a href="All_Doctors">Doctors</a>
                    <a href="All_Patients">Patients</a>
                    <a href="All_Bills_Info">Bills</a>
                    <a href="Reviews">Reviews</a>
                    <a data-scroll href="#footer-distributed">Contact</a>
                    <a class="active" href="About">About us</a>
                <%}
                else
                {%>
                    <a href="Home" target="_self">Home</a>
                    <a href="Appointment" target="_self">Appointments</a>
                    <a href="Doctors" target="_self">Doctors</a>
                    <a href="Reviews">Reviews</a>
                    <a data-scroll href="#footer-distributed">Contact</a>
                    <a class="active" href="About">About us</a>
                <%}%>
            </div>
            <div class="login-container">
                <% if (username.length() == 0)
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
    <section class="wrapper">
        <center>
            <div class="about">
                <br />
                <br />
                <br />
                <h1 style="font-size: 35px">VISION</h1>
                <p style="font-size: 18px; text-align: center; padding: 0 10%; color: black;">
                    We pride ouerselves on our exceptional standards of patient care.
                    Our clinians and staff are highly recommended for their skills and
                    their dedication to delivering best-in-class treatment and care .
                    Our exceptional and experienced staff is dedicated to improving
                    our patients’ dental health and enhancing smiles
                    . Our exceptional and experienced staff is dedicated to improving our patients
                    Experienced staff is dedicated to improving our patients’ dental health and enhancing.
                </p>
            </div>
        </center>
        <br />
        <hr />



        <center>
            <div class="meet">
                <h1 style="margin-top:3%;">MEET OUR TEAM</h1>
                <p>Meet Our Talented Human Resource.</p>
            </div>
        </center>

        <div class="highlights">
            <div class="section">
                <center>
                    <div class="head">
                        <div class="cont_forimage">
                            <a href="https://www.instagram.com/usamanaeem517/">
                                <img src="${pageContext.request.contextPath}/resources/imgs/usama.png" id="pic1" class="_theimage" alt="image" />

                            </a>
                            <div class="middle_forimage">
                                <a href="https://www.instagram.com/usamanaeem517/">
                                    <img src="${pageContext.request.contextPath}/resources/imgs/insta_logo.png" class="_logo" style="width:70%;height:70%;" />
                                </a>
                            </div>
                        </div>
                        <div style="margin-left:37%;">
                            <h3>Usama Naeem<br /><small >- Student AT FAST-NU</small><br /><small>- Developer</small></h3>
                        </div>
                    </div>
                </center>

            </div>
            <div class="section">
                <center>
                    <div class="head">
                        <div class="cont_forimage">
                            <a href="https://www.instagram.com/">
                                <img src="${pageContext.request.contextPath}/resources/imgs/moiz.png" alt="Example" id="pic1" class="_theimage" />
                               
                            </a>
                            <div class="middle_forimage">
                                <a href="https://www.instagram.com/">
                                    <img src="${pageContext.request.contextPath}/resources/imgs/insta_logo.png" class="_logo" style="width:70%;height:70%;" />
                                </a>
                            </div>
                        </div>
                        <div style="margin-left:37%;">
                            <h3>Moiz Ur Rehman <br /><small>- Student AT FAST-NU</small><br /><small>- Developer</small></h3>
                        </div>
                    </div>
                </center>
            </div>

            <div class="section">
                <center>
                    <div class="head">
                        <div class="cont_forimage">
                            <a href="https://www.instagram.com/">
                                <img src="${pageContext.request.contextPath}/resources/imgs/fatima.png" alt="Example" id="pic1" class="_theimage" />

                            </a>
                            <div class="middle_forimage">
                                <a href="https://www.instagram.com/">
                                    <img src="${pageContext.request.contextPath}/resources/imgs/insta_logo.png" class="_logo" style="width:70%;height:70%;" />
                                </a>
                            </div>
                        </div>
                        <div style="margin-left:37%;">

                            <h3>Fatima <br /><small>- Student AT FAST-NU</small><br /><small >- Developer</small></h3>
                        </div>
                    </div>
                </center>
            </div>
        </div>
    </section>
</body>
</html>