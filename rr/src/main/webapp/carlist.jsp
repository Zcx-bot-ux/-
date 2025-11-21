<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <!-- 引入 Bootstrap -->
    <script src="http://apps.bdimg.com/libs/jquery/1.11.1/jquery.min.js"></script>
    <link href="http://apps.bdimg.com/libs/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet">
    <!-- 引入 font-awesome -->
    <link href="https://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <script src="http://apps.bdimg.com/libs/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <title>智慧社区平台 - 车位管理</title> <!-- 此处修改：页面标题添加“车位管理” -->
</head>
<body>
<%--整体布局设置--%>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-10">
            <!-- 顶部搜索部分 -->
            <div class="panel panel-default">
                <div class="panel-heading">搜索</div>
                <div class="panel-body">
                    <form role="form" class="form-inline" action="/car?way=search" method="post"> <!-- 此处修改：搜索接口改为车位相关 -->
                        <div class="form-group">
                            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#addUserModal">
										<span style="margin-right: 5px" class="" aria-hidden="true">
											<i >车位编号</i> <!-- 此处修改：按钮文本从“房屋编号”改为“车位编号” -->
                                        </span>
                            </button>
                        </div>
                        <div class="form-group" style="margin-left: 20px">
                            <input type="text" class="form-control" name="selectValue" placeholder="查询条件（如车位编号）" maxlength="12" style="width: 130px"> <!-- 此处修改：占位符提示改为车位相关 -->
                        </div>
                        <div class="form-group " style="margin-left: 20px">
                            <button type="submit" class="btn btn-info ">
										<span style="margin-right: 5px"
                                              class="glyphicon glyphicon-search" aria-hidden="true">
										</span>开始搜索
                            </button>
                        </div>
                        <div class="form-group " style="margin-left: 48px">
                            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#addUserModal">
										<span style="margin-right: 5px" class="" aria-hidden="true">
											<i class="fa fa-plus-circle">添加车位信息</i> <!-- 此处修改：按钮文本从“添加房屋信息”改为“添加车位信息” -->
                                        </span>
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- 列表展示-->
            <div class="table-responsive">
                <table class="table table-hover ">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>车位编号</th> <!-- 此处修改：列标题从“房屋编号”改为“车位编号” -->
                        <th>所属区域</th> <!-- 此处修改：列标题从“房屋单元”改为“所属区域” -->
                        <th>车位位置</th> <!-- 此处修改：列标题从“房屋楼号”改为“车位位置” -->
                        <th>车位大小(㎡)</th> <!-- 此处修改：列标题从“面积”改为“车位大小(㎡)” -->
                        <th>状态</th>
                        <th>添加时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="car" items="${requestScope.carlist}"> <!-- 此处修改：循环变量从house改为car，集合从houselist改为carlist -->
                        <tr>
                            <td>${car.id}</td>
                            <td>${car.carnum}</td> <!-- 此处修改：字段从housenum改为carnum（车位编号） -->
                            <td>${car.area}</td> <!-- 此处修改：字段从unitnum改为area（所属区域） -->
                            <td>${car.location}</td> <!-- 此处修改：字段从buildnum改为location（车位位置） -->
                            <td>${car.size}</td> <!-- 此处修改：字段从area改为size（车位大小） -->
                            <td>${car.status=="0"?"已出售":"未出售"}</td> <!-- 此处修改：状态从“入住/未住”改为“已出售/未出售” -->
                            <td><fmt:formatDate value="${car.addtime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                            <td>
                                <!-- 此处修改：数据属性从housenum改为carnum -->
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default "
                                            data-id="${car.id}"
                                            data-carnum="${car.carnum}"
                                    data-area="${car.area}"
                                    data-location="${car.location}"
                                    data-size="${car.size}"
                                    data-status="${car.status}"
                                    data-toggle="modal"
                                    data-target="#updateUserModal">
                                    <i class="fa fa-pencil">修改</i> <!-- 此处修改：图标微调（可选） -->
                                    </button>

                                    <button type="button" class="btn btn-danger "
                                            data-id="${car.id}"
                                            data-toggle="modal"
                                            data-target="#delUserModal">
                                        <i class="fa fa-trash">删除</i> <!-- 此处修改：图标微调（可选） -->
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>

                <!-- 添加车位模态框 -->
                <form method="post" action="/car?way=add" class="form-horizontal" style="margin-top: 0px" role="form" style="margin: 20px;"> <!-- 此处修改：提交地址改为车位添加接口 -->
                    <div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                                    <h4 class="modal-title">添加车位信息</h4> <!-- 此处修改：模态框标题改为“添加车位信息” -->
                                </div>
                                <div class="modal-body">
                                    <form class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <label for="carnum" class="col-sm-3 control-label">车位编号</label> <!-- 此处修改：标签从“房屋编号”改为“车位编号” -->
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control"
                                                       name="carnum" placeholder="请输入车位编号"> <!-- 此处修改：name属性从housenum改为carnum -->
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="location" class="col-sm-3 control-label">车位位置</label> <!-- 此处修改：标签从“房屋楼号”改为“车位位置” -->
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control"
                                                       name="location" placeholder="请输入车位位置（如1号楼地下）"> <!-- 此处修改：name属性从buildnum改为location -->
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="area" class="col-sm-3 control-label">所属区域</label> <!-- 此处修改：标签从“单元”改为“所属区域” -->
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control"
                                                       name="area" placeholder="请输入所属区域（如A区）"> <!-- 此处修改：name属性从unitnum改为area -->
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="size" class="col-sm-3 control-label">车位大小(㎡)</label> <!-- 此处修改：标签从“面积”改为“车位大小(㎡)” -->
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control"
                                                       name="size" placeholder="请输入车位大小"> <!-- 此处修改：name属性从area改为size -->
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="" class="col-sm-3 control-label">车位状态</label> <!-- 此处修改：标签从“入住状态”改为“车位状态” -->
                                            <div class="col-sm-9">
                                                <input type="radio" checked value="0" class="instatus" name="instatus"> 已出售 <!-- 此处修改：状态从“入住”改为“已出售” -->
                                                &nbsp;&nbsp;&nbsp;<input type="radio" value="1" class="instatus" name="instatus"> 未出售 <!-- 此处修改：状态从“未住”改为“未出售” -->
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <button type="submit" class="btn btn-primary">提交</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>

                <!-- 修改车位模态框 -->
                <form method="post" action="/car?way=update" class="form-horizontal" style="margin-top: 0px" role="form" id="" style="margin: 20px;"> <!-- 此处修改：提交地址改为车位/update -->
                    <div class="modal fade" id="updateUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
                                    <h4 class="modal-title">修改车位信息</h4> <!-- 此处修改：模态框标题改为“修改车位信息” -->
                                </div>
                                <div class="modal-body">
                                    <form class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <label for="id" class="col-sm-3 control-label">ID</label>
                                            <div class="col-sm-9">
                                                <input type="text" readonly required class="form-control" id="id" name="id">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="carnum" class="col-sm-3 control-label">车位编号</label> <!-- 此处修改：标签从“房屋编号”改为“车位编号” -->
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="carnum" name="carnum" placeholder="请输入车位编号"> <!-- 此处修改：name属性从housenum改为carnum -->
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="location" class="col-sm-3 control-label">车位位置</label> <!-- 此处修改：标签从“房屋楼号”改为“车位位置” -->
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="location" name="location" placeholder="请输入车位位置"> <!-- 此处修改：name属性从buildnum改为location -->
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="area" class="col-sm-3 control-label">所属区域</label> <!-- 此处修改：标签从“房屋单元”改为“所属区域” -->
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="area" name="area" placeholder="请输入所属区域"> <!-- 此处修改：name属性从unitnum改为area -->
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="size" class="col-sm-3 control-label">车位大小(㎡)</label> <!-- 此处修改：标签从“面积”改为“车位大小(㎡)” -->
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="size" name="size" placeholder="请输入车位大小"> <!-- 此处修改：name属性从area改为size -->
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="" class="col-sm-3 control-label">状态</label>
                                            <div class="col-sm-9">
                                                <input type="radio" checked value="0" class="instatus" name="instatus"> 已出售 <!-- 此处修改：状态从“入住”改为“已出售” -->
                                                &nbsp;<input type="radio" value="1" class="instatus" name="instatus"> 未出售 <!-- 此处修改：状态从“未住”改为“未出售” -->
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <button type="submit" class="btn btn-primary">提交</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>

                <!-- 删除车位模态框 -->
                <form method="post" action="/car?way=delete" class="form-horizontal" style="margin-top: 0px" role="form" id="" style="margin: 20px;"> <!-- 此处修改：提交地址改为car/delete -->
                    <div class="modal fade" id="delUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                    <h4 class="modal-title" id="myModalLabel">删除车位信息</h4> <!-- 此处修改：模态框标题改为“删除车位信息” -->
                                </div>
                                <div class="modal-body">
                                    <form class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <div class="col-sm-9">
                                                <h3 class="col-sm-18 control-label" id="deleteLabel">删除信息</h3>
                                                <input type="hidden" class="form-control" id="id" name="id" placeholder="">
                                                <!-- 此处删除冗余的tab输入框（房屋管理特有，车位管理不需要） -->
                                            </div>
                                        </div>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                                    <button type="submit" class="btn btn-danger">删除</button>
                                    <span id="tip"> </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    <%--    show.bs.modal  特定事件类型  模态框显示   'hide.bs.modal'：模态框隐藏--%>
    // 监听 id 为 updateUserModal 的模态框的 show.bs.modal 事件（显示前触发）
    $('#updateUserModal').on('show.bs.modal', function(event) {
        // 1. 获取触发模态框的按钮（即点击的“修改”按钮）
        var button = $(event.relatedTarget);

        // 2. 从按钮的 data-* 属性中提取数据（这些数据是在 HTML 中预先绑定的）
        var id = button.data('id');
        var carnum = button.data('carnum'); // 此处修改：从data-housenum改为data-carnum
        var area = button.data('area');     // 此处修改：从data-unitnum改为data-area
        var location = button.data('location'); // 此处修改：从data-buildnum改为data-location
        var size = button.data('size');     // 此处修改：从data-area改为data-size
        var status = button.data('status');

        // 3. 获取当前模态框对象
        var modal = $(this);

        // 4. 向模态框中填充数据
        modal.find('.modal-title').text('修改车位信息'); // 此处修改：标题改为“修改车位信息”
        // 向表单输入框填充默认值（与 input 的 id 对应）
        modal.find('#id').val(id);
        modal.find('#carnum').val(carnum);   // 此处修改：从housenum改为carnum
        modal.find('#area').val(area);       // 此处修改：从unitnum改为area
        modal.find('#location').val(location); // 此处修改：从buildnum改为location
        modal.find('#size').val(size);       // 此处修改：从area改为size

        // 5. 特殊处理：单选框（车位状态）的默认选中
        var list = modal.find('.instatus');
        for(var i=0; i<list.length; i++){
            if(status == $(list.get(i)).val()){
                $(list.get(i)).prop('checked', true);
            }
        }
    });

    // 监听 id 为 delUserModal 的模态框的 show.bs.modal 事件
    $('#delUserModal').on('show.bs.modal', function(event) {
        // 1. 获取触发模态框的按钮（即点击的“删除”按钮）
        var button = $(event.relatedTarget);

        // 2. 从按钮的 data-id 属性中提取要删除的 ID
        var id = button.data('id');

        // 3. 获取当前模态框对象
        var modal = $(this);

        // 4. 向模态框填充数据
        modal.find('.modal-title').text('删除车位信息'); // 此处修改：标题改为“删除车位信息”
        // 显示确认提示（包含要删除的 ID）
        modal.find('#deleteLabel').text('是否删除ID为  ' + id + ' 的车位信息'); // 此处修改：提示文本改为“车位信息”
        // 将 ID 存入模态框中的隐藏输入框
        modal.find('#id').val(id);
    });
</script>

</body>
</html>