package com.beixi.servlet;

import com.beixi.dao.HouseDao;
import com.beixi.dao.HouseDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/house/update")
public class HouseUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        String housenum = request.getParameter("housenum");
        String buildnum = request.getParameter("buildnum");
        String unitnum = request.getParameter("unitnum");
        String area = request.getParameter("area");
        String instatus = request.getParameter("instatus");
        int upd = HouseDao.updateHouse(id,housenum,buildnum,unitnum,area,instatus);
        if(upd>0){
            //跳转到/house/list  sevlet中，将数据重新查询一次
            response.sendRedirect("/house/list");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request,response);
    }
}
