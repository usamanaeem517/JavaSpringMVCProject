<%@ page import="com.clinic.models.Bill" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.clinic.models.PatientProfileAllData" %>
<%
    PatientProfileAllData data = (PatientProfileAllData) request.getAttribute("model");
    String username = (String) request.getAttribute("session");
    String profile = (String) request.getAttribute("profile");
    ArrayList<Bill> bills = (ArrayList<Bill>) request.getAttribute("Bills");
    String url = (String) request.getAttribute("pic");%>
<!DOCTYPE html>
<head>
    <link href="${pageContext.request.contextPath}/resources/Content/PatientProfile.css" rel="stylesheet" />
    <link href="${pageContext.request.contextPath}/resources/Content/header.css" rel="stylesheet" />
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
            <form>
                <a href="PatientProfile" target="_self"><img src="${pageContext.request.contextPath}/Patient pics/<%=url%>" id="profile_link" alt = "image"/></a>
                <text class="userinfo"><%=username%></text>
            </form>
        </div>
        <%}%>
    </div>
    <div class="header-bottom">
        <div class="navbar">
            <a href="Home" target="_self">Home</a>
            <a href="Appointment">Appointments</a>
            <a href="Doctors" target="_self">Doctors</a>
            <a href="Reviews">Reviews</a>
            <a data-scroll href="#footer-distributed">Contact</a>
            <a href="About">About us</a>
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
<div class="conatiner">
    <div class="hello_cell">
        <a class="hello">Profile</a>
    </div>
    <div class="profile">
        <div class="profile_picture">
            <a id="picture">
                <img src="${pageContext.request.contextPath}/resources/Patient pics/<%=url%>"/>
            </a>
        </div>
        <div class="information">
            <div class="profile_name">
                <a class="name"><%=data.user.Name%></a>
            </div>
            <div class="profile_cell">
                    <span>
                        <a class="pre_info">Gender :</a>
                        <a style="margin-left:10%; " class="info"><%=data.user.Gender%></a>
                    </span>
            </div>
            <div class="profile_cell">
                    <span>
                        <a class="pre_info">Age :</a>
                        <a style="margin-left:13.5%;" class="info"><%=data.user.Age%></a>
                    </span>
            </div>
            <div class="profile_cell">
                    <span>
                        <a class="pre_info">Email :</a>
                        <a style="margin-left:12%;" class="info"><%=data.user.Email%></a>
                    </span>
            </div>
            <div class="profile_cell">
                    <span>
                        <a class="pre_info">Phone Number :</a>
                        <a style="margin-left:3%;" class="info"><%=data.user.Phone%></a>
                    </span>
            </div>
            <div style="padding-bottom:1%; " class="profile_cell">
                    <span>
                        <a class="pre_info">Address :</a>
                        <a style="margin-left:10%;" class="info"><%=data.user.Address%></a>
                    </span>
            </div>
        </div>
    </div>
</div>
<div class="history_container">
    <a class="hello">Bills Status</a>
    <div class="table-users">
        <table cellspacing="0">
            <tr>
                <th>Date</th>
                <th>Doctor</th>
                <th>Amount</th>
                <th>Status</th>
            </tr>
            <%
            Bill temp = new Bill();
            for(int i = 0; i < bills.size();i++)
            {
               temp = bills.get(i);
            %>
            <tr>
                <td><%=temp.Date%></td>
                <td><%=temp.Doctor%></td>
                <td><%=temp.Amount%></td>
                <% if (temp.Status.equals("0"))
                {%>
                <td style="color:red">
                    Unpaid
                </td>
                <%}
                else
                {%>
                <td style="color:forestgreen">Paid</td>
                <%}%>
            </tr>
           <% } %>
        </table>
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
            for(int i = 0; i < data.pres.size(); i++)
            {
                pres = data.pres.get(i);
            %>
            <tr>
                <td><%=pres.Date%></td>
                <td><%=pres.Doctor_Name%></td>
                <td><%=pres.Disease_Diagnosed%></td>
                <td>
                    <%
                    PatientProfileAllData.Meds meds = new PatientProfileAllData.Meds();
                    for(int j = 0; j < data.Med_List.size(); j++)
                    {
                     meds = data.Med_List.get(j);
                    if (pres.Prescription_ID == meds.Prescription_ID)
                    { %>
                    <%=meds.Med%>
                    <br />
                    <%}
                    }%>
                </td>
                <td>
                    <%
                    PatientProfileAllData.Meds meds2 = new PatientProfileAllData.Meds();
                    for(int k = 0; k < data.Med_List.size(); k++)
                    {
                        meds2 = data.Med_List.get(k);
                    if (pres.Prescription_ID == meds2.Prescription_ID)
                    {%>
                    <%=meds.Quantity%>
                    <br />
                    <%}
                    }%>
                </td>
                <td>
                    <%
                    PatientProfileAllData.Tests tests = new PatientProfileAllData.Tests();
                    for(int k = 0; k < data.Test_List.size(); k++)
                    {
                        tests = data.Test_List.get(k);
                    if (pres.Prescription_ID == tests.Prescription_ID)
                    { %>
                    <%=tests.Test%>
                    <br />
                    <%}
                    }%>
                </td>
            </tr>
            <%}%>
        </table>
    </div>
</div>
</body>
</html>