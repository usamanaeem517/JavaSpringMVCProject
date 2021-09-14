<%@ page import="com.clinic.models.Bill" %>
<%@ page import="java.util.ArrayList" %>

<%  String username = (String) request.getAttribute("session");
    String profile = (String) request.getAttribute("profile");
    ArrayList<Bill> bills = (ArrayList<Bill>) request.getAttribute("Bills"); %>
<!DOCTYPE html>
<html>
<head>
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
                <a href="All_Doctors">Doctors</a>
                <a href="All_Patients">Patients</a>
                <a class="active" href="All_Bills_Info">Bills</a>
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
               <% } %>
            </div>
        </div>
    </header>

    <div class="main-container" style="padding-top:1%;">
        <div class="table-users">
            <div class="header">Bills</div>

            <table cellspacing="0">
                <tr>
                    <th>Date</th>
                    <th>Patient</th>
                    <th>Doctor</th>
                    <th>Amount</th>
                    <th>Status</th>
                </tr>

                <% Bill temp = new Bill();
                for(int i = 0; i < bills.size(); i++)
                {
                    temp = bills.get(i); %>
                    <tr>
                        <td><%=temp.Date%></td>
                        <td><%=temp.Patient%></td>
                        <td><%=temp.Doctor%></td>
                        <td><%=temp.Amount%></td>
                        <%if (temp.Status.equals("0"))
                        { %>
                            <td>
                                <form method="post" action="Update_Payment">
                                    <button class="paay_btn" id="pay_btn" name="pay_btn" value="<%=temp.PresID%>">Pay</button>
                                </form>
                            </td>
                        <%}
                        else
                        {%>
                            <td>Paid</td>
                        <%} %>
                    </tr>
              <%  } %>
            </table>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/resources/Scripts/preloaderscript.js"></script>
</body>
</html>