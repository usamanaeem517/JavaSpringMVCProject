package com.clinic.controllers;
import java.io.*;
import java.sql.*;

import com.clinic.models.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.util.ArrayList;

@Controller
public class PatientServlet {
    ArrayList<Appointments> appointmentsArrayList = null;
    String appId = "";
    static class Global
    {
        public static String username="";
        public static String userType="";
        public static String userpic ="";

    }
    String email;
    @RequestMapping(value="/authenticateSignup", method= RequestMethod.POST)
    public ModelAndView authenticateSignup(@RequestParam String signup_mail_bt, @RequestParam String signup_pass_bt) throws SQLException {

        int result = CRUD.signup(signup_mail_bt,signup_pass_bt);
        System.out.println(result);
        email = signup_mail_bt;
        ModelAndView mv = new ModelAndView();
        if(result  == 1){
            mv.setViewName("RegForm");
        }
        else{
            String data = "Email already taken!";
            mv.setViewName("index");
            mv.addObject(data);
        }
        return mv;
    }
    @RequestMapping("/index")
    public ModelAndView index(){
        ModelAndView mv = new ModelAndView();
        mv.setViewName("index");
        return mv;
    }
    @RequestMapping(value = "/authenticateSignIn", method= RequestMethod.POST)
    public ModelAndView authenticateSignIn(@RequestParam String signin_mail_bt, @RequestParam String signin_pass_bt) throws SQLException {
        if(email!=null )
        {
            ModelAndView mv = new ModelAndView();
            mv.setViewName("redirect:/PatientProfile");
            return mv;
        }
        singInResult User = CRUD.signin(signin_mail_bt, signin_pass_bt);
        System.out.println(User.result);
        if (User.result == -1)
        {
            String data = "Something went wrong while connecting with the database";
            ModelAndView mv = new ModelAndView();
            mv.setViewName("redirect:/index");
            mv.addObject(data);
            return mv;
        }
        else if (User.result == 0)
        {
            String data = "Invalid Credentials!";
            ModelAndView mv = new ModelAndView();
            mv.setViewName("redirect:/index");
            mv.addObject(data);
            return mv;
        }

        email = signin_mail_bt;


        if (User.userType == 'A')
        {
            Global.username = "Reception";
            Global.userType = "Admin";
        }
        else
        {
            ArrayList<Patient> patients = CRUD.getAllPatients();
            ArrayList<Doctor> doctors = CRUD.GetAllDoctors();
            Global.username = Basic.getUserName(doctors, patients, User.userType, email);
            Global.userpic = Basic.getUserPic(doctors, patients, User.userType, email);
            if (User.userType == 'P')
            {
                Global.userType = "Patient";
                if (Global.username.length()<=1)
                {
                    ModelAndView mv = new ModelAndView();
                    mv.setViewName("redirect:/RegForm");
                    return mv;
                }
            }
            else if (User.userType == 'D')
            {
                Global.userType = "Doctor";
                if (Global.username.length() <= 1)
                {
                    ModelAndView mv = new ModelAndView();
                    mv.setViewName("redirect:/DoctorProfile");
                    return mv;
                }
            }
        }
        ModelAndView mv = new ModelAndView();
        mv.setViewName("redirect:/Home");
        return mv;
    }

    @RequestMapping(value = "/Home")
    public ModelAndView Home() throws SQLException {
        ArrayList<UserAuth> users = CRUD.getAllUsers();
        ArrayList<Patient> patients = CRUD.getAllPatients();
        ModelAndView mv = new ModelAndView();
        mv.addObject("Allauthentications", users);
        mv.addObject("patients", patients);
        if (email == null)
        {
            mv.addObject("session", "");
            mv.addObject("profile", "x");
        }
        else
        {
            mv.addObject("session",Global.username);
            mv.addObject("profile", Global.userType);
            mv.addObject("pic",Global.userpic);
        }

        mv.setViewName("Home");
        return mv;
    }

    @RequestMapping(value = "/Reviews")
    public ModelAndView Reviews()
    {
        ModelAndView mv = new ModelAndView();
        if (email == null)
        {
            mv.addObject("session", "");
            mv.addObject("profile", "x");
            mv.addObject("pic","x");
        }
        else
        {
            mv.addObject("session", Global.username);
            mv.addObject("profile", Global.userType);
            mv.addObject("pic",Global.userpic);
        }
        mv.setViewName("Reviews");
        return mv;
    }

