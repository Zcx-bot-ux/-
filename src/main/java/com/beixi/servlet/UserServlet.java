package com.beixi.servlet;

import com.beixi.dao.UserDao;
import com.beixi.pjo.User;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
    UserDao userDao = new UserDao();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");
        String way = request.getParameter("way");
        if("list".equals(way)){
            this.list(request,response);
        }else if("add".equals(way)){
            this.add(request,response);
        }else if("get".equals(way)){
            this.get(request,response);
        }else if("delete".equals(way)){
            this.delete(request,response);
        }else if("update".equals(way)){
            this.update(request,response);
        }else if("searchByName".equals(way)){
            this.searchByName(request,response);
        }
    }

    private void searchByName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String value = request.getParameter("selectValue");
        List<User> userlist = userDao.searchByName(value);
        request.setAttribute("userlist", userlist);
        request.getRequestDispatcher("/userlist.jsp").forward(request, response);
    }


    private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String nickname = request.getParameter("nickname");
        int i = userDao.updateUser(id, username, password, nickname);
        if(i>0){
            System.out.println("用户修改成功");
            request.getRequestDispatcher("/user?way=list").forward(request, response);
        }
    }

    private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        int i = userDao.deleteUser(id);
        if(i>0){
            request.getRequestDispatcher("/user?way=list").forward(request, response);
        }

    }

    private void get(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //响应JSON格式
        response.setContentType("application/json;charset=UTF-8");
        String value = request.getParameter("selectValue");
        //1、查询user列表
        User user = UserDao.findUserByUserName(value);

        //2、将User对象转化为JSON（使用Jackson等工具）
        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(user);//自动将User的属性转为JSON字段
        //3、响应给前端
        response.getWriter().write(json);

    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String nickname = request.getParameter("nickname");
        int i = userDao.addUser(username, password, nickname);
        if(i>0){
            request.getRequestDispatcher("/user?way=list").forward(request, response);
        }
    }
    private void list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("way");
        List<User> userList = userDao.findUserList();
        //将userList放入request对象中,跳转到userlist.jsp中
        request.setAttribute("userlist", userList);
        request.getRequestDispatcher("/userlist.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        this.doPost(request, response);
    }

}
