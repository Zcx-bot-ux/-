package com.beixi.servlet;


import com.beixi.dao.UserDao;
import com.beixi.pjo.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("1111111111111111");
        //设置编码
        request.setCharacterEncoding("UTF-8");
        //获取页面的值
        //获取用户名  对应括号里的值和页面中的name的属性值相对应
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        //根据用户名查询数据库
        User loginUser = UserDao.findUserByUserName(username);
        //没有查到数据信息
        if (loginUser==null){
            //转发到login.jsp中  并且提示 没有该用户
            request.setAttribute("errUserMsg","没有该用户！");
            request.getRequestDispatcher("/login.jsp").forward(request,response);
        }else {
            //数据库中用户的密码
            String loginPassword = loginUser.getPassword();
            //用数据库中用户的密码和页面中接收到的密码进行比较
            if(!loginPassword.equals(password)){
                //转发到login.jsp中  并且提示 用户的密码错误
                request.setAttribute("errUserMsg","用户的密码错误！");
                //转发
                request.getRequestDispatcher("/login.jsp").forward(request,response);
            }else {

                HttpSession session = request.getSession();
                //在session域对象（session缓存中存入登录者的信息）  作用：在其他的页面或者servlet中可以通过session取登录者的信息
                session.setAttribute("login_user",loginUser);
                //登录成功 跳转到main.jsp中
                response.sendRedirect("/main.jsp");
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request,response);
    }
}