    @RequestMapping(value = "/Doctors")
    public ModelAndView Doctors()
    {
        ModelAndView mv = new ModelAndView();
        if (email == null)
        {
            mv.addObject("session", "");
            mv.addObject("profile", "x");
            mv.addObject("pic","x");
        }
        else
        {
            mv.addObject("session", Global.username);
            mv.addObject("profile", Global.userType);
            mv.addObject("pic",Global.userpic);
        }
        ArrayList<Doctor> doctors = CRUD.GetAllDoctors();
        mv.addObject("doctors", doctors);
        mv.setViewName("Doctors");
        return mv;
    }
    @RequestMapping(value = "/About")
    public ModelAndView About()
    {
        ModelAndView mv = new ModelAndView();
        if (email == null)
        {
            mv.addObject("session", "");
            mv.addObject("profile", "x");
            mv.addObject("pic","x");
        }
        else
        {
            mv.addObject("session", Global.username);
            mv.addObject("profile", Global.userType);
            mv.addObject("pic",Global.userpic);
        }
        mv.setViewName("About");
        return mv;
    }

    @RequestMapping("/RegForm")
    public ModelAndView RegForm()
    {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("RegForm");
        return mv;
    }

    @RequestMapping(value = "/AddPatientInfo", method = RequestMethod.POST)
    public ModelAndView AddPatientInfo(@RequestParam CommonsMultipartFile img, @RequestParam String reg_address_bt, @RequestParam String reg_name_bt, @RequestParam String reg_city_bt, @RequestParam int reg_age_bt, @RequestParam String reg_phone_bt, @RequestParam("radio_bt") String radio_bt) throws SQLException, IOException {
        if (email != null) {
            int unique = CRUD.PatientCount();
            String fileName = img.getOriginalFilename();
            String path = "";
            path = path.concat("C:/Users/Hp/IdeaProjects/AP_Project/src/main/webapp/resources/Patient pics");
            byte[] bytes = img.getBytes();
            BufferedOutputStream stream =new BufferedOutputStream(new FileOutputStream( new File(path + File.separator + fileName)));
            stream.write(bytes);
            stream.flush();
            stream.close();

            int result = CRUD.Addpatient(fileName, "/Patient pics", reg_address_bt, email, reg_name_bt, reg_city_bt, reg_age_bt, reg_phone_bt, radio_bt);
            System.out.println("bfewhfbewbchbwehj");
            if (result == -1) {
                String data = "Something went wrong while connecting with the database.";
                ModelAndView mv = new ModelAndView();
                mv.addObject(data);
                mv.setViewName("RegForm");
                return mv;
            } else if (result == 0) {

                String data = "Email Already Exists";
                ModelAndView mv = new ModelAndView();
                mv.addObject(data);
                mv.setViewName("RegForm");
                return mv;
            }
            ArrayList<Patient> patients = CRUD.getAllPatients();

            Global.userType = "Patient";
            Global.username = Basic.getUserName(null, patients, 'P', email);
            Global.userpic = Basic.getUserPic(null, patients, 'P', email);
            ModelAndView mv = new ModelAndView();
            mv.setViewName("redirect:/PatientProfile");
            return mv;
        } else {
            ModelAndView mv = new ModelAndView();
            mv.setViewName("index");
            return mv;
        }
    }

    @RequestMapping("/PatientProfile")
    public ModelAndView PatientProfile() throws SQLException {
        if (email == null)
        {
            ModelAndView mv = new ModelAndView();
            mv.setViewName("index");
            return mv;
        }

        PatientProfileAllData data = CRUD.GetPatientAllData(email);
        ModelAndView mv = new ModelAndView();
        mv.addObject("Bills", CRUD.PatientBills(email));
        mv.addObject("session", Global.username);
        mv.addObject("profile", Global.userType);
        mv.addObject("model", data);
        mv.addObject("pic", Global.userpic);
        System.out.println(Global.userpic);
        mv.setViewName("PatientProfile");
        return mv;
    }

    @RequestMapping("/Appointment")
    public ModelAndView Appointment()
    {

        ModelAndView mv = new ModelAndView();
        mv.addObject("session", Global.username);
        mv.addObject("profile", Global.userType);
        mv.addObject("pic", Global.userpic);

        ArrayList<Doctor> docs = CRUD.GetDoctorBasic();
        mv.addObject("doctors", docs);
        mv.addObject("appointments", appointmentsArrayList);
        mv.setViewName(mv.getViewName());
        return mv;
    }

    @RequestMapping(value = "/get_available_appointments", method = RequestMethod.POST)
    public ModelAndView get_available_appointments(@RequestParam String appointment_date, @RequestParam("doctor") String doc)
    {
        if (email == null)
        {
            ModelAndView mv = new ModelAndView();
            mv.setViewName("index");
            return mv;
        }

        int docid = Integer.parseInt(doc);
        ArrayList<Appointments> app = CRUD.GetAllAppointments(appointment_date, docid);

        ModelAndView mv = new ModelAndView();
        appointmentsArrayList = app;
        mv.setViewName("redirect:/Appointment");
        return mv;
    }

