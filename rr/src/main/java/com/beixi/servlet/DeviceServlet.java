package com.beixi.servlet;

import com.beixi.dao.DeviceDao;
import com.beixi.pjo.Device;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.awt.datatransfer.DataFlavor;
import java.io.IOException;
import java.util.List;

@WebServlet("/device")
public class DeviceServlet extends HttpServlet {
    DeviceDao deviceDao = new DeviceDao();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String way = request.getParameter("way");
        if("list".equals(way)){
            this.list(request,response);
        }else if("add".equals(way)){
            this.add(request,response);
        }else if("search".equals(way)){
            this.search(request,response);
        }else if("get".equals(way)){
            this.get(request,response);
        }else if("delete".equals(way)){
            this.delete(request,response);
        }else if("update".equals(way)){
            this.update(request,response);
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        int i = deviceDao.delteById(id);
        if(i>0){
            response.sendRedirect("/device?way=list");
        }
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        String equipmentCode = request.getParameter("equipmentCode");
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String location = request.getParameter("location");
        String installDate = request.getParameter("installDate");
        String status = request.getParameter("status");
        String lastMaintainDate = request.getParameter("lastMaintainDate");
        String maintainer = request.getParameter("maintainer");
        String remark = request.getParameter("remark");
        int update = deviceDao.updateDevice(id,equipmentCode,name,type,location,installDate,status,lastMaintainDate,maintainer,remark);
        if(update>0){
            response.sendRedirect("/device?way=list");
        }
    }

    private void get(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json;charset=UTF-8");//响应JSON格式
        String id = request.getParameter("id");
        Device device = deviceDao.getDeviceById(id);
        request.setAttribute("device",device);

        //将设备对象转为JSON,返回到前端(使用Jackon/Gson等工具)
        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(device);

        //相应给前端
        response.getWriter().write(json);
    }

    private void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("2222222222222");
        String keyword = request.getParameter("keyword");
        String type = request.getParameter("type");
        String status = request.getParameter("status");

        keyword = (keyword == null || keyword.trim().isEmpty()) ? null : keyword.trim();
        type = (type == null || type.trim().isEmpty()) ? null : type.trim();
        status = (status == null || status.trim().isEmpty()) ? null : status.trim();


        List<Device> deviceList = deviceDao.searchDeviceList(keyword,type,status);
        request.setAttribute("equipmentList",deviceList);
//        HttpSession session = request.getSession();
//        session.setAttribute("equipmentList",deviceList);
        request.getRequestDispatcher("/devicelist.jsp").forward(request, response);
//        response.sendRedirect("/devicelist.jsp");
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String equipmentCode = request.getParameter("equipmentCode");
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String location = request.getParameter("location");
        String installDate = request.getParameter("installDate");
        String status = request.getParameter("status");
        String lastMaintainDate = request.getParameter("lastMaintainDate");
        String maintainer = request.getParameter("maintainer");
        String remark = request.getParameter("remark");
        int add = deviceDao.addDevice(equipmentCode,name,type,location,installDate,status,lastMaintainDate,maintainer,remark);
        if(add > 0){
            response.sendRedirect("/device?way=list");
        }
    }

    private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Device> deviceList = deviceDao.findDeviceList();
        request.setAttribute("equipmentList",deviceList);
        request.getRequestDispatcher("/devicelist.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        this.doPost(request, response);
    }
}
