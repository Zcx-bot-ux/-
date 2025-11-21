<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录页面</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <!-- 1. jQuery库（百度CDN）：用于简化DOM操作和AJAX请求 -->
    <script src="http://apps.bdimg.com/libs/jquery/1.11.1/jquery.min.js"></script>
    <!-- 2. Bootstrap库（百度CDN）：用于美化页面，如：按钮、表单、表格、导航栏、模态框、分页、标签、进度条、下拉菜单、缩略图、轮播图等等 -->
    <link href="http://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入 font-awesome -->
    <!-- 3. Font Awesome图标库（CDN）：提供用户、锁等图标（如<i class="fa fa-user"></i>） -->
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- 4. Bootstrap JS（百度CDN）：提供Bootstrap的交互功能（如弹窗、下拉菜单） -->
    <script src="http://apps.bdimg.com/libs/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <div class="form row" style="height: 300px;">
        <form class="form-horizontal col-md-offset-3" id="login_form" action="/login" method="post">
            <h3 class="form-title">用户登录</h3>
            <div class="col-md-9">
                <%--根据LoginServlet返回的值   request.setAttribute("errUserMsg","没有该用户！"); 进行数据的展示--%>
                <i style="color: red">${requestScope.errUserMsg}</i>
                <div class="form-group">
                    <i class="fa fa-user fa-lg"></i>
                    <input class="form-control required" required placeholder="请输入用户名" type="text"name="username"/>
                </div>
                <i style="color: red">${requestScope.errPasswordMsg}</>
                <div class="form-group">
                    <i class="fa fa-lock fa-lg"></i>
                    <input class="form-control required" required placeholder="请输入密码" type="password" name="password"/>
                </div>

                <div class="form-group col-md-offset-9">
                    <button type="submit" class="btn btn-success pull-left" name="submit">登录</button>
                    <button type="reset" class="btn btn-success pull-right" name="submit">重置</button>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
    $(function(){
        $('[data-toggle="popover"]').popover();

    });
</script>
</body>
</html>
