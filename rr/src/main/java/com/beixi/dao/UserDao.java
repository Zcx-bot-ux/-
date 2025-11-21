package com.beixi.dao;


import com.beixi.pjo.User;
import com.beixi.util.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class UserDao {

    //方法：添加用户
    public static int addUser(String username,String password,String nickname){
        Connection conn =null;
        PreparedStatement ps =null;
        try{
            conn = JDBCUtil.getConn();
            String sql  = "insert into user(id,username,password,nickname) values (null,?,?,?)";
            ps = conn.prepareStatement(sql);
            //给占位符赋值
            ps.setString(1,username);
            ps.setString(2,password);
            ps.setString(3,nickname);
            int i = ps.executeUpdate();
            return i;
        }catch (Exception e){
            System.out.println(e.toString());
        }finally {
            //资源的关闭
            if(ps!=null){
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if(conn!=null){
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

        }
        return 0;
    }
    //方法：根据用户名来查询用户信息 static是静态的方法 将来用类直接来调用，不用通过创建对象再取调用
    public static User findUserByUserName(String userName){
        Connection conn =null;
        PreparedStatement ps =null;
        ResultSet rs =null;
        try{
            conn = JDBCUtil.getConn();
            String sql  = "select * from user where username =?";
            ps = conn.prepareStatement(sql);
            //给占位符赋值
            ps.setString(1,userName);
            rs = ps.executeQuery();
            //对resultSet结果集进行数据的解析和封装
            while (rs.next()){
                User user = new User();
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String nickname = rs.getString("nickname");
                user.setId(id);
                user.setUsername(username);
                user.setPassword(password);
                user.setNickname(nickname);
                return user;
            }
        }catch (Exception e){
            System.out.println(e.toString());
        }finally {
            //资源的关闭
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if(ps!=null){
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if(conn!=null){
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

        }
        return null;
    }

    public List<User> findUserList() {
        List<User> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            conn = JDBCUtil.getConn();
            String sql = "select * from user";
            ps = conn.prepareStatement(sql);
            rs= ps.executeQuery();
            //对resultSet结果集进行数据的解析和封装
            while(rs.next()){
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String nickname = rs.getString("nickname");
                User user = new User(id,username,password,nickname);
                list.add(user);
            }
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            JDBCUtil.close(conn,ps,rs);
        }
        return list;
    }

    public int updateUser(String id, String username, String password, String nickname) {
        Connection conn = null;
        PreparedStatement ps = null;
        int i = 0;
        try{
            conn = JDBCUtil.getConn();
            String sql = "update user set username=?,password=?,nickname=? where id=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1,username);
            ps.setString(2,password);
            ps.setString(3,nickname);
            int id1 = Integer.parseInt(id);
            ps.setInt(4,id1);
            i = ps.executeUpdate();

        }catch(Exception e){
            e.printStackTrace();
        }finally {
            JDBCUtil.close(conn,ps,null);
        }
        return i;
    }

    public int deleteUser(String id) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = JDBCUtil.getConn();
            String sql = "delete from user where id =?";
            ps = conn.prepareStatement(sql);;
            int id1 = Integer.parseInt(id);
            ps.setInt(1, id1);
            int i = ps.executeUpdate();
            return i;
        } catch (Exception e) {
            System.out.println(e.toString());
        } finally {
            JDBCUtil.close(conn, ps, null);
        }
        return 0;
    }

    public List<User> searchByName(String value) {
        List<User> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            conn = JDBCUtil.getConn();
            String sql = "select * from user where (username like ? or nickname like ?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1,"%"+value+"%");
            ps.setString(2,"%"+value+"%");
            rs = ps.executeQuery();
            while(rs.next()){
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String nickname = rs.getString("nickname");
                 User user = new User(id,username,password,nickname);
                 list.add(user);
            }
        }catch(Exception e){
            System.out.println(e);
        }finally{
            JDBCUtil.close(conn,ps,rs);
        }
        return list;
    }
}
