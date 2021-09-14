<!DOCTYPE html>
<html>
<head>
    <style>

        @import url('https://fonts.googleapis.com/css?family=Montserrat:400,800');

        * {
            box-sizing: border-box;
        }

        body {
            background-image: url('${pageContext.request.contextPath}/resources/imgs/HbEuOcb.jpg');
            background-position: center;
            background-size: cover;
            font-family: 'Source Sans Pro', sans-serif;
            margin: 0;
        }


        button {
            border-radius: 25px;
            border: 1px solid #FF4B2B;
            background-color: #FF4B2B;
            color: #FFFFFF;
            font-size: 18px;
            font-weight: bold;
            margin-top:30px;
            padding: 12px 45px;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: transform 80ms ease-in;
            cursor: pointer;
            -webkit-transition-duration: 0.4s;
            transition-duration: 0.4s;
        }

        button:active {
            transform: scale(0.95);
        }

        button:focus {
            outline: none;
        }

        button.ghost {
            background-color: transparent;
            border-color: #FFFFFF;
        }

        button:hover {
            box-shadow: 0 10px 14px 0 rgba(0,0,0,0.24), 0 15px 48px 0 rgba(0,0,0,0.19);
            transition: box-shadow 0.3s ease-in-out;
        }

        form {
            background-color: #FFFFFF;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            padding: 0 50px;
            height: 100%;
            text-align: center;
            font-family: Calibri;
        }

        input {
            background-color: #eee;
            border: thin;
            border-radius: 20px;
            padding: 12px 15px;
            box-shadow: 0 2px 0 2px rgba(0,0,0,0.22);
            margin: 10px 0;
            width: 100%;
        }

        input:focus {
            box-shadow: 0 0 5px rgb(45, 103, 191);
            background-color: #ebf0fd;
            outline: none;
        }

        .container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 14px 28px rgba(0,0,0,0.25), 0 10px 10px rgba(0,0,0,0.22);
            position: relative;
            overflow: hidden;
            width: 800px;
            max-width: 100%;
            min-height: 620px;
            top: 50px;
            margin-left: 25%;
            margin-right: 25%;
            margin-bottom: 100px;

        }


        .form-container {
            position: absolute;
            top: 0;
            height: 100%;
            transition: all 0.6s ease-in-out;
        }

        .reg-container {
            left: 0;
            width: 70%;
            z-index: 2;
        }

        .overlay-container {
            position: absolute;
            top: 0;
            left: 70%;
            width: 30%;
            height: 100%;
            overflow: hidden;
            z-index: 100;
        }

        .overlay {
            background: linear-gradient(to right, #0795ff,#30FFB7);
            color: #FFFFFF;
            position: relative;
            left: -100%;
            height: 100%;
            width: 200%;
        }

        .error-message {
            color: #ee3939;
            display: inline-block;
            border-color: #ff0000;
        }

        .gender_container {
            position: relative;
            padding-left: 0;
            margin-top: 10px;
            left: -18%;
        }

        .which_gender {
            font-family: Calibri;
            font-size:22px;

        }
        /* The container */
        .radio_container {
            position: relative;
            padding-left: 35px;
            margin-bottom: 12px;
            cursor: pointer;
            font-size: 20px;
        }

        /* Hide the browser's default radio button */
        .radio_container input {
            position: absolute;
            opacity: 0;
            cursor: pointer;
        }

        /* Create a custom radio button */
        .checkmark {
            display:inline;
            position: absolute;
            top: 0;
            left: 0;
            height: 25px;
            width: 25px;
            background-color: #eee;
            border-radius: 50%;
        }

        /* On mouse-over, add a grey background color */
        .radio_container:hover input ~ .checkmark {
            background-color: #ccc;
        }

        /* When the radio button is checked, add a blue background */
        .radio_container input:checked ~ .checkmark {
            background-color: #2196F3;
        }

        /* Create the indicator (the dot/circle - hidden when not checked) */
        .checkmark:after {
            content: "";
            position: absolute;
            display: none;
        }

        /* Show the indicator (dot/circle) when checked */
        .radio_container input:checked ~ .checkmark:after {
            display: block;
        }

        /* Style the indicator (dot/circle) */
        .radio_container .checkmark:after {
            top: 9px;
            left: 9px;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: white;
        }
    </style>
</head>
<body>
<div class="container" id="container">

    <div class="form-container reg-container">
        <form action="AddPatientInfo" method="post" enctype="multipart/form-data">
            <h1>Patient Registration</h1>
            <input class="input" type="text" placeholder="Name" id="reg_name_bt" name="reg_name_bt" required />

            <input class="input" type="text" placeholder="City" id="reg_city_bt" name="reg_city_bt" required />
            <input class="input" type="number" placeholder="Age" id="reg_age_bt" name="reg_age_bt" required />
            <input class="input" type="text" placeholder="Phone Number" id="reg_phone_bt" name="reg_phone_bt" required />
            <input class="input" type="text" placeholder="Address" id="reg_address_bt" name="reg_address_bt" required />
            <input type="file" id="img" name="img" required />
            <div class="gender_container">
                <label class="which_gender">Gender:</label>
                &nbsp;
                <label class="radio_container">
                    Male
                    <input class="input" type="radio" checked="checked" name="radio_bt" value="0" id="radio_btm">
                    <span class="checkmark"></span>
                </label>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <label class="radio_container">
                    Female
                    <input type="radio" name="radio_bt" value="1" id="radio_bt">
                    <span class="checkmark"></span>
                </label>
            </div>
            <button id="newreg">Register</button>
        </form>
    </div>
    <div class="overlay-container">
        <div class="overlay">
        </div>
    </div>
</div>

</body>
</html>
<script>
    function checkbox() {
        var radio1 = document.getElementById('radio_btm');
        var radio2 = document.getElementById('radio_btf');
        var x = "Male";
        var y = "Female";
        if (radio1.checked)
            radio_btm.value=x;
        else if (radio2.checked)
        {
            radio_btm.value = y;
        }
    }


    function basic_checks() {
        var name = document.getElementById('reg_name_bt').value;
        var city = document.getElementById('reg_city_bt').value;
        var phone = document.getElementById('reg_phone_bt').value;
        var flag = true;
        var count = 0;


        //checking for correct name
        for (var i = 0; i < name.length; i++) {
            if (name[i] >= 'a' && name[i] <= 'z')
                count++;
            else if (name[i] >= 'A' && name[i] <= 'Z')
                count++;
            else if (name[i] == ' ')
                count++;
        }
        if (count != name.length) {
            flag = false;
            document.getElementById('reg_name_bt').value = "";
            document.getElementById('reg_name_bt').style.backgroundColor = "#fe4747";
        }
        else {
            document.getElementById('reg_name_bt').style.backgroundColor = "#eee";
        }


        count = 0;
        for (var i = 0; i < city.length; i++) {
            if (city[i] >= 'a' && city[i] <= 'z')
                count++;
            else if (city[i] >= 'A' && city[i] <= 'Z')
                count++;
        }
        if (city.length != count) {
            flag = false;
            document.getElementById('reg_city_bt').value = "";
            document.getElementById('reg_city_bt').style.backgroundColor = "#fe4747"
        } else {
            document.getElementById('reg_city_bt').style.backgroundColor = "#eee"
        }


        if (phone.length != 11) {
            flag = false;
            document.getElementById('reg_phone_bt').value = "";
            document.getElementById('reg_phone_bt').style.backgroundColor = "#fe4747";
        }
        else {
            document.getElementById('reg_phone_bt').style.backgroundColor = "#eee";
        }

        return flag;
    }
</script>*/