
<%--
  Created by IntelliJ IDEA.
  User: kiki
  Date: 2023/4/24
  Time: 下午8:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Title</title>
    <style>
        div{
            border: lightyellow 0.5px solid;
            border-radius: 10px;
            background-color: rgba(0,0,0,0.2);
            width: 800px;
            box-shadow: lightsteelblue 2px 2px 30px;
        }
        body{
            background: url("img/3.jpg") no-repeat;

        }
        pre{
            font-family: STKaiti;
            font-size: 20px;

        }
        .warn{
            border-radius: 10px;
            color: red;

        }
    </style>
</head>
<body>

<div>

          <pre style="color: linen">
                                                                ❤️温馨提示❤️
          尊敬的家人们：
              根据气象部门预报，近日来我区未来四天有连续降雨。
              物业服务中心为了避免各位家人的自行车、电动车、摩托车淋雨，
              除了东西车棚可以正常停放，大家还可以把爱车停放到临时停车点！
              地点：酒店大堂门厅后门（从一二号楼裙楼东车棚中间进入）
              请大家有序摆放！谢谢配合！
                                                                                      10月20日
                                                                                   无垠物业服务中心
          </pre>

</div>

<c:if test="${sessionScope.login_user==null}">
              <pre class="warn">
                  注意：当前您处于未登录状态,请登录后正常使用系统！！！
              </pre>
</c:if>



</body>
</html>

