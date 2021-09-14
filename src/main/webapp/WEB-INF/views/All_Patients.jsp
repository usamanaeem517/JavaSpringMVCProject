<%@ page import="com.clinic.models.PatientProfileAllData" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.clinic.models.Patient" %>

<%  String username = (String) request.getAttribute("session");
    String profile = (String) request.getAttribute("profile");
    ArrayList<Patient> Patients = (ArrayList<Patient>) request.getAttribute("Patients");
    PatientProfileAllData Model = (PatientProfileAllData) request.getAttribute("profileData");%>
<!DOCTYPE html>
<html>
<head>
    <link href="${pageContext.request.contextPath}/resources/Content/doctors.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/Content/header.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/Content/patientprofile.css" rel="stylesheet" />
</head>
<body>
    @*<SCRIPT language="JavaScript">

        var test = document.getElementById('link_bt');
        var tt = JSON.stringify(test);
$.ajax({
  url: '@Url.Action("../Home/PatientData", "JSON Test")',
  type: "POST",
  data: tt,
  contentType:"application/json",
  success: function (FeeListResp, textStatus, jqXHR) {
  },
  error: function (jqXHR, textStatus, errorThrown) {
  },
  complete: function () {
  }
});*@
    </SCRIPT>
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
                <a href="Booked_Appointments">Booked Appointments</a>
                <a href="All_Doctors">Doctors</a>
                <a class="active" href="All_Patients">Patients</a>
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

    <%if (Model == null)
    { %>
        <div class="main-container" style="padding-top:1%;">
            <div class="table-users">
                <div class="header">Patients</div>

                <table cellspacing="0">
                    <tr>
                        <th>Profile</th>
                        <th>Name</th>
                        <th>Age</th>
                        <th>Email</th>
                        <th>City</th>
                    </tr>

                    <%
                     Patient temp = new Patient();
                    for(int i = 0; i < Patients.size(); i++)
                    {
                        temp = Patients.get(i);
                    %>
                        <tr>
                            <td>
                               <form method="post" action="PatientData">
                                    <button style="border-radius:100%"type="submit" value="@temp.Email" id="link_bt" name="link_bt"><img src="${pageContext.request.contextPath}/resources/Patient pics/<%=temp.img%>" id="email_bt"/></button>
                                </form>
                                </td>
                            <td><%=temp.Name%></td>
                            <td><%=temp.Age%></td>
                            <td><%=temp.Email%></td>
                            <td><%=temp.City%></td>
                        </tr>
                    <%}%>
                </table>
            </div>
        </div>
    <%}
    else
    {%>
        <div class="conatiner">
            <div class="hello_cell">
                <a class="hello">Profile</a>
            </div>
            <div class="profile">
                <div class="profile_picture">
                    <a id="picture">
                        <img src="${pageContext.request.contextPath}/resources/Patient pics/<%=Model.user.img%>" />
                    </a>
                </div>
                <div class="information">
                    <div class="profile_name">
                        <a class="name"><%=Model.user.Name%></a>
                    </div>
                    <div class="profile_cell">
                        <span>
                            <a class="pre_info">Gender :</a>
                            <a style="margin-left:10%; " class="info"><%=Model.user.Gender%></a>
                        </span>
                    </div>
                    <div class="profile_cell">
                        <span>
                            <a class="pre_info">Age :</a>
                            <a style="margin-left:13.5%;" class="info"><%=Model.user.Age%></a>
                        </span>
                    </div>
                    <div class="profile_cell">
                        <span>
                            <a class="pre_info">Email :</a>
                            <a style="margin-left:12%;" class="info"><%=Model.user.Email%></a>
                        </span>
                    </div>
                    <div class="profile_cell">
                        <span>
                            <a class="pre_info">Phone Number :</a>
                            <a style="margin-left:3%;" class="info"><%=Model.user.Phone%></a>
                        </span>
                    </div>
                    <div style="padding-bottom:1%; " class="profile_cell">
                        <span>
                            <a class="pre_info">Address :</a>
                            <a style="margin-left:10%;" class="info"><%=Model.user.Address%></a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="history_container">
            <a class="hello">History</a>
            <div class="table-users">
                <table cellspacing="0">
                    <tr>
                        <th>Appointment Date</th>
                        <th>Doctor</th>
                        <th>Disease</th>
                        <th>Prescribed Meds</th>
                        <th>Med. Quantity</th>
                        <th>Prescribed Tests</th>
                    </tr>
                    <%
                    PatientProfileAllData.Prescription pres = new PatientProfileAllData.Prescription();
                    for(int i = 0; i < Model.pres.size(); i++)
                    {   pres = Model.pres.get(i);
                        %>
                        <tr>
                            <td><%=pres.Date%></td>
                            <td><%=pres.Doctor_Name%></td>
                            <td><%=pres.Disease_Diagnosed%></td>
                            <td>
                                <%
                                PatientProfileAllData.Meds meds = new PatientProfileAllData.Meds();
                                for(int j = 0; j < Model.Med_List.size(); j++)
                                {  meds = Model.Med_List.get(j);
                                    if (pres.Prescription_ID == meds.Prescription_ID)
                                    { %>

                                        <%=meds.Med%>
                                        <br />
                                    <%}
                                } %>
                            </td>
                            <td>
                                <%
                                PatientProfileAllData.Meds meds1 = new PatientProfileAllData.Meds();
                                for(int k = 0; k < Model.Med_List.size(); k++)
                                {
                                    meds1 = Model.Med_List.get(k);
                                    if (pres.Prescription_ID == meds.Prescription_ID)
                                    {
                                        %>
                                        <%=meds1.Quantity%>
                                        <br />
                                 <%   }
                                }%>
                            </td>
                            <td>
                                <%
                                    PatientProfileAllData.Tests tests = new PatientProfileAllData.Tests();
                                    for(int k = 0; k < Model.Test_List.size(); k++)
                                    {
                                        tests = Model.Test_List.get(k);
                                        if (pres.Prescription_ID == tests.Prescription_ID)
                                        {
                                %>
                                <%=tests.Test%>
                                <br />
                                <%   }
                                }%>
                            </td>
                        </tr>
                   <% } %>
                </table>
            </div>
        </div>
    <% } %>
    <script src="${pageContext.request.contextPath}/resources/Scripts/homescript.js"></script>
</body>
</html>