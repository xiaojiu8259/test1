package com.eccl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import oracle.jdbc.*;

import org.json.JSONArray;
import org.json.JSONObject;

public class OracleTools {
	
	private static String HOST;
	private static String PORT;
	private static String USERNAME;
	private static String PASSWORD;
	private static String DBNAME;
	
	public void setHost(String host) {
		HOST = host;
	}
	
	public void setPort(String port) {
		PORT = port;
	}

	public void setUserName(String username) {
		USERNAME = username;
	}

	public void setPassword(String password) {
		PASSWORD = password;
	}
	
	public void setDBname(String dbname) {
		DBNAME = dbname;
	}
	
	public Connection getConn() {
       Connection c = null;
       try {
           Class.forName("oracle.jdbc.driver.OracleDriver");
           // Ҫ�ǵ�������û�гɹ��Ļ����ǻ����classnotfoundException.�Լ������ǲ����������,����classpath��Щ����
       } catch (ClassNotFoundException e) {
           e.printStackTrace();
       }
       try {
           c = DriverManager.getConnection("jdbc:oracle:thin:@"+this.HOST+":"+this.PORT+":"+this.DBNAME,this.USERNAME,this.PASSWORD);
           if(c != null) {
           	return c;
           }
       } catch (SQLException e) {
           e.printStackTrace();
       }
       return c;
	}
	
	public boolean testConnection(String host,String port,String username,String passwd,String dbname) throws Exception {
		this.setHost(host);
		this.setPort(port);
		this.setUserName(username);
		this.setPassword(passwd);
		this.setDBname(dbname);
		
		Connection conn =  this.getConn();
		if(conn!=null) {
			//conn.close();
			return true;
		}
		return false;
	}
	
	private String convertList(ResultSet rs) throws SQLException{
		// ��Mapת��ΪJSONArray����
        JSONArray jArray = new JSONArray();
        
		ResultSetMetaData md = rs.getMetaData();//��ȡ����
		int columnCount = md.getColumnCount();//��ȡ�е�����
		while (rs.next()) {
			HashMap<String,String> rowData = new HashMap<String,String>();//����Map
			for (int i = 1; i <= columnCount; i++) {
				rowData.put(md.getColumnName(i), rs.getString(i));//��ȡ������ֵ
			}
			jArray.put(rowData);
		}
		JSONObject jObject=new JSONObject();
        jObject.put("List", jArray);
        return jObject.toString();
	}
	
	public String querySql(String sql) throws Exception {
		Connection conn =  this.getConn();
		if(conn!=null) {
			Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            String al = convertList(rs);
            // ��ɺ�ر�
            rs.close();
            stmt.close();
            conn.close();
            return al;
		}
		return null;
	}
}
