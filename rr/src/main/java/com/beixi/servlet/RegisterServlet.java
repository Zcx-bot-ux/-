package com.beixi.servlet;

import com.beixi.dao.UserDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request,response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //注册业务
        request.setCharacterEncoding("UTF-8");
        //从页面中获取对应的值
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String nickname = request.getParameter("nickname");
        //如果i>0 新增数据成功
        int i = UserDao.addUser(username, password, nickname);
        if(i>0){
            //注册成功，跳转到登录页面
            response.sendRedirect("/login.jsp");
        }
    }
}
