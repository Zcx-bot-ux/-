<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <!-- 引入 Bootstrap -->
    <script src="http://apps.bdimg.com/libs/jquery/1.11.1/jquery.min.js"></script>
    <link href="http://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入 font-awesome -->
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="http://apps.bdimg.com/libs/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <title>智慧社区平台 - 用户列表</title>
    <style>
        .container {
            margin-top: 20px;
        }
        .panel-heading {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .action-icon {
            margin: 0 5px;
            cursor: pointer;
        }
        .action-icon.edit {
            color: #337ab7;
        }
        .action-icon.delete {
            color: #d9534f;
        }
        .search-bar {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
<!-- 页面标题 -->
<div class="container">
    <div class="page-header">
        <h1><i class="fa fa-users"></i> 用户管理
            <small>用户基本信息维护</small>
        </h1>
    </div>

    <!-- 操作面板 -->
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">用户列表</h3>
            <button class="btn btn-success btn-sm" data-toggle="modal" data-target="#addUserModal">
                <i class="fa fa-plus"></i> 新增用户
            </button>
        </div>

        <!-- 搜索区域 -->
        <div class="panel-body">
            <div class="search-bar">
                <div class="input-group">
                    <input type="text" class="form-control" id="searchKeyword" placeholder="输入用户名或昵称搜索">
                    <span class="input-group-btn">
                        <button class="btn btn-primary" id="searchBtn"><i class="fa fa-search"></i> 搜索</button>
                        <button class="btn btn-default" id="resetBtn"><i class="fa fa-refresh"></i> 重置</button>
                    </span>
                </div>
            </div>

            <!-- 用户列表表格 -->
            <table class="table table-bordered table-hover table-striped">
                <thead>
                <tr class="info">
                    <th>ID</th>
                    <th>用户名</th>
                    <th>密码</th>
                    <th>昵称</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="userTableBody">
                <!-- 动态数据展示 -->
                <c:forEach items="${userlist}" var="user">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.username}</td>
                        <td>
                            <!-- 密码显示处理：实际应用中建议显示为*** -->
                            <c:choose>
                                <c:when test="${showPassword}">${user.password}</c:when>
                                <c:otherwise>***</c:otherwise>
                            </c:choose>
                        </td>
                        <td>${user.nickname}</td>
                        <td>
                            <i class="fa fa-pencil action-icon edit" data-username="${user.username}" title="编辑"></i>
                            <i class="fa fa-trash action-icon delete" data-id="${user.id}" title="删除"></i>
                        </td>
                    </tr>
                </c:forEach>

                <!-- 无数据提示 -->
                <c:if test="${empty userList}">
                    <tr>
                        <td colspan="5" class="text-center">暂无用户数据</td>
                    </tr>
                </c:if>
                </tbody>
            </table>

            <!-- 分页控件 -->
            <div class="text-center">
                <ul class="pagination">
                    <li <c:if test="${currentPage == 1}">class="disabled"</c:if>>
                        <a href="?page=1"><i class="fa fa-angle-double-left"></i></a>
                    </li>
                    <li <c:if test="${currentPage == 1}">class="disabled"</c:if>>
                        <a href="?page=${currentPage-1 < 1 ? 1 : currentPage-1}"><i class="fa fa-angle-left"></i></a>
                    </li>

                    <c:forEach begin="${startPage}" end="${endPage}" var="i">
                        <li <c:if test="${i == currentPage}">class="active"</c:if>>
                            <a href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <li <c:if test="${currentPage == totalPage}">class="disabled"</c:if>>
                        <a href="?page=${currentPage+1 > totalPage ? totalPage : currentPage+1}"><i class="fa fa-angle-right"></i></a>
                    </li>
                    <li <c:if test="${currentPage == totalPage}">class="disabled"</c:if>>
                        <a href="?page=${totalPage}"><i class="fa fa-angle-double-right"></i></a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- 新增用户模态框 -->
<div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="addUserLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="addUserLabel"><i class="fa fa-user-plus"></i> 新增用户</h4>
            </div>
            <form id="addUserForm" action="user?way=add" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="username" class="control-label">用户名:</label>
                        <input type="text" class="form-control" id="username" name="username"
                               required placeholder="请输入用户名">
                    </div>
                    <div class="form-group">
                        <label for="password" class="control-label">密码:</label>
                        <input type="password" class="form-control" id="password" name="password"
                               required placeholder="请输入密码">
                    </div>
                    <div class="form-group">
                        <label for="nickname" class="control-label">昵称:</label>
                        <input type="text" class="form-control" id="nickname" name="nickname"
                               required placeholder="请输入昵称">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- 编辑用户模态框 -->
<div class="modal fade" id="editUserModal" tabindex="-1" role="dialog" aria-labelledby="editUserLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="editUserLabel"><i class="fa fa-pencil"></i> 编辑用户</h4>
            </div>
            <form id="editUserForm" action="user?way=update" method="post">
                <input type="hidden" id="editId" name="id">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="editUsername" class="control-label">用户名:</label>
                        <input type="text" class="form-control" id="editUsername" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="editPassword" class="control-label">密码:</label>
                        <input type="password" class="form-control" id="editPassword" name="password"
                               placeholder="不修改请留空">
                    </div>
                    <div class="form-group">
                        <label for="editNickname" class="control-label">昵称:</label>
                        <input type="text" class="form-control" id="editNickname" name="nickname" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="submit" class="btn btn-primary">更新</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $(function() {
        // 编辑按钮点击事件
        $(".action-icon.edit").click(function() {
            var username = $(this).data("username");
            // AJAX获取用户详情
            $.getJSON("/user?way=get&selectValue=" + username)
                .done( function(user) {
                    if (user) {
                        $("#editId").val(user.id);
                        $("#editUsername").val(user.username);
                        $("#editNickname").val(user.nickname);
                        // 密码不回显，保持为空让用户决定是否修改
                        $("#editUserModal").modal("show");
                    }else{
                        alert("用户不存在");
                    }
                }).fail(function(xhr){//失败回调
                    console.error("请求失败：",xhr.statue,xhr.responseText);
                    alert("加载用户数据失败，请检查网络或后端接口");

                });
        });

        // 删除按钮点击事件
        $(".action-icon.delete").click(function() {
            var userId = $(this).data("id");
            if (confirm("确定要删除ID为 " + userId + " 的用户吗？")) {
                window.location.href = "user?way=delete&id=" + userId;
            }
        });

        // 搜索功能
        $("#searchBtn").click(function() {
            var keyword = $("#searchKeyword").val();
            // 跳转到搜索结果页
            window.location.href = "user?way=searchByName&selectValue=" + encodeURIComponent(keyword);
        });

        // 重置搜索
        $("#resetBtn").click(function() {
            $("#searchKeyword").val("");
            window.location.href = "user?way=list";
        });

        // 回车键触发搜索
        $("#searchKeyword").keypress(function(e) {
            if (e.which == 13) {
                $("#searchBtn").click();
            }
        });
    });
</script>
</body>
</html>