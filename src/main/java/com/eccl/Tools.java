package com.eccl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;


public class Tools {
	
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
		Connection conn = null;
		try
		{
			String DB_URL = "jdbc:mysql://"+this.HOST+":"+this.PORT+"/"+this.DBNAME;
			// 注册 JDBC 驱动
			Class.forName("com.mysql.jdbc.Driver");
			// 打开链接
            System.out.println("连接数据库...");
            conn = DriverManager.getConnection(DB_URL,this.USERNAME,this.PASSWORD);
            if(conn != null) {
            	return conn;
            }
		}
		catch(SQLException se) {
            // 处理 JDBC 错误
            se.printStackTrace();
        }catch(Exception e) {
            // 处理 Class.forName 错误
            e.printStackTrace();
        }
		return null;
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
		// 将Map转换为JSONArray数据
        JSONArray jArray = new JSONArray();
        
		ResultSetMetaData md = rs.getMetaData();//获取键名
		int columnCount = md.getColumnCount();//获取行的数量
		while (rs.next()) {
			HashMap<String,String> rowData = new HashMap<String,String>();//声明Map
			for (int i = 1; i <= columnCount; i++) {
				rowData.put(md.getColumnName(i), rs.getString(i));//获取键名及值
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
            // 完成后关闭
            rs.close();
            stmt.close();
            conn.close();
            return al;
		}
		return null;
	}
	
	public boolean initDb() throws Exception {
		Connection conn =  this.getConn();
		if(conn!=null) {
			String creatsql="CREATE TABLE `table_dummy2` ("
  +" `ID` int(12) NOT NULL AUTO_INCREMENT COMMENT '唯一标识',"
  +" `KEY` varchar(2000) DEFAULT '' COMMENT 'KEY',"
  +" PRIMARY KEY (`ID`) "
  +" ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;";
			Statement stmt = conn.createStatement();
			if(0 == stmt.executeUpdate(creatsql))
			{
				System.out.println("成功创建表！");
				String insertSql="INSERT INTO `table_dummy2` VALUES ('1', 'MYSQL_TEST_NIUJL2')";
				if(1 == stmt.executeUpdate(insertSql))
				{
					System.out.println("成功添加记录！");
					return true;
				}
			}
			stmt.close();
			conn.close();
		}
		return false;
	}
	
	public String getEnv() {
		String tmp="";
		Map<String, String> map = System.getenv();
        for(Iterator<String> itr = map.keySet().iterator();itr.hasNext();){
            String key = itr.next();
            tmp += key + "=" + map.get(key)+"@@";
        }
        return tmp;
	}
}
