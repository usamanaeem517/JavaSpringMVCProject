package com.clinic.models;
import java.sql.*;

public class sqlMain {
    public sqlMain(){

    }
    public Connection establishConnection(){
        try {

            String url = "jdbc:sqlserver://DESKTOP-6OJ2QM1\\MYSQL;user=sa;password=12345678;database=HealthStreet";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection con = DriverManager.getConnection(url);
            DatabaseMetaData dm = con.getMetaData();
            System.out.println(dm.getDriverVersion());
            System.out.println(dm.getDriverName());
            System.out.println(dm.getDatabaseProductName());
            System.out.println(dm.getDatabaseProductVersion());
            return con;

        } catch (Exception e) {
            System.out.println(e);
            return null;
        }
    }
}