    @RequestMapping(value = "/book_appointments", method = RequestMethod.POST)
    public ModelAndView book_appointments(@RequestParam String book_btn)
    {

        ArrayList<Appointments> a = appointmentsArrayList;

        Appointments a1 = Basic.getAppointment(a, book_btn);

        int patientID = CRUD.GetPatientID(email);
        int app = CRUD.BookAppointment(patientID, a1.app_id);
        ModelAndView mv = new ModelAndView();
        appointmentsArrayList = null;
        mv.setViewName("redirect:/Appointment");
        return mv;
    }

    @RequestMapping("/DoctorAppointments")
    public ModelAndView DoctorAppointments()
    {
        ModelAndView mv = new ModelAndView();
        if (email == null)
        {
            mv.setViewName("index");
            return mv;
        }
        else
        {
            mv.addObject("session", Global.username);
            mv.addObject("profile", Global.userType);
            mv.addObject("pic", Global.userpic);

            Doctor now= CRUD.GetDoctor(email);
            ArrayList<Appointments> apps = CRUD.GetDocAppointments(now.DocID);
            mv.addObject("myapps", apps);
        }
        mv.setViewName("DoctorAppointments");
        return mv;
    }

    @RequestMapping("/DoctorProfile")
    public ModelAndView DoctorProfile()
    {
        ModelAndView mv = new ModelAndView();
        if (email == null)
        {
            mv.setViewName("index");
            return mv;
        }
        Doctor data = CRUD.GetDoctor(email);
        mv.addObject("session", Global.username);
        mv.addObject("profile", Global.userType);
        mv.addObject("pic", Global.userpic);
        mv.addObject("doctorprofile", data);
        mv.setViewName("DoctorProfile");
        return mv;
    }

    @RequestMapping("/Prescription")
    public ModelAndView Prescription()
    {
        ModelAndView mv = new ModelAndView();
        if (email == null)
        {
            mv.setViewName("index");
            return mv;
        }
        Prescriptiondetails temp = new Prescriptiondetails();
        if(temp==null)
        {
            mv.setViewName("DoctorAppointments");
            return mv;
        }
        mv.addObject("prescription", temp);
        mv.setViewName("Prescription");
        return mv;
    }

    @RequestMapping(value = "/TakeAppointment", method = RequestMethod.POST)
    public ModelAndView TakeAppointment(@RequestParam String see_btn)
    {
        Prescriptiondetails details = CRUD.GetPrescriptionDetails(see_btn);
        /*TempData["takeapp"] = details;
        TempData["AppID"] = see_btn;
        */
        ModelAndView mv = new ModelAndView();
        if(details != null){
            appId = see_btn;
            mv.addObject("prescription", details);
            mv.setViewName("Prescription");
        }
        else{
            mv.setViewName("DoctorAppointments");
        }
        return mv;
    }

    @RequestMapping(value = "/AddPrescription", method = RequestMethod.POST)
    public ModelAndView AddPrescription(@RequestParam String med_box, @RequestParam String test_box, @RequestParam String disease_box)
    {
        //String appid = TempData["AppID"] as string;

        ArrayList<Meds> meds= Basic.TokenizeMedicine(med_box);
        String appid = appId;
        String[] tests = test_box.split("\r");
        for (int i = 1; i < tests.length; i++)
            tests[i] = tests[i].substring(1);

        CRUD.AddPrescriptionHistoryBill(appid,disease_box,meds,tests);
        appId = "";
        ModelAndView mv = new ModelAndView();
        mv.setViewName("redirect:/DoctorAppointments");
        return mv;
    }

    //#################################################### Admin Methods

    @RequestMapping("/Booked_Appointments")
    public ModelAndView Booked_Appointments()
    {
        ModelAndView mv = new ModelAndView();
        if (email == null)
        {
            mv.setViewName("index");
            return mv;
        }
        ArrayList<Appointments> list = CRUD.BookedAppointments();
        mv.addObject("session", Global.username);
        mv.addObject("profile", Global.userType);
        mv.addObject("appointments", list);
        mv.setViewName("Booked_Appointments");
        return mv;
    }

    @RequestMapping("/All_Doctors")
    public ModelAndView All_Doctors()
    {
        ModelAndView mv = new ModelAndView();
        if (email == null)
        {
            mv.setViewName("index");
            return mv;
        }

        mv.addObject("session", Global.username);
        mv.addObject("profile", Global.userType);
        mv.addObject("Doctors", CRUD.GetAllDoctors());
        mv.setViewName("All_Doctors");
        return mv;
    }

    @RequestMapping("/All_Patients")
    public ModelAndView All_Patients() throws SQLException {
        ModelAndView mv = new ModelAndView();
        if (email == null)
        {
            mv.setViewName("index");
            return mv;
        }

        mv.addObject("session", Global.username);
        mv.addObject("profile", Global.userType);
        /*if (TempData["patientprofile"] != null)
        {
            ViewData["profileData"] = TempData["patientprofile"] as PatientProfileAllData;
        }*/
        mv.addObject("Patients", CRUD.getAllPatients());
        mv.setViewName(mv.getViewName());
        return mv;
    }

    @RequestMapping(value = "/PatientData", method = RequestMethod.POST)
    public ModelAndView PatientData(@RequestParam String link_bt)
    {
        ModelAndView mv = new ModelAndView();
        //TempData[PatientData"] = CRUD.GetPatientAllData(link_bt);
        //mv.addObject("PatientData", CRUD.GetPatientAllData(link_bt));
        mv.setViewName("redirect:/All_Patients");
        return mv;
    }

    @RequestMapping("/Logout")
    public ModelAndView Logout()
    {
        email = null;
        Global.username = "";
        Global.userType = "x";
        Global.userpic = "x";
        ModelAndView mv = new ModelAndView();
        mv.setViewName("redirect:/Home");
        return mv;
    }

    @RequestMapping(value = "/Register_Doctor")
    public ModelAndView Register_Doctor()
    {
        ModelAndView mv = new ModelAndView();
        if (email == null)
        {
            mv.setViewName("index");
            return mv;
        }
        mv.setViewName(mv.getViewName());
        return mv;
    }

    @RequestMapping(value = "/Add_Doctor", method = RequestMethod.POST)
    public ModelAndView Add_Doctor(@RequestParam CommonsMultipartFile img,@RequestParam String doc_name_bt, @RequestParam String doc_email_bt, @RequestParam String doc_password_bt, @RequestParam String doc_city_bt, @RequestParam int doc_age_bt, @RequestParam String doc_phone_bt, @RequestParam String radio_bt, @RequestParam String doc_specialization_bt, @RequestParam int doc_fee_bt) throws IOException {
        int unique = CRUD.DoctorCount()+1;

        String fileName = img.getOriginalFilename();
        String path = "";
        path = path.concat("C:/Users/Hp/IdeaProjects/AP_Project/src/main/webapp/resources/Doctor pics");
        byte[] bytes = img.getBytes();
        BufferedOutputStream stream =new BufferedOutputStream(new FileOutputStream( new File(path + File.separator + fileName)));
        stream.write(bytes);
        stream.flush();
        stream.close();

        ArrayList<String> specialization = new ArrayList<String>();
        ArrayList<String> specialization_doc = new ArrayList<String>();

        String[] authorInfo = doc_specialization_bt.split(",");
        String info = "";
        for (int i = 0; i < authorInfo.length; i++)
        {
            info = authorInfo[i];
            specialization.add(info);
        }

        String gender = "";
        if (radio_bt.charAt(0) == '0')
            gender = "Male";
        else if (radio_bt.charAt(0) == '1')
            gender = "Female";
        int result = CRUD.register_doctor(fileName, "~/Doctor pics",doc_name_bt, doc_email_bt, doc_password_bt, doc_city_bt, doc_age_bt, gender, doc_phone_bt, radio_bt, specialization, doc_fee_bt);

        ModelAndView mv = new ModelAndView();
        mv.setViewName("redirect:/All_Doctors");
        return mv;
    }

    @RequestMapping(value = "/All_Bills_Info")
    public ModelAndView All_Bills_Info()
    {
        ModelAndView mv = new ModelAndView();
        if (email == null)
        {
            mv.setViewName("index");
            return mv;
        }
        mv.addObject("session", Global.username);
        mv.addObject("profile", Global.userType);
        mv.addObject("Bills", CRUD.All_Bills());
        mv.setViewName(mv.getViewName());
        return mv;
    }

    @RequestMapping(value = "/Update_Payment", method = RequestMethod.POST)
    public ModelAndView Update_Payment(@RequestParam String pay_btn)
    {
        ModelAndView mv = new ModelAndView();
        CRUD.Update_Payment(pay_btn);
        mv.setViewName("redirect:/All_Bills_Info");
        return mv;
    }

    @RequestMapping("/AddAppointments")
    public ModelAndView AddAppointments()
    {
        CRUD.Insert_Appointments();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("redirect:/Booked_Appointments");
        return mv;
    }

    @RequestMapping(value = "/UpdateDoctorTime", method = RequestMethod.POST)
    public ModelAndView UpdateDoctorTime(@RequestParam String start_box,@RequestParam String end_box,@RequestParam String update_bt)
    {
        ModelAndView mv = new ModelAndView();
        CRUD.UpdateDocTime(Integer.parseInt(update_bt),start_box,end_box);
        mv.setViewName("DoctorProfile");
        return mv;
    }
}

