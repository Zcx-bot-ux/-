package com.beixi.dao;

import com.beixi.pjo.Car;
import com.beixi.util.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class CarDao {

    public List<Car> findCarList() {
        List<Car> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtil.getConn();
            String sql = "select * from car";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            //对resultSet结果集进行数据的解析和封装
            while(rs.next()){
                int id = rs.getInt("id");
                int carnum = rs.getInt("carnum");
                String area = rs.getString("area");
                String location = rs.getString("location");
                int size = rs.getInt("size");
                int status = rs.getInt("status");
                Timestamp addtime = rs.getTimestamp("addtime");
                Date date = new Date(addtime.getTime());
                Car car = new Car(id, carnum, area, location, size, status, date);
                list.add(car);
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }finally {
            //资源的关闭
            JDBCUtil.close(conn,ps,rs);
        }
    return list;
    }

    public List<Car> searchCarList(String value) {
        List<Car> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtil.getConn();
            String sql = "select * from car where carnum like ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1,"%"+value+"%");
            rs = ps.executeQuery();
            //对resultSet结果集进行数据的解析和封装
            while(rs.next()){
                int id = rs.getInt("id");
                int carnum = rs.getInt("carnum");
                String area = rs.getString("area");
                String location = rs.getString("location");
                int size = rs.getInt("size");
                int status = rs.getInt("status");
                Timestamp addtime = rs.getTimestamp("addtime");
                Date date = new Date(addtime.getTime());
                Car car = new Car(id, carnum, area, location, size, status, date);
                list.add(car);
            }
        }catch(Exception e){
            System.out.println(e.toString());
        }finally {
            //资源的关闭
            JDBCUtil.close(conn,ps,rs);
        }
        return list;
    }

    public int addCar(String carnum, String location, String area, String size, String instatus) {
        Connection conn = null;
        PreparedStatement ps = null;
        try{
            conn = JDBCUtil.getConn();
            String sql = "insert into car values(null,?,?,?,?,?,?)";
            ps = conn.prepareStatement(sql);
            int carnum1 = Integer.parseInt(carnum);
            ps.setInt(1,carnum1);
            ps.setString(2,area);
            ps.setString(3,location);
            int size1 = Integer.parseInt(size);
            ps.setInt(4,size1);
            ps.setInt(5,Integer.parseInt(instatus));
            Date d = new Date();
            Timestamp ts = new Timestamp(d.getTime());
            ps.setTimestamp(6,ts);
            int i = ps.executeUpdate();
            return i;
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            JDBCUtil.close(conn,ps,null);
        }
        return 0;
    }

    public int updateCar(String id, String carnum, String location, String area, String size, String instatus) {
        Connection conn = null;
        PreparedStatement ps = null;
        try{
            conn = JDBCUtil.getConn();
            String sql = "update car set carnum=?,location=?,area=?,size=?,status=? where id=?";
            ps = conn.prepareStatement(sql);
            int carnum1 = Integer.parseInt(carnum);
            ps.setInt(1,carnum1);
            ps.setString(2,location);
            ps.setString(3,area);
            int size1 = Integer.parseInt(size);
            ps.setInt(4,size1);
            ps.setInt(5,Integer.parseInt(instatus));
            int id1 = Integer.parseInt(id);
            ps.setInt(6,id1);
            int i = ps.executeUpdate();
            return i;
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            JDBCUtil.close(conn,ps,null);
        }
        return 0;
    }

    public int deleteCar(String id) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = JDBCUtil.getConn();
            String sql = "delete from car where id =?";
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
}
