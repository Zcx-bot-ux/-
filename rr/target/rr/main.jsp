<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
     <%--注释编码配置--%>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <!-- 引入 Bootstrap -->
    <script src="http://apps.bdimg.com/libs/jquery/1.11.1/jquery.min.js"></script>
    <link href="http://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入 font-awesome -->
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="http://apps.bdimg.com/libs/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <title>智慧社区云平台</title>
<%--         设置左边菜单选中显示样式，动态改变iframe中src属性值，加载不同的页面--%>
    <script type="application/javascript">
        function change(url,index){
            //1、移除所有左侧菜单的“active"样式
            $(".list-group-item").removeClass("active");
            //2、给第index个菜单添加”active“样式
            $(".list-group-item").eq(index).addClass("active");
            //3、改变iframe的src属性，加载目标页面（url参数指定的页面）
            $("iframe").attr("src",url);
        }
    </script>
</head>
<body>
   <%--  nav整体导航部分--%>
    <nav class="navbar navbar-inverse" role="navigation">
    <div class="container-fluid">
        <ul class="nav navbar-nav navbar-left">
            <li>
                <a style="font-size: 30px;color:lightsteelblue">
                    <i class="fa fa-home fa-fw" style="color: lightskyblue" ></i>
                    智慧社区平台-无垠二部
                </a>
            </li>
        </ul>
        <ul class="nav navbar-nav navbar-right">
            <c:if test="${sessionScope.login_user==null}">
                <li>
                    <a style="font-size: 18px" href="/register.jsp">注册</a>
                </li>
                <li>
                    <a style="font-size: 18px" href="/login.jsp">登录</a>
                </li>
            </c:if>
            <c:if test="${sessionScope.login_user!=null}">
                <li>
                    <a style="font-size: 18px" href="#">欢迎您，${sessionScope.login_user.nickname}</a>
                </li>
                <li>
                    <a style="font-size: 18px" href="/loginout">退出</a>
                </li>
            </c:if>
        </ul>
    </div>
    </nav>
   <%--  中间区域--%>
   <div class="container-fluid">
       <div class="row">
           <!--  左边导航-->
           <div class="col-sm-2">
               <a href="javascript:void(0)" class="list-group-item active" onclick="change('/notice',0)">
						<span class="" aria-hidden="true">
							<i class="fa fa-address-card-o fa-fw"></i>
						</span>公告首页
               </a>
               <c:if test="${sessionScope.login_user!=null}">
               <a href="javascript:void(0)" class="list-group-item" onclick="change('/house/list',1)">
						<span class="" aria-hidden="true">
							<i class="fa fa-home fa-fw"></i>
						</span>房屋管理
               </a>
               <a href="javascript:;" class="list-group-item" onclick="change('/car?way=list',2)">
						<span class="" aria-hidden="true">
							<i class="fa fa-bed fa-fw"></i>
						</span>车位管理
               </a>
               <a href="javascript:;" class="list-group-item" onclick="change('/chart.jsp',3)">
						<span class="" aria-hidden="true">
							<i class="fa fa-user-circle fa-fw"></i>
						</span>数据统计
               </a>
               <a href="javascript:;" class="list-group-item" onclick="change('/device?way=list',4)">
						<span class="" aria-hidden="true">
							<i class="fa fa-bookmark fa-fw"></i>
						</span>设备管理
               </a>
               <a href="javascript:;" class="list-group-item" onclick="change('/rent',5)">
						<span class="" aria-hidden="true">
							<i class="fa fa-home fa-fw"></i>
						</span>租户管理
               </a>
               <a href="javascript:;" class="list-group-item" onclick="change('/notice',6)">
						<span class="" aria-hidden="true">
							<i class="fa fa-address-card-o fa-fw"></i>
						</span>公告管理
               </a>
               <a href="javascript:;" class="list-group-item" onclick="change('/user?way=list',7)">
						<span class="" aria-hidden="true">
							<i class="fa fa-address-card-o fa-fw"></i>
						</span>用户管理
               </a>
               </c:if>
           </div>
           <!--右边内容 主显示区域-->
<%--           内联框架--%>
           <!--  iframe中src属性值，初始-->
           <iframe style="width: 81%; height: 660px; border: 0px;" src="/notice"></iframe>
       </div>
   </div>
   <!--  底部导航-->
   <div class="footer">
       <p class="text-center" style="line-height: 90px">
           无垠智慧社区  @2023备案：晋中信息学院双体二部
       </p>
   </div>

</body>
</html>
