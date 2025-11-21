<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册页面</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 引入 Bootstrap -->
    <script src="http://apps.bdimg.com/libs/jquery/1.11.1/jquery.min.js"></script>
    <link href="http://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入 font-awesome -->
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="http://apps.bdimg.com/libs/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<%--    引入自己的样式，对背景实现自动切换--%>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <div class="form row" style="height: 300px;">
        <form class="form-horizontal col-md-offset-3" action="/register" method="post">
            <h3 class="form-title" >用户注册</h3>
            <div class="col-md-9">
                <div class="form-group">
                    <i class="fa fa-user fa-lg"></i>
                    <input class="form-control required" required placeholder="请输入用户名" type="text"name="username"/>
                </div>
                <div class="form-group">
                    <i class="fa fa-lock fa-lg"></i>
                    <input class="form-control required" required placeholder="请输入密码" type="password" name="password"/>
                </div>
                <div class="form-group">
                    <i class="fa fa-heart"></i>
                    <input class="form-control required" required placeholder="请输入昵称" type="text" name="nickname"/>
                </div>
                <div class="form-group col-md-offset-9">
                    <button type="submit" class="btn btn-success pull-left">注册</button>
                    <button type="reset" class="btn btn-success pull-right">重置</button>
                </div>
            </div>
        </form>
    </div>
</div>

</body>
</html>
