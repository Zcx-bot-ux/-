package com.beixi.servlet;

import com.beixi.dao.CarDao;
import com.beixi.pjo.Car;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

@WebServlet("/car")
public class CarServlet extends HttpServlet {
    CarDao dao = new CarDao();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String way = request.getParameter("way");
        if("search".equals(way)){
            this.search(request,response);
        }else if("add".equals(way)){
            this.add(request,response);
        }else if("list".equals(way)){
            this.list(request,response);
        }else if("update".equals(way)){
            this.update(request,response);
        }else if("delete".equals(way)){
            this.delete(request,response);
        }

    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String id = request.getParameter("id");
        int del = dao.deleteCar(id);
        if(del>0){
            request.getRequestDispatcher("/car?way=list").forward(request,response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        this.doPost(request,response);
    }
    private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //查询所有车位
        List<Car> carList = dao.findCarList();
        //将carList放在request对象中，跳转到carlist.jsp中
        request.setAttribute("carlist",carList);
        request.getRequestDispatcher("carlist.jsp").forward(request,response);
    }

    private void update(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        String carnum = request.getParameter("carnum");
        String location = request.getParameter("location");
        String area = request.getParameter("area");
        String size = request.getParameter("size");
        String instatus = request.getParameter("instatus");
        int upd = dao.updateCar(id,carnum,location,area,size,instatus);
        if(upd>0){
            request.getRequestDispatcher("/car?way=list").forward(request,response);
        }
    }
    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("UTF-8");
        String carnum = request.getParameter("carnum");
        String location = request.getParameter("location");
        String area = request.getParameter("area");
        String size = request.getParameter("size");
        String instatus =request.getParameter("instatus");
        int add = dao.addCar(carnum,location,area,size,instatus);
        if(add>0){
            response.sendRedirect("/car?way=list");
        }

    }
    private void search(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String value = request.getParameter("selectValue");
        //查询house列表
        List<Car> carList = dao.searchCarList(value);
        //将houseList放入request对象中 跳转到houseList.jsp中
        request.setAttribute("carlist",carList);
        request.getRequestDispatcher("/carlist.jsp").forward(request,response);
    }
}
