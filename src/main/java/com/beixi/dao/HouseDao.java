package com.beixi.dao;


import com.beixi.pjo.House;
import com.beixi.util.JDBCUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class HouseDao {
    //查询房屋列表
    public static List<House> findHouseList() {
        List<House> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtil.getConn();
            String sql = "select * from house";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            //对resultSet结果集进行数据的解析和封装
            while (rs.next()) {
                House house = new House();
                int id = rs.getInt("id");
                String housenum = rs.getString("housenum");
                String buildnum = rs.getString("buildnum");
                String unitnum = rs.getString("unitnum");
                float area = rs.getFloat("area");
                int status = rs.getInt("status");
                Timestamp addtime = rs.getTimestamp("addtime");
                Date date = new Date(addtime.getTime());
                house.setId(id);
                house.setHousenum(housenum);
                house.setBuildnum(buildnum);
                house.setUnitnum(unitnum);
                house.setArea(area);
                house.setStatus(status);
                house.setAddtime(date);
                list.add(house);
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        } finally {
            //资源的关闭
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

        }

        return list;
    }

    public static int addHouse(String housenum, String buildnum, String unitnum, String area, String instatus) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = JDBCUtil.getConn();
            String sql = "insert into house values (null,?,?,?,?,?,?)";
            ps = conn.prepareStatement(sql);
            //设置占位符的值
            ps.setString(1, housenum);
            ps.setString(2, buildnum);
            ps.setString(3, unitnum);
            // 需要将String类型的area 转化成float类型  为什么这样做？因为数据库是float类型的
            float area1 = Float.parseFloat(area);
            ps.setFloat(4, area1);
            // 需要将String类型的instatus 转化成int类型 为什么这样做？因为数据库是int类型的
            int intInstatus = Integer.parseInt(instatus);
            ps.setInt(5, intInstatus);
            //因为在表中的 addtime字段 是当前时间  所以我们需要初始化当前时间，时间又是Timestamp类型的
            //所以需要将Date转化成Timestamp类型
            //初始化当前时间
            Date d = new Date();
            //将Date转化成Timestamp类型
            Timestamp timestamp = new Timestamp(d.getTime());
            ps.setTimestamp(6, timestamp);
            int i = ps.executeUpdate();
            return i;
        } catch (Exception e) {
            System.out.println(e.toString());
        } finally {
            //资源的关闭
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return 0;
    }

    public static int updateHouse(String id, String housenum, String buildnum, String unitnum, String area, String instatus) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = JDBCUtil.getConn();
            String sql = "update house set housenum =?,buildnum=?,unitnum=?,area=?,status=? where id =?";
            ps = conn.prepareStatement(sql);
            //设置占位符的值
            ps.setString(1, housenum);
            ps.setString(2, buildnum);
            ps.setString(3, unitnum);
            // 需要将String类型的area 转化成float类型  为什么这样做？因为数据库是float类型的
            float area1 = Float.parseFloat(area);
            ps.setFloat(4, area1);
            // 需要将String类型的instatus 转化成int类型 为什么这样做？因为数据库是int类型的
            int intInstatus = Integer.parseInt(instatus);
            ps.setInt(5, intInstatus);
            int id1 = Integer.parseInt(id);
            ps.setInt(6, id1);
            int i = ps.executeUpdate();
            return i;
        } catch (Exception e) {
            System.out.println(e.toString());
        } finally {
            //资源的关闭
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return 0;
    }

    public static int delHouse(String id) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = JDBCUtil.getConn();
            String sql = "delete from house where id =?";
            ps = conn.prepareStatement(sql);;
            int id1 = Integer.parseInt(id);
            ps.setInt(1, id1);
            int i = ps.executeUpdate();
            return i;
        } catch (Exception e) {
            System.out.println(e.toString());
        } finally {
            //资源的关闭
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return 0;
    }

    public static List<House> searchHouseList(String value) {
        List<House> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = JDBCUtil.getConn();
            String sql = "SELECT * FROM house WHERE housenum LIKE ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1,"%"+value+"%");
            rs = ps.executeQuery();
            //对resultSet结果集进行数据的解析和封装
            while (rs.next()) {
                House house = new House();
                int id = rs.getInt("id");
                String housenum = rs.getString("housenum");
                String buildnum = rs.getString("buildnum");
                String unitnum = rs.getString("unitnum");
                float area = rs.getFloat("area");
                int status = rs.getInt("status");
                Timestamp addtime = rs.getTimestamp("addtime");
                Date date = new Date(addtime.getTime());
                house.setId(id);
                house.setHousenum(housenum);
                house.setBuildnum(buildnum);
                house.setUnitnum(unitnum);
                house.setArea(area);
                house.setStatus(status);
                house.setAddtime(date);
                list.add(house);
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        } finally {
            //资源的关闭
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

        }

        return list;
    }
}