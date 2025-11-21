package com.beixi.util;

import com.alibaba.druid.pool.DruidDataSourceFactory;

import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class JDBCUtil {
    public static void main(String[] args) throws Exception {
        System.out.println(getConn());
    }

    public static Connection getConn() throws Exception {
        Properties pro = new Properties();
        //反射
        //类加载读取druid.properties文件
        InputStream resourceAsStream = JDBCUtil.class.getClassLoader().getResourceAsStream("druid.properties");
        pro.load(resourceAsStream);
        //2.获取DataSource  创建数据源
        DataSource ds = DruidDataSourceFactory.createDataSource(pro);
        Connection connection = ds.getConnection();
        return connection;
    }
    public static void close(Connection conn, Statement ps, ResultSet rs) {
        if(rs != null){
            try {
                rs.close();
            }catch(SQLException e){
                e.printStackTrace();
            }
        }
        if(ps != null){
            try {
                ps.close();
            }catch(SQLException e){
                e.printStackTrace();
            }
        }
        if(conn != null){
            try {
                conn.close();
            }catch(SQLException e){
                e.printStackTrace();
            }
        }
    }

}
