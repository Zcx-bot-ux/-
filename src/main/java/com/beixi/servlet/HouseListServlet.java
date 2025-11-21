package com.beixi.servlet;
import com.beixi.dao.HouseDao;
import com.beixi.pjo.House;

import com.beixi.dao.HouseDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/house/list")
public class HouseListServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //来查询house列表
        List<House> houseList = HouseDao.findHouseList();
        //将houseList放在request对象中 跳转到houselist.jsp中
        request.setAttribute("houselist",houseList);
        request.getRequestDispatcher("/houselist.jsp").forward(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
