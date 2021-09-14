<%  String username = (String) request.getAttribute("session");
    String profile = (String) request.getAttribute("profile");
    String pic = (String) request.getAttribute("pic");%>
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <style>
            .wrapper {
                background-image: url('${pageContext.request.contextPath}/resources/imgs/bg-testimonial.png');
                background-size: cover;
                background-position: center;
                background-attachment: fixed;
                height: 140vh;
                padding-top: 5%;
            }
            h2{
                font-size:30px;
                color:#191919
            }
            .highlights {
                position: absolute;
                width: 85%;
                height: 70%;
                margin-top: 5%;
                margin-left: 8%;
                margin-right: 8%;
                display: inline-block;
            }

            .section {
                box-shadow: 2px 20px 32px grey, 2px 14px 14px grey;
                height: 70%;
                width: 27%;
                float: left;
                margin-left: 3%;
                margin-right: 3%;
                color: white;
                margin-top: 3%;
            }

            .section:nth-child(1) {
                background: #39b49b;
            }

            .section:nth-child(2) {
                box-shadow: 20px 20px 50px grey, 20px 20px 50px grey;
                background: #165745;
            }

            .section:nth-child(3) {
                background: #39b49b;
            }



            .head {
                margin-top:-15%;
                font-size: 20px;
                font-weight:500;
                margin-bottom:-12%;
            }
            h3{
                margin-bottom:-5%;
                padding-top:10%;
            }
            .section img {
                width: 30%;
                height: 30%;
                margin-bottom:-15%;
            }

            .section p {
                font-size: 16px;
                text-align: center;
                padding: 0 10%;
            }

            .section hr {
                text-align: center;
                width: 50%;
                height: 1px;
                border: none;
                border-top: 2px dotted #0066ff;
                background-color: white;
            }

            #pic1 {
                border-radius: 100%;
                height: 100px;
                width: 100px;
                border: 3px solid #6ea1ee;
            }

            #pic2 {
                border-radius: 100%;
                height: 100px;
                width: 100px;
                border: 3px solid #6ea1ee;
            }

            #pic3 {
                border-radius: 100%;
                height: 100px;
                width: 100px;
                border: 3px solid #6ea1ee;
            }

            hr {
                height: 3px;
                color: red;
                background: linear-gradient(to right, #0795ff,#30FFB7);
                border: none;
                width: 77%;
            }

        </style>
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
    </head>
<html>
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
                    <a  class="active" href="Reviews">Reviews</a>
                    <a data-scroll href="#footer-distributed">Contact</a>
                    <a href="About">About us</a>
                <%}
                else if (profile.charAt(0) == 'A')
                {%>
                    <a href="Home" target="_self">Home</a>
                    <a href="Booked_Appointments">Booked Appointments</a>
                    <a href="All_Doctors">Doctors</a>
                    <a href="All_Patients">Patients</a>
                    <a href="All_Bills_Info">Bills</a>
                    <a class="active" href="Reviews">Reviews</a>
                    <a data-scroll href="#footer-distributed">Contact</a>
                    <a href="About">About us</a>
                <%}
                else
                {%>
                    <a  href="Home" target="_self">Home</a>
                    <a href="Appointment" target="_self">Appointments</a>
                    <a href="Doctors" target="_self">Doctors</a>
                    <a class="active" href="Reviews">Reviews</a>
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
    <section class="wrapper">
        <center>
            <div class="heading" style="margin-top:3%;">
                <span><img src="${pageContext.request.contextPath}/resources/imgs/icon-logo.png" alt="#" /> </span>
            </div>
            <h2>Testimonials</h2>
        </center>
        <hr />

        <div class="highlights">
            <div class="section">
                <center>
                    <div class="head">
                        <img src="${pageContext.request.contextPath}/resources/imgs/pic2.png" alt="Example" id="pic1" />
                        <h3>Dr Farasat Ali Dogar <br /><small style="color:#d5df9d;font-size:15px;">- Psychiatrist</small></h3>
                    </div>
                </center>
                <center>
                    <h3>Health Street Care Network</h3>
                    <br />
                    <p class="lead">
                        ʻʻ The Health Street Care Network provides expertise and resources to member medical facilities through formal collaboration and information-sharing tools. ʼʼ
                    </p>
                </center>
            </div>
            <div class="section">
                <center>
                    <div class="head">
                        <img src="${pageContext.request.contextPath}/resources/imgs/pic1.png" id="pic2" />
                        <h3>Dr. Asma Gul <br /><small style="color:#d5df9d;font-size:15px;">- Gynaecologist</small></h3>
                    </div>
                </center>
                <center>
                    <h3> Skilled Staff!</h3>
                    <br />
                    <p class="lead">
                        ʻʻ They have got my project on time with the competition with a sed highly skilled, and experienced & professional team. ʼʼ
                    </p>
                </center>
            </div>
            <div class="section">
                <center>
                    <div class="head">
                        <img src="${pageContext.request.contextPath}/resources/imgs/pic3.png" id="pic3" />
                        <h3>Dr. Shaun Murphy <br /><small style="color:#d5df9d;font-size:15px;">- Autistic Surgeon</small></h3>
                    </div>
                </center>
                <center>
                    <h3> Quality!</h3>
                    <br />
                    <p class="lead">
                        ʻʻ Health Street defines quality by looking at all aspects of patient's experience. ʼʼ
                    </p>
                </center>
            </div>
        </div>
    </section>
    <script>
        $(document).ready(function () {
            // Add smooth scrolling to all links
            $("a").on('click', function (event) {

                // Make sure this.hash has a value before overriding default behavior
                if (this.hash !== "") {
                    // Prevent default anchor click behavior
                    event.preventDefault();

                    // Store hash
                    var hash = this.hash;

                    // Using jQuery's animate() method to add smooth page scroll
                    // The optional number (800) specifies the number of milliseconds it takes to scroll to the specified area
                    $('html, body').animate({
                        scrollTop: $(hash).offset().top
                    }, 800, function () {

                        // Add hash (#) to URL when done scrolling (default click behavior)
                        window.location.hash = hash;
                    });
                } // End if
            });
        });
    </script>

</body>
</html>