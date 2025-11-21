<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="viewport" content="width=device-width, initial-scale=1.0">
    <title>幸福小区设备管理系统</title>
    <!-- 引入入 Bootstrap -->
    <link href="http://apps.bdimg.com/libs/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入 Font Awesome -->
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <!-- 引入 jQuery -->
    <script src="http://apps.bdimg.com/libs/jquery/2.1.1/jquery.min.js"></script>
    <script src="http://apps.bdimg.com/libs/bootstrap/3.3.0/js/bootstrap.min.js"></script>

    <style>
        .container { margin-top: 20px; }
        .page-header { margin-bottom: 30px; }
        .search-bar { margin: 20px 0; padding: 15px; background-color: #f5f5f5; border-radius: 4px; }
        .table th, .table td { text-align: center; vertical-align: middle !important; }
        .status-normal { color: #3c763d; background-color: #dff0d8; padding: 3px 8px; border-radius: 3px; }
        .status-repair { color: #8a6d3b; background-color: #fcf8e3; padding: 3px 8px; border-radius: 3px; }
        .status-scrap { color: #a94442; background-color: #f2dede; padding: 3px 8px; border-radius: 3px; }
        .action-btn { margin: 0 3px; }
    </style>
</head>
<body>
<div class="container">
    <!-- 页头 -->
    <div class="page-header">
        <h1><i class="fa fa-cogs"></i> 幸福小区设备管理系统
            <small>设备全生命周期管理</small>
        </h1>
    </div>

    <!-- 搜索区域 -->
    <div class="search-bar">
        <form class="form-inline" action="/device?way=search" method="post">
            <div class="form-group">
                <label for="keyword">设备名称/编号：</label>
                <input type="text" class="form-control" id="keyword" name="keyword"
                       value="${param.keyword}" placeholder="请输入关键词">
            </div>
            <div class="form-group">
                <label for="type">设备类型：</label>
                <select class="form-control" id="type" name="type">
                    <option value="">全部类型</option>
                    <option value="安全设施" ${param.type == '安全设施' ? 'selected' : ''}>安全设施</option>
                    <option value="特种设备" ${param.type == '特种设备' ? 'selected' : ''}>特种设备</option>
                    <option value="安防设备" ${param.type == '安防设备' ? 'selected' : ''}>安防设备</option>
                    <option value="供水设备" ${param.type == '供水设备' ? 'selected' : ''}>供水设备</option>
                    <option value="公共照明" ${param.type == '公共照明' ? 'selected' : ''}>公共照明</option>
                    <option value="环保设备" ${param.type == '环保设备' ? 'selected' : ''}>环保设备</option>
                    <option value="休闲设备" ${param.type == '休闲设备' ? 'selected' : ''}>休闲设备</option>
                    <option value="便民设备" ${param.type == '便民设备' ? 'selected' : ''}>便民设备</option>
                </select>
            </div>
            <div class="form-group">
                <label for="status">设备状态：</label>
                <select class="form-control" id="status" name="status">
                    <option value="">全部状态</option>
                    <option value="正常" ${param.status == '正常' ? 'selected' : ''}>正常</option>
                    <option value="维修中" ${param.status == '维修中' ? 'selected' : ''}>维修中</option>
                    <option value="报废" ${param.status == '报废' ? 'selected' : ''}>报废</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i> 搜索</button>
            <button type="button" class="btn btn-default" onclick="resetForm()">
                <i class="fa fa-refresh"></i> 重置
            </button>
            <button type="button" class="btn btn-success pull-right" data-toggle="modal" data-target="#addModal">
                <i class="fa fa-plus"></i> 新增设备
            </button>
        </form>
<%--        <form class="form-inline" action="/device?way=search" method="post">--%>
<%--            <div class="form-group">&ndash;%&gt;--%>
<%--                <label for="keyword">设备名称/编号：</label>--%>
<%--                <input type="text" class="form-control" id="keyword" name="keyword"--%>
<%--                value="${param.keyword}" placeholder="请输入关键词">--%>
<%--            </div>--%>
<%--        <input type="submit" value="搜索">--%>
<%--        </form>--%>
    </div>

    <!-- 设备列表表格 -->
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">设备列表 <span class="badge">${equipmentList.size()}</span></h3>
        </div>
        <table class="table table-bordered table-hover">
            <thead>
            <tr>
                <th>ID</th>
                <th>设备编号</th>
                <th>设备名称</th>
                <th>设备类型</th>
                <th>安装位置</th>
                <th>安装日期</th>
                <th>设备状态</th>
                <th>最近维护日期</th>
                <th>维护负责人</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${equipmentList}" var="eql">
                <tr>
                    <td>${eql.id}</td>
                    <td>${eql.equipmentCode}</td>
                    <td>${eql.name}</td>
                    <td>${eql.type}</td>
                    <td>${eql.location}</td>
                    <td><fmt:formatDate value="${eql.installDate}" pattern="yyyy-MM-dd"/></td>
                    <td>
                        <c:choose>
                            <c:when test="${eql.status == '正常'}">
                                <span class="status-normal">${eql.status}</span>
                            </c:when>
                            <c:when test="${eql.status == '维修中'}">
                                <span class="status-repair">${eql.status}</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-scrap">${eql.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <c:if test="${not empty eql.lastMaintainDate}">
                            <fmt:formatDate value="${eql.lastMaintainDate}" pattern="yyyy-MM-dd"/>
                        </c:if>
                        <c:if test="${empty eql.lastMaintainDate}">-</c:if>
                    </td>
                    <td>${eql.maintainer}</td>
                    <td>
                        <button class="btn btn-xs btn-info action-btn" data-toggle="modal"
                                data-target="#viewModal" onclick="viewDetail(${eql.id})">
                            <i class="fa fa-eye"></i> 查看
                        </button>
                        <button class="btn btn-xs btn-warning action-btn" data-toggle="modal"
                                data-target="#editModal" onclick="editEquipment(${eql.id})">
                            <i class="fa fa-pencil"></i> 编辑
                        </button>
                        <button class="btn btn-xs btn-danger action-btn"
                                onclick="deleteEquipment(${eql.id}, '${eql.name}')">
                            <i class="fa fa-trash"></i> 删除
                        </button>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty equipmentList}">
                <tr>
                    <td colspan="10" class="text-center">暂无设备数据</td>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>

    <!-- 分页控件 -->
    <div class="text-center">
        <nav>
            <ul class="pagination">
                <li <c:if test="${currentPage == 1}">class="disabled"</c:if>>
                    <a href="?page=1${queryParams}" aria-label="First">
                        <span aria-hidden="true">&laquo;&laquo;</span>
                    </a>
                </li>
                <li <c:if test="${currentPage == 1}">class="disabled"</c:if>>
                    <a href="?page=${currentPage-1 < 1 ? 1 : currentPage-1}${queryParams}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>

                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                    <li <c:if test="${i == currentPage}">class="active"</c:if>>
                        <a href="?page=${i}${queryParams}">${i}</a>
                    </li>
                </c:forEach>

                <li <c:if test="${currentPage == totalPage}">class="disabled"</c:if>>
                    <a href="?page=${currentPage+1 > totalPage ? totalPage : currentPage+1}${queryParams}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
                <li <c:if test="${currentPage == totalPage}">class="disabled"</c:if>>
                    <a href="?page=${totalPage}${queryParams}" aria-label="Last">
                        <span aria-hidden="true">&raquo;&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</div>

<!-- 新增设备模态框 -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="addModalLabel"><i class="fa fa-plus-circle"></i> 新增设备</h4>
            </div>
            <form id="addForm" action="/device?way=add" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="addCode" class="control-label">设备编号 <span class="text-danger">*</span>：</label>
                        <input type="text" class="form-control" id="addCode" name="equipmentCode"
                               required placeholder="例如：SB-20251115-001">
                    </div>
                    <div class="form-group">
                        <label for="addName" class="control-label">设备名称 <span class="text-danger">*</span>：</label>
                        <input type="text" class="form-control" id="addName" name="name"
                               required placeholder="请输入设备名称">
                    </div>
                    <div class="form-group">
                        <label for="addType" class="control-label">设备类型 <span class="text-danger">*</span>：</label>
                        <select class="form-control" id="addType" name="type" required>
                            <option value="">请选择设备类型</option>
                            <option value="安全设施">安全设施</option>
                            <option value="特种设备">特种设备</option>
                            <option value="安防设备">安防设备</option>
                            <option value="供水设备">供水设备</option>
                            <option value="公共照明">公共照明</option>
                            <option value="环保设备">环保设备</option>
                            <option value="休闲设备">休闲设备</option>
                            <option value="便民设备">便民设备</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="addLocation" class="control-label">安装位置 <span class="text-danger">*</span>：</label>
                        <input type="text" class="form-control" id="addLocation" name="location"
                               required placeholder="请输入安装位置">
                    </div>
                    <div class="form-group">
                        <label for="addInstallDate" class="control-label">安装日期 <span class="text-danger">*</span>：</label>
                        <input type="date" class="form-control" id="addInstallDate" name="installDate" required>
                    </div>
                    <div class="form-group">
                        <label for="addStatus" class="control-label">设备状态 <span class="text-danger">*</span>：</label>
                        <select class="form-control" id="addStatus" name="status" required>
                            <option value="正常">正常</option>
                            <option value="维修中">维修中</option>
                            <option value="报废">报废</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="addMaintainDate" class="control-label">最近维护日期：</label>
                        <input type="date" class="form-control" id="addMaintainDate" name="lastMaintainDate">
                    </div>
                    <div class="form-group">
                        <label for="addMaintainer" class="control-label">维护负责人：</label>
                        <input type="text" class="form-control" id="addMaintainer" name="maintainer"
                               placeholder="请输入维护负责人">
                    </div>
                    <div class="form-group">
                        <label for="addRemark" class="control-label">备注信息：</label>
                        <textarea class="form-control" id="addRemark" name="remark" rows="3"
                                  placeholder="请输入备注信息（可选）"></textarea>
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

<!-- 查看设备详情模态框 -->
<div class="modal fade" id="viewModal" tabindex="-1" role="dialog" aria-labelledby="viewModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="viewModalLabel"><i class="fa fa-eye"></i> 设备详情</h4>
            </div>
            <div class="modal-body">
                <table class="table table-striped">
                    <tr>
                        <td width="30%"><strong>设备编号：</strong></td>
                        <td id="viewCode"></td>
                    </tr>
                    <tr>
                        <td><strong>设备名称：</strong></td>
                        <td id="viewName"></td>
                    </tr>
                    <tr>
                        <td><strong>设备类型：</strong></td>
                        <td id="viewType"></td>
                    </tr>
                    <tr>
                        <td><strong>安装位置：</strong></td>
                        <td id="viewLocation"></td>
                    </tr>
                    <tr>
                        <td><strong>安装日期：</strong></td>
                        <td id="viewInstallDate"></td>
                    </tr>
                    <tr>
                        <td><strong>设备状态：</strong></td>
                        <td id="viewStatus"></td>
                    </tr>
                    <tr>
                        <td><strong>最近维护日期：</strong></td>
                        <td id="viewMaintainDate"></td>
                    </tr>
                    <tr>
                        <td><strong>维护负责人：</strong></td>
                        <td id="viewMaintainer"></td>
                    </tr>
                    <tr>
                        <td><strong>备注信息：</strong></td>
                        <td id="viewRemark"></td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!-- 编辑设备模态框 (结构类似新增，略作调整) -->
<div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="editModalLabel"><i class="fa fa-pencil"></i> 编辑设备</h4>
            </div>
            <form id="editForm" action="/device?way=update" method="post">
                <input type="hidden" id="editId" name="id">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="updateCode" class="control-label">设备编号 <span class="text-danger">*</span>：</label>
                        <input type="text" class="form-control" id="updateCode" name="equipmentCode"
                               required placeholder="例如：SB-20251115-001">
                    </div>
                    <div class="form-group">
                        <label for="updateName" class="control-label">设备名称 <span class="text-danger">*</span>：</label>
                        <input type="text" class="form-control" id="updateName" name="name"
                               required placeholder="请输入设备名称">
                    </div>
                    <div class="form-group">
                        <label for="updateType" class="control-label">设备类型 <span class="text-danger">*</span>：</label>
                        <select class="form-control" id="updateType" name="type" required>
                            <option value="">请选择设备类型</option>
                            <option value="安全设施">安全设施</option>
                            <option value="特种设备">特种设备</option>
                            <option value="安防设备">安防设备</option>
                            <option value="供水设备">供水设备</option>
                            <option value="公共照明">公共照明</option>
                            <option value="环保设备">环保设备</option>
                            <option value="休闲设备">休闲设备</option>
                            <option value="便民设备">便民设备</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="updateLocation" class="control-label">安装位置 <span class="text-danger">*</span>：</label>
                        <input type="text" class="form-control" id="updateLocation" name="location"
                               required placeholder="请输入安装位置">
                    </div>
                    <div class="form-group">
                        <label for="updateInstallDate" class="control-label">安装日期 <span class="text-danger">*</span>：</label>
                        <input type="date" class="form-control" id="updateInstallDate" name="installDate" required>
                    </div>
                    <div class="form-group">
                        <label for="updateStatus" class="control-label">设备状态 <span class="text-danger">*</span>：</label>
                        <select class="form-control" id="updateStatus" name="status" required>
                            <option value="正常">正常</option>
                            <option value="维修中">维修中</option>
                            <option value="报废">报废</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="updateMaintainDate" class="control-label">最近维护日期：</label>
                        <input type="date" class="form-control" id="updateMaintainDate" name="lastMaintainDate">
                    </div>
                    <div class="form-group">
                        <label for="updateMaintainer" class="control-label">维护负责人：</label>
                        <input type="text" class="form-control" id="updateMaintainer" name="maintainer"
                               placeholder="请输入维护负责人">
                    </div>
                    <div class="form-group">
                        <label for="updateRemark" class="control-label">备注信息：</label>
                        <textarea class="form-control" id="updateRemark" name="remark" rows="3"
                                  placeholder="请输入备注信息（可选）"></textarea>
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
    // 查看设备详情
    function viewDetail(id) {
        // 实际开发中通过AJAX获取设备详情
        // 这里用模拟数据示例
        $.getJSON("/device?way=get&id=" + id, function(data) {
            if (data) {
                $("#viewCode").text(data.equipmentCode);
                $("#viewName").text(data.name);
                $("#viewType").text(data.type);
                $("#viewLocation").text(data.location);
                $("#viewInstallDate").text(formatDate(data.installDate));

                // 状态样式处理
                var statusHtml = "";
                if (data.status == "正常") {
                    statusHtml = '<span class="status-normal">' + data.status + '</span>';
                } else if (data.status == "维修中") {
                    statusHtml = '<span class="status-repair">' + data.status + '</span>';
                } else {
                    statusHtml = '<span class="status-scrap">' + data.status + '</span>';
                }
                $("#viewStatus").html(statusHtml);

                $("#viewMaintainDate").text(data.lastMaintainDate ? formatDate(data.lastMaintainDate) : "-");
                $("#viewMaintainer").text(data.maintainer || "-");
                $("#viewRemark").text(data.remark || "-");
            }
        });
    }

    //重置搜索表单
    function resetForm(){
        //1、获取表单中的所有输入控件

        document.getElementById("keyword").value="";
        document.getElementById("type").selectedIndex=0;
        document.getElementById("status").selectedIndex=0;
    }

    // 编辑设备（实际开发中实现）
    function editEquipment(id) {
        // 类似查看详情，获取数据后填充表单
        $.getJSON("/device?way=get&id=" + id, function(data) {
            if (data) {
                $("#editId").val(data.id);
                $("#updateCode").val(data.equipmentCode);
                $("#updateName").val(data.name);
                $("#updateType").val(data.type);
                $("#updateLocation").val(data.location);
                $("#updateInstallDate").val(formatDate(data.installDate));

                // 状态样式处理
                // 处理日期格式（假设服务器返回的是时间戳或者标准格式）
                if (data.installDate) {
                    var installDate = new Date(data.installDate);
                    var formattedDate = installDate.toISOString().split('T')[0];
                    $("#updateInstallDate").val(formattedDate);
                }else{
                    $("#updateInstallDate").val("");
                }
                $("#updateStatus").val(data.status);


                if (data.lastMaintainDate) {
                    var maintainDate = new Date(data.lastMaintainDate);
                    var formattedMaintainDate = maintainDate.toISOString().split('T')[0];
                    $("#updateMaintainDate").val(formattedMaintainDate);
                }else{
                    $("#updateMaintainDate").val("");
                }
                $("#updateMaintainer").val(data.maintainer || "-");
                $("#updateRemark").val(data.remark || "-");
            }
        });

    }

    // 删除设备
    function deleteEquipment(id, name) {
        if (confirm("确定要删除设备【" + name + "】吗？此操作不可恢复！")) {
            window.location.href = "/device?way=delete&id=" + id;
        }
    }

    // 日期格式化工具
    function formatDate(dateStr) {
        if (!dateStr) return "";
        var date = new Date(dateStr);
        return date.getFullYear() + "-" +
            (date.getMonth() + 1).toString().padStart(2, "0") + "-" +
            date.getDate().toString().padStart(2, "0");
    }
</script>
</body>
</html>