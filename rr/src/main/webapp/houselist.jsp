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
    <title>智慧社区平台</title>
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
                    <form role="form" class="form-inline" action="/house/search" method="post">
                        <div class="form-group">
                            <button type="button" class="btn btn-default" data-toggle="modal" data-target="#addUserModal">
										<span style="margin-right: 5px" class="" aria-hidden="true">
											<i >房屋编号</i>
                                        </span>
                            </button>
                        </div>
                        <div class="form-group" style="margin-left: 20px">
                            <input type="text" class="form-control" name="selectValue" placeholder="查询条件" maxlength="12" style="width: 130px">
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
											<i class="fa fa-user-plus">添加房屋信息</i>
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
                        <th>房屋编号</th>
                        <th>房屋单元</th>
                        <th>房屋楼号</th>
                        <th>面积</th>
                        <th>状态</th>
                        <th>添加时间</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="house" items="${requestScope.houselist}">
                        <tr>
                            <td>${house.id}</td>
                            <td>${house.housenum}</td>
                            <td>${house.unitnum}</td>
                            <td>${house.buildnum}</td>
                            <td>${house.area}</td>
                            <td>${house.status=="0"?"入住":"未住"}</td>
                            <td><fmt:formatDate value="${house.addtime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                            <td>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default "
                                            data-id="${house.id}"
                                            data-housenum="${house.housenum}"
                                            data-unitnum="${house.unitnum}"
                                            data-buildnum="${house.buildnum}"
                                            data-area="${house.area}"
                                            data-status="${house.status}"
                                            data-toggle="modal"
                                            data-target="#updateUserModal">
                                        <i class="fa fa-user-o">修改</i>
                                    </button>

                                    <button type="button" class="btn btn-danger "
                                            data-id="${house.id}"
                                            data-toggle="modal"
                                            onclick=""
                                            data-target="#delUserModal">
                                        <i class="fa fa-user-times">删除</i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
                <!-- add框示例（Modal） -->
                <form method="post" action="/car/add" class="form-horizontal" style="margin-top: 0px" role="form"
                     style="margin: 20px;">
                    <div class="modal fade" id="addUserModal" tabindex="-1"
                         role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal"
                                            aria-hidden="true">x</button>
                                    <h4 class="modal-title">添加房屋信息</h4>
                                </div>
                                <div class="modal-body">
                                    <form class="form-horizontal" role="form">

                                        <div class="form-group">
                                            <label for="housenum" class="col-sm-3 control-label">房屋编号</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control"
                                                       name="housenum" value="" placeholder="请输入房屋编号">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="buildnum" class="col-sm-3 control-label">房屋楼号</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control"
                                                       name="buildnum" value="" placeholder="请输入房屋楼号">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="unitnum" class="col-sm-3 control-label">单元</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control"
                                                       name="unitnum" value="" placeholder="请输入房屋单元">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="area" class="col-sm-3 control-label">面积</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control"
                                                       name="area" value="" placeholder="请输入房屋面积">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="" class="col-sm-3 control-label">入住状态</label>
                                            <div class="col-sm-9">
                                                <input type="radio" checked value="0" class="instatus" name="instatus"> 入住
                                                &nbsp;&nbsp;&nbsp;<input type="radio" value="1" class="instatus" name="instatus"> 未住
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

                <!-- update框示例（Modal） -->
                <form method="post" action="/house/update" class="form-horizontal" style="margin-top: 0px" role="form"
                      id="" style="margin: 20px;">
                    <div class="modal fade" id="updateUserModal" tabindex="-1"
                         role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal"
                                            aria-hidden="true">x</button>
                                    <h4 class="modal-title" >房屋信息</h4>
                                </div>
                                <div class="modal-body">
                                    <form class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <label for="" class="col-sm-3 control-label">ID</label>
                                            <div class="col-sm-9">
                                                <input type="text" readonly required class="form-control" id="id"
                                                       name="id">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="" class="col-sm-3 control-label">房屋编号</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="housenum"
                                                       name="housenum" placeholder="请输入房屋编号">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="" class="col-sm-3 control-label">房屋楼号</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="buildnum"
                                                       name="buildnum" value="" placeholder="请输入房屋楼号">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="" class="col-sm-3 control-label">房屋单元</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="unitnum"
                                                       name="unitnum" value="" placeholder="请输入房屋单元">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="" class="col-sm-3 control-label">面积</label>
                                            <div class="col-sm-9">
                                                <input type="text" required class="form-control" id="area"
                                                       name="area" value="" placeholder="请输入房屋面积">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="" class="col-sm-3 control-label">状态</label>
                                            <div class="col-sm-9">
                                                <input type="radio" checked value="0" class="instatus" name="instatus"> 入住
                                                &nbsp;<input type="radio" value="1" class="instatus" name="instatus"> 未住
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

                <!-- 删除模态框示例（Modal） -->
                <form method="post" action="/house/delete"
                      class="form-horizontal" style="margin-top: 0px" role="form"
                      id="" style="margin: 20px;">
                    <div class="modal fade" id="delUserModal" tabindex="-1"
                         role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal"
                                            aria-hidden="true">×</button>
                                    <h4 class="modal-title" id="myModalLabel">房屋信息</h4>
                                </div>
                                <div class="modal-body">
                                    <form class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <div class="col-sm-9">
                                                <h3 class="col-sm-18 control-label" id="deleteLabel">删除信息</h3>
                                                <input type="hidden" class="form-control" id="tab" name="tab" placeholder="" value="dor_admin">
                                                <input type="hidden" class="form-control" id="id" name="id" placeholder="">
                                                <input type="hidden" name="id" id="id"/>
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
        var id = button.data('id');         // 从 data-id 中获取房屋 ID
        var housenum = button.data(''); // 从 data-housenum 中获取门牌号
        var unitnum = button.data('unitnum');   // 从 data-unitnum 中获取单元号
        var buildnum = button.data('buildnum'); // 从 data-buildnum 中获取楼栋号
        var area = button.data('area');         // 从 data-area 中获取面积
        var status = button.data('status');     // 从 data-status 中获取房屋状态

        // 3. 获取当前模态框对象
        var modal = $(this);

        // 4. 向模态框中填充数据
        modal.find('.modal-title').text('修改房屋信息'); // 设置模态框标题
        // 向表单输入框填充默认值（与 input 的 id 对应）
        modal.find('#id').val(id);           // 填充 ID（通常是隐藏域，用于后端识别要修改的记录）
        modal.find('#housenum').val(housenum); // 填充门牌号
        modal.find('#unitnum').val(unitnum);   // 填充单元号
        modal.find('#buildnum').val(buildnum); // 填充楼栋号
        modal.find('#area').val(area);         // 填充面积

        // 5. 特殊处理：单选框（房屋状态）的默认选中
        var list = modal.find('.instatus'); // 获取所有 class 为 instatus 的单选框
        for(var i=0; i<list.length; i++){
            // 如果单选框的值等于当前房屋状态，就选中它
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
        modal.find('.modal-title').text('删除宿管信息'); // 设置标题
        // 显示确认提示（包含要删除的 ID）
        modal.find('#deleteLabel').text('是否删除ID为  ' + id + ' 的信息');
        // 将 ID 存入模态框中的隐藏输入框（提交删除请求时后端需要该 ID）
        modal.find('#id').val(id);
    });
</script>

</body>
</html>
