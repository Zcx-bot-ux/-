package com.beixi.dao;

import com.beixi.pjo.Device;
import com.beixi.util.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DeviceDao {

    public List<Device> findDeviceList() {
        List<Device> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            conn = JDBCUtil.getConn();
            String sql = "select * from equipment";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while(rs.next()){
                int id = rs.getInt("id");
                String equipmentCode = rs.getString("equipment_code");
                String name = rs.getString("name");
                String type = rs.getString("type");
                String location = rs.getString("location");
                Date installDate = rs.getDate("install_date");
                String status = rs.getString("status");
                Date lastMaintainDate = rs.getDate("last_maintain_date");
                String maintainer = rs.getString("maintainer");
                String remark = rs.getString("remark");
                Date createDate = rs.getDate("create_time");
                Date updateDate = rs.getDate("update_time");
                Device device = new Device(id,equipmentCode,name,type,location,installDate,status,lastMaintainDate,maintainer,remark,createDate,updateDate);
                list.add(device);
            }
            return list;
        }catch(Exception e){
            System.out.println(e);
        }finally{
            JDBCUtil.close(conn,ps,rs);
        }
        return list;
    }

    public List<Device> searchDeviceList(String keyword, String type, String status) {
        List<Device> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtil.getConn();
            StringBuilder sql = new StringBuilder("SELECT * FROM equipment WHERE 1=1");
            List<Object> params = new ArrayList<>();
            //匹配设备名称或设备编号
            if(keyword != null){
                sql.append(" and (name like ? or equipment_code like ?)");
                params.add("%"+keyword+"%");
                params.add("%"+keyword+"%");
            }
            //设备类型条件
            if(type != null){
                sql.append(" and type=?");
                params.add(type);
            }
            //设备状态条件
            if(status != null){
                sql.append(" and status = ?");
                params.add(status);
            }
            ps = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            //对resultSet结果集进行数据的解析和封装
            while (rs.next()) {
                int id = rs.getInt("id");
                String equipmentCode = rs.getString("equipment_code");
                String name = rs.getString("name");
                String location = rs.getString("location");
                Date installDate = rs.getDate("install_date");
                Date lastMaintainDate = rs.getDate("last_maintain_date");
                String maintainer = rs.getString("maintainer");
                String remark = rs.getString("remark");
                Date createDate = rs.getDate("create_time");
                Date updateDate = rs.getDate("update_time");
                String dbType = rs.getString("type");
                String dbStatus = rs.getString("status");
                Device device = new Device(id,equipmentCode,name,dbType,location,installDate,dbStatus,lastMaintainDate,maintainer,remark,createDate,updateDate);

                list.add(device);
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        } finally {
            JDBCUtil.close(conn, ps, rs);
        }
        return list;
    }

    public int addDevice(String equipmentCode, String name, String type, String location, String installDate, String status, String lastMaintainDate, String maintainer, String remark) {
        Connection conn = null;
        PreparedStatement ps = null;
        int i = 0;
        try {
            conn = JDBCUtil.getConn();
            String sql = "insert into equipment values (null,?,?,?,?,?,?,?,?,?,?,?)";
            ps = conn.prepareStatement(sql);
            //设置占位符的值
            ps.setString(1, equipmentCode);
            ps.setString(2, name);
            ps.setString(3, type);
            ps.setString(4, location);
            ps.setDate(5, java.sql.Date.valueOf(installDate));//这里将String类型转化为sql日期对象
            ps.setString(6, status);

            ps.setDate(7, lastMaintainDate == null ? null : java.sql.Date.valueOf(lastMaintainDate));
            ps.setString(8, maintainer);
            ps.setString(9, remark);
            java.util.Date d = new java.util.Date();
            Timestamp timestamp = new Timestamp(d.getTime());
            ps.setTimestamp(10, timestamp);
            ps.setTimestamp(11, timestamp);
            i = ps.executeUpdate();

        } catch (Exception e) {
            System.out.println(e.toString());
        } finally {
            JDBCUtil.close(conn,ps,null);
        }
        return i;
    }

    public Device getDeviceById(String id) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            conn = JDBCUtil.getConn();
            String sql = "select * from equipment where id=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1,id);
            rs = ps.executeQuery();
            if(rs.next()){
                int id1 = Integer.parseInt(id);
                String equipmentCode = rs.getString("equipment_code");
                String name = rs.getString("name");
                String type = rs.getString("type");
                String location = rs.getString("location");
                Date installDate = rs.getDate("install_date");
                String status = rs.getString("status");
                Date lastMaintainDate = rs.getDate("last_maintain_date");
                String maintainer = rs.getString("maintainer");
                String remark = rs.getString("remark");
                Date createDate = rs.getDate("create_time");
                Date updateDate = rs.getDate("update_time");
                Device device = new Device(id1,equipmentCode,name,type,location,installDate,status,lastMaintainDate,maintainer,remark,createDate,updateDate);
                return device;
            }
        }catch(Exception e){
            System.out.println(e);
        }finally{
            JDBCUtil.close(conn,ps,rs);
        }
        return null;
    }

    public int delteById(String id) {
        Connection conn = null;
        PreparedStatement ps = null;
        int i = 0;
        try{
            conn = JDBCUtil.getConn();
            String sql = "delete from equipment where id=?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1,Integer.parseInt(id));
            i = ps.executeUpdate();
        }catch(Exception e){
            System.out.println(e);
        }finally{
            JDBCUtil.close(conn,ps,null);
        }
        return i;
    }
    public int updateDevice(String id,String equipmentCode, String name, String type, String location, String installDate, String status, String lastMaintainDate, String maintainer, String remark){
        Connection conn = null;
        PreparedStatement ps = null;
        int i = 0;
        try{
            conn = JDBCUtil.getConn();
            String sql = "update equipment set equipment_code=?,name=?,type=?,location=?,install_date=?,status=?,last_maintain_date=?,maintainer=?,remark=?,update_time=? where id=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1,equipmentCode);
            ps.setString(2,name);
            ps.setString(3,type);
            ps.setString(4,location);
            ps.setDate(5,java.sql.Date.valueOf(installDate));
            ps.setString(6,status);
            ps.setDate(7,lastMaintainDate==null?null:java.sql.Date.valueOf(lastMaintainDate));
            ps.setString(8,maintainer);
            ps.setString(9,remark);
            java.util.Date d = new java.util.Date();
            Timestamp timestamp = new Timestamp(d.getTime());
            ps.setTimestamp(10,timestamp);
            ps.setInt(11,Integer.parseInt(id));
            i = ps.executeUpdate();
        }catch(Exception e){
            System.out.println(e);
        }finally{
            JDBCUtil.close(conn,ps,null);
        }
        return i;
    }
}
