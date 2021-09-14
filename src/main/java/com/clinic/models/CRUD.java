package com.clinic.models;

import java.util.ArrayList;
import java.sql.*;
public class CRUD {
    public static ArrayList<Patient> getAllPatients() throws SQLException {
        try {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cs = con.prepareCall("{call AllPatients()}");
            ResultSet rdr = cs.executeQuery();
            ArrayList<Patient> list = new ArrayList<Patient>();
            while (rdr.next()) {
                Patient user = new Patient();
                user.Name = rdr.getString(2);
                user.Email = rdr.getString(3);
                user.City = rdr.getString(4);
                user.Gender = rdr.getString(5);
                user.Age = String.valueOf(rdr.getInt(6));
                user.Phone = rdr.getString(7);
                user.Address = rdr.getString(8);
                user.img = rdr.getString(10);

                list.add(user);
            }
            rdr.close();
            con.close();
            return list;
        } catch (SQLException e) {
            System.out.println(e);
            return null;
        }
    }
    public static int Addpatient(String img,String path,String reg_address_bt, String emailID, String reg_name_bt, String reg_city_bt, int reg_age_bt, String reg_phone_bt, String radio_bt) throws SQLException {

        int result = 0;
        String gender = "";
        if (radio_bt.equals("0"))
            gender = "Male";
        else if (radio_bt.equals("1"))
            gender = "Female";
        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cs = con.prepareCall("{call insertPatientinfo(?,?,?,?,?,?,?,?,?,?)}");
            cs.setString(1, emailID);
            cs.setString(2, reg_name_bt);
            cs.setString(3, reg_city_bt);
            cs.setString(4, gender);
            cs.setInt(5, reg_age_bt);
            cs.setString(6, reg_phone_bt);
            cs.setString(7, reg_address_bt);
            cs.setString(8, img);
            cs.setString(9, path);
            cs.registerOutParameter(10, Types.INTEGER);
            cs.execute();
            return cs.getInt(10);
        }

        catch (SQLException e)
        {
            System.out.println(e);
        }

        return result;
    }
    public static int PatientCount() {
        int result = 0;
        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cs = con.prepareCall("{call patientcount(?)}");
            cs.registerOutParameter(1, Types.INTEGER);
            cs.execute();
            return cs.getInt(1);
        }

        catch (SQLException e)
        {
            System.out.println(e);
        }
        return result;
    }
    public static int GetPatientID(String email) {
        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cs = con.prepareCall("{call get_patient(?)}");
            cs.setString(1, email);
            ResultSet rdr = cs.executeQuery();
            int patientid=0;
            while (rdr.next()) {
                patientid = rdr.getInt(1);
            }

            rdr.close();
            con.close();

            return patientid;
        }
        catch (SQLException e)
        {
            System.out.println(e);
        }
        return 0;
    }
    public static PatientProfileAllData GetPatientAllData(String email)   {
        sqlMain sqlConnection = new sqlMain();
        PatientProfileAllData data = new PatientProfileAllData();

        try
        {
            Connection con = sqlConnection.establishConnection();
            CallableStatement cs = con.prepareCall("{call get_patient(?)}");
            cs.setString(1, email);
            ResultSet rs = cs.executeQuery();

            System.out.println("here");
            ///geting patient personl data
            Patient user = new Patient();
            while (rs.next())
            {
                user.Name = rs.getString(2);
                user.Email = rs.getString(3);
                user.City = rs.getString(4);
                user.Gender = rs.getString(5);
                user.Age = String.valueOf(rs.getInt(6));
                user.Phone = rs.getString(7);
                user.Address = rs.getString(8);
                user.img= rs.getString(10);
            }

            rs.close();

            ////getting patients prescription history
            System.out.println("here2");
            ArrayList<PatientProfileAllData.Prescription> pres = new ArrayList<PatientProfileAllData.Prescription>();
            CallableStatement cmd_data = con.prepareCall("{call get_patient_history(?)}");
            cmd_data.setString(1, email);
            rs = cs.executeQuery();

            while (rs.next()) {
                PatientProfileAllData.Prescription p = new PatientProfileAllData.Prescription();
                p.Doctor_Name = rs.getString(1);
                p.Date = rs.getString(2);
                p.Disease_Diagnosed = rs.getString(3);
                //p.Prescription_ID = rs.getInt(4);
                //p.Prescription_ID = Integer.parseInt(rs.getString(4));

                pres.add(p);
            }
            rs.close();
            System.out.println("here3");

            ///getting the prescribed test and meds
            ArrayList<PatientProfileAllData.Meds> m = new ArrayList<>();
            ArrayList<PatientProfileAllData.Tests> t = new ArrayList<PatientProfileAllData.Tests>();
            for (int i = 0; i < pres.size(); i++)
            {
                int value = pres.get(i).Prescription_ID;
                CallableStatement cmd_data_test = con.prepareCall("{call get_prescriebed_test(?)}");
                cmd_data.setInt(1, value);
                rs = cs.executeQuery();

                while (rs.next())
                {
                    PatientProfileAllData.Tests test = new PatientProfileAllData.Tests();
                    test.Test = rs.getString(1);
                    test.Prescription_ID = pres.get(i).Prescription_ID;
                    t.add(test);
                }
                cmd_data_test.close();
                System.out.println("here4");
                CallableStatement cmd = con.prepareCall("{call get_prescriebed_med(?)}");
                cmd_data.setInt(1, pres.get(i).Prescription_ID);
                rs = cs.executeQuery();

                while (rs.next())
                {
                    PatientProfileAllData.Meds med = new PatientProfileAllData.Meds();
                    med.Med = rs.getString(1);
                   // med.Quantity = rs.getInt(2);
                    //med.Quantity = Integer.parseInt(rs.getString(2));
                    med.Prescription_ID = pres.get(i).Prescription_ID;
                    m.add(med);
                }
                rs.close();
            }
            System.out.println("here5");
            data.user = user;
            data.pres = pres;
            data.Test_List = t;
            data.Med_List = m;


            con.close();

            return data;
        }

        catch (SQLException e)
        {
            System.out.println(e);
        }
        return null;
    }
    public static ArrayList<Bill> PatientBills(String email) throws SQLException {

        sqlMain sqlConnection = new sqlMain();

        ArrayList<Bill> data = new ArrayList<Bill>();
        try
        {
            Connection con = sqlConnection.establishConnection();
            CallableStatement cs = con.prepareCall("{call getPatientBills(?)}");
            cs.setString(1, email);
            ResultSet rs = cs.executeQuery();
            while (rs.next())
            {
                Bill app = new Bill();
                app.Date = rs.getString(1);
                app.Doctor = rs.getString(2);
                app.Amount = String.valueOf(rs.getInt(3));
                app.Status = String.valueOf(rs.getInt(4));
                data.add(app);
            }
            rs.close();
            return data;
        }
        catch (SQLException e)
        {
            System.out.println(e);
        }
        return null;
    }
    public static int signup(String signup_mail_bt, String signup_pass_bt) throws SQLException {

        sqlMain sqlConnection = new sqlMain();
        int result = 0;

        try
        {
            Connection con = sqlConnection.establishConnection();
            CallableStatement cs = con.prepareCall("{call signup(?,?,?,?)}");
            cs.setString(1, signup_mail_bt);
            cs.setString(2, signup_pass_bt);
            cs.setString(3, "P");
            cs.registerOutParameter(4, Types.INTEGER);
            cs.execute();
            return cs.getInt(4);
        }

        catch (SQLException e)
        {
            System.out.println(e);
        }
        return result;

    }
    public static ArrayList<UserAuth> getAllUsers() {
        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cs = con.prepareCall("{call AllUsersAuth()}");
            ResultSet rdr = cs.executeQuery();
            ArrayList<UserAuth> list = new ArrayList<>();
            while (rdr.next())
            {
                UserAuth user = new UserAuth();

                user.Email = rdr.getString(1);
                user.Password = rdr.getString(2);
                user.UserType = rdr.getString(3);
                list.add(user);
            }
            rdr.close();
            con.close();
            return list;

        } catch (SQLException throwables) {
            throwables.printStackTrace();
            return null;
        }


    }
    public static singInResult signin(String signin_mail_bt, String signin_pass_bt)     {
        singInResult data = new singInResult();
        data.userType = 'x';
        try
        {

            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cs = con.prepareCall("{call signin(?,?) }");

            cs.setString(1, signin_mail_bt);
            cs.setString(2, signin_pass_bt);
            ResultSet rdr = cs.executeQuery();
            while (rdr.next())
            {
                data.userType = rdr.getString(1).charAt(0);
            }

            if (data.userType == 'x')
            {
                data.result = 0;
            }
            else
            {
                data.result = 1;
            }
            con.close();
            rdr.close();
            return data;
        }

        catch (SQLException ex)
        {
            System.out.println(ex);
            data.result = -1; //-1 will be interpreted as "error while connecting with the database."
        }

        return data;

    }
    public static int DoctorCount() {
        int result = 0;

        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cs = con.prepareCall("{call doctorcount(?)}");
            cs.registerOutParameter(1, Types.INTEGER);
            cs.execute();
            return cs.getInt(1);

        }
        catch (SQLException ex)
        {
            System.out.println(ex);
            result = -1; //-1 will be interpreted as "error while connecting with the database."
        }
        return result;

    }
    public static Doctor GetDoctor(String email) {

        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cmd = con.prepareCall("{call get_doctor(?)}");

            cmd.setString(1,email);
            ResultSet rdr = cmd.executeQuery();

            Doctor user = new Doctor();
            while (rdr.next())
            {

                user.DocID = rdr.getInt(1);
                user.Name = rdr.getString(2);
                user.Email = rdr.getString(3);
                user.City = rdr.getString(4);
                user.Gender = rdr.getString(5);
                user.Age = rdr.getString(6);
                user.Phone = rdr.getString(7);
                user.img = rdr.getString(8);
                user.start_time = rdr.getString(9);
                user.end_time = rdr.getString(10);
            }
            rdr.close();
            cmd.close();
            cmd = con.prepareCall("{call getDoctorSpecialization(?)}");
            cmd.setString(1, String.valueOf(user.DocID));
            rdr = cmd.executeQuery();

            String speciality;
            while (rdr.next())
            {
                speciality = rdr.getString(1);
                user.specializations.add(speciality);
            }
            rdr.close();
            con.close();

            return user;
        }

        catch (SQLException ex)
        {
            System.out.println(ex);
            return null;

        }
    }
    public static ArrayList<Doctor> GetAllDoctors()  {

        try
        {
            sqlMain sqlConnection =  new sqlMain();
            Connection con = sqlConnection.establishConnection();

            CallableStatement cmd = con.prepareCall("{call getAllDoctors()}");
            ResultSet rdr = cmd.executeQuery();

            ArrayList<Doctor> docs = new ArrayList<Doctor>();
            while (rdr.next())
            {
                Doctor user = new Doctor();
                user.DocID = rdr.getInt(1);
                user.Name = rdr.getString(2);
                user.Email = rdr.getString(3);
                user.City = rdr.getString(4);
                user.Gender = rdr.getString(5);
                user.Age = rdr.getString(6);
                user.Phone = rdr.getString(7);
                user.Fee = rdr.getString(8);
                user.img = rdr.getString(9);
                user.start_time = rdr.getString(10);
                user.end_time = rdr.getString(11);
                docs.add(user);
            }


            for (Doctor user : docs)
            {
                rdr.close();
                cmd.close();
                cmd = con.prepareCall("{call getDoctorSpecialization(?)}");
                cmd.setString(1, String.valueOf(user.DocID));
                rdr = cmd.executeQuery();

                String speciality;
                while (rdr.next())
                {
                    speciality = rdr.getString(1);
                    user.specializations.add(speciality);
                }
            }
            con.close();

            return docs;
        }

        catch (SQLException ex)
        {
            System.out.println(ex);
            return null;

        }
    }
    public static ArrayList<Appointments> GetDocAppointments(int doctorID)    {
        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cmd = con.prepareCall("{call getDocAppointments(?)}");
            cmd.setInt(1,doctorID);

            ResultSet rdr = cmd.executeQuery();

            ArrayList<Appointments> list = new ArrayList<Appointments>();
            while (rdr.next())
            {
                Appointments user = new Appointments();

                user.app_id = rdr.getString(1);
                user.patient_name = rdr.getString(2);
                user.app_date = rdr.getString(3);
                user.starting_time = rdr.getString(4);
                user.ending_time = rdr.getString(5);

                list.add(user);
            }
            rdr.close();
            con.close();

            return list;

        }

        catch (SQLException ex)
        {
            System.out.println(ex);
            return null;

        }
    }
    public static ArrayList<Appointments> GetAllAppointments(String appointment_date, int doctor_chosen)    {
        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cmd = con.prepareCall("{call Available_Slots(?,?,?)}");
            cmd.setString(1,appointment_date);
            cmd.setInt(2,doctor_chosen);
            cmd.registerOutParameter(3, Types.INTEGER);
            ResultSet rdr = cmd.executeQuery();

            ArrayList<Appointments> list = new ArrayList<>();
            while (rdr.next())
            {
                Appointments user = new Appointments();
                user.app_id = rdr.getString(1);
                user.starting_time = rdr.getString(2);
                user.ending_time = rdr.getString(3);
                user.doctor_name = rdr.getString(4);

                list.add(user);
            }
            rdr.close();
            con.close();

            return list;

        }

        catch (SQLException ex)
        {
            System.out.println(ex);
            return null;

        }
    }
    public static int BookAppointment(int patientID, String appid)    {
        int result = 0;
        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cmd = con.prepareCall("{call Book_appointment(?,?,?) }");
            cmd.setInt(1,patientID);
            cmd.setString(2,appid);
            cmd.registerOutParameter(3,Types.INTEGER);
            cmd.execute();

            result = cmd.getInt(3);

            con.close();
        }

        catch (SQLException ex)
        {
            System.out.println(ex);
            return -1;

        }
        return result;
    }
    public static ArrayList<Doctor> GetDoctorBasic()    {


        try
        {

            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cmd = con.prepareCall("{call getAllDoctors()}");

            ResultSet rdr = cmd.executeQuery();

            ArrayList<Doctor> docs = new ArrayList<>();
            while (rdr.next())
            {
                Doctor user = new Doctor();
                user.DocID = rdr.getInt(1);
                user.Name = rdr.getString(2);
                user.Email = rdr.getString(3);
                docs.add(user);
            }
            rdr.close();

            for (Doctor user : docs)
            {
                cmd.close();
                cmd = con.prepareCall("{call getDoctorSpecialization(?)}");
                cmd.setInt(1,user.DocID);

                rdr = cmd.executeQuery();

                while (rdr.next())
                {
                    String speciality;
                    speciality = rdr.getString(1);
                    user.specializations.add(speciality);
                }
                rdr.close();
            }
            con.close();

            return docs;
        }

        catch (SQLException ex)
        {
            System.out.println(ex);
            return null;

        }
    }
    public static int AddPrescriptionHistoryBill(String app, String disease, ArrayList<Meds> meds, String[] tests)    {
        int result =0;
        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cmd = con.prepareCall("{call addprescription_history_bill(?,?,?)}");
            cmd.setInt(1,Integer.parseInt(app));
            cmd.setString(2,disease);

            cmd.registerOutParameter(3,Types.INTEGER);
            cmd.execute();
            result = cmd.getInt(3);

            int i = 0;
            for (Meds med : meds)
            {
                cmd.close();
                cmd = con.prepareCall("{call addprescribedmed (?,?,?)}");
                cmd.setInt(1,result);
                cmd.setString(2,med.Med);
                cmd.setInt(3,med.Quantity);
                i++;
                cmd.execute();
            }


            for (String test : tests)
            {
                cmd.close();
                cmd = con.prepareCall("{call addprescribedtest (?,?)}");
                cmd.setInt(1,result);
                cmd.setString(2,test);
                cmd.execute();
            }

        }
        catch (SQLException ex)
        {
            System.out.println(ex);
            result = -1; //-1 will be interpreted as "error while connecting with the database."
        }
        return result;

    }
    public static Prescriptiondetails GetPrescriptionDetails(String appid)    {
        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cmd = con.prepareCall("{call getAppointmentbyid(?)}");
            cmd.setInt(1,Integer.parseInt(appid));
            ResultSet rdr = cmd.executeQuery();

            Prescriptiondetails details = new Prescriptiondetails();

            while (rdr.next())
            {

                details.doctor_name = rdr.getString(1);
                details.patient_name = rdr.getString(2);
                details.patient_age =rdr.getString(3);
                details.patient_gender =rdr.getString(4);
                details.date = rdr.getString(5);
            }
            rdr.close();;
            con.close();

            return details;

        }

        catch (SQLException ex)
        {
            System.out.println(ex);
            return null;

        }
    }
    public static ArrayList<Appointments> BookedAppointments()    {
        ArrayList<Appointments> data = new ArrayList<>();

        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cmd = con.prepareCall("{call Booked_Appointments()}");
            ResultSet rdr = cmd.executeQuery();

            while (rdr.next())
            {
                Appointments app = new Appointments();

                app.starting_time =rdr.getString(1);
                app.ending_time = rdr.getString(2);
                app.patient_name = rdr.getString(3);
                app.doctor_name = rdr.getString(4);
                app.app_date = rdr.getString(5);

                data.add(app);
            }

        }

        catch ( SQLException ex)
        {
            System.out.println(ex);
        }

        return data;
    }
    public static int register_doctor(String img, String path, String doc_name_bt, String doc_email_bt, String doc_password_bt, String doc_city_bt, int doc_age_bt, String doc_gender_bt, String doc_phone_bt, String radio_bt_doc, ArrayList<String> doc_specialization_bt, int doc_fee_bt)
    {

        int result = 0;
        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cmd = con.prepareCall("{call addValidation(?,?,?,?)}");

            cmd.setString(1,doc_email_bt);
            cmd.setString(2,doc_password_bt);
            cmd.setString(3,"D");

            cmd.registerOutParameter(4,Types.INTEGER);

            cmd.execute();

            result = cmd.getInt(4);

            cmd.close();

            int DoctorID = 0;
            cmd = con.prepareCall("{call AppointNewDoctor(?,?,?,?,?,?,?,?,?,?,?)}");
            cmd.setString(1,doc_name_bt);
            cmd.setString(2,doc_email_bt);
            cmd.setString(3,doc_city_bt);
            cmd.setString(4,doc_gender_bt);
            cmd.setInt(5,doc_age_bt);
            cmd.setString(6,doc_phone_bt);
            cmd.setInt(7,doc_fee_bt);
            cmd.setString(8,img);
            cmd.setString(9,path);
            cmd.registerOutParameter(10,Types.INTEGER);
            cmd.registerOutParameter(11,Types.INTEGER);

            cmd.execute();


            result = cmd.getInt(10);
            DoctorID = cmd.getInt(11);

            for (String sf : doc_specialization_bt)
            {
                result = add_specialization(DoctorID, sf);
            }

            con.close();
        }
        catch ( SQLException ex)
        {
            System.out.println(ex);
            result = -1; //-1 will be interpreted as "error while connecting with the database."
        }

        return result;


    }
    public static int add_specialization(int DoctorID,String specialization)    {


        int result = 0;

        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cmd = con.prepareCall("{call addSpecialization(?,?,?)}");

            cmd.setInt(1,DoctorID);
            cmd.setString(2,specialization);
            cmd.registerOutParameter(3,Types.INTEGER);

            cmd.execute();
            result = cmd.getInt(3);

            cmd.close();
            con.close();
            return result;
        }
        catch (SQLException ex)
        {
            System.out.println(ex);
            result = -1; //-1 will be interpreted as "error while connecting with the database."
        }
        return result;
    }
    public static ArrayList<Bill> All_Bills()    {
        ArrayList<Bill> data = new ArrayList<>();

        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cmd = con.prepareCall("{call get_unpaid_bill()}");

            ResultSet rdr = cmd.executeQuery();


            while (rdr.next())
            {
                Bill app = new Bill();
                app.Date = rdr.getString("PresDate");
                app.Amount = rdr.getString("Bill");
                app.Patient = rdr.getString("Patient");
                app.Doctor = rdr.getString("Doctor");
                app.PresID = rdr.getString("PresID");
                app.Status = rdr.getString("status");

                data.add(app);
            }

            rdr.close();
            cmd.close();
            con.close();

        }

        catch (SQLException ex)
        {
            System.out.println(ex);
        }
        return data;
    }
    public static void Update_Payment(String id)    {
        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cmd = con.prepareCall("{call update_payment_status(?)}");
            try {
                cmd.setInt(1,Integer.parseInt(id));
            }
            catch (NumberFormatException ex)
            {

            }
            cmd.executeUpdate();
            cmd.close();
            con.close();
        }
        catch (SQLException ex)
        {
            System.out.println(ex);
        }
    }

    public static void Insert_Appointments()    {
        ArrayList<Doctor> doc_list = CRUD.GetAllDoctors();


        try
        {
            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();


            for (Doctor d : doc_list)
            {
                CallableStatement cmd = con.prepareCall("{call insert_appointments(?)}");
                cmd.setInt(1,d.DocID);
                cmd.execute();
            }
            con.close();
        }

        catch (SQLException ex)
        {
            System.out.println(ex);
        }
    }

    public static void UpdateDocTime(int DocID, String start, String end)
    {
        try
        {

            sqlMain sqlConnection = new sqlMain();
            Connection con = sqlConnection.establishConnection();
            CallableStatement cmd = con.prepareCall("{call updateAvailability(?,?,?)}");
            cmd.setInt(1,DocID);
            cmd.setTime(2, Time.valueOf(start));
            cmd.setTime(3,Time.valueOf(end));
            cmd.execute();

            cmd.close();
            con.close();
        }

        catch (SQLException ex)
        {
            System.out.println(ex);
        }
    }

}

