<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/11/13
  Time: 20:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>训练准备</title>
    <jsp:include page="/common/backend_common.jsp"/>
    <jsp:include page="/common/page.jsp"/>
</head>
<body class="no-skin" youdao="bind" style="background: white">
<input id="gritter-light" checked="" type="checkbox" class="ace ace-switch ace-switch-5"/>
<div class="page-header">
    <h1>
        训练计划管理
        <small>
            <i class="ace-icon fa fa-angle-double-right"></i>
            维护训练计划数据
        </small>
    </h1>
</div>
<div class="main-content-inner">
        <div class="col-xs-12">
            <div class="table-header">
                训练计划列表&nbsp;&nbsp;
                <a class="green" href="#">
                    <i class="ace-icon fa fa-plus-circle orange bigger-130  training-add"></i>
                </a>
            </div>
            <div>
                <div id="dynamic-table_wrapper" class="dataTables_wrapper form-inline no-footer">
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="dataTables_length align-middle" id="dynamic-table_length" ><label>
                                展示
                                <select id="pageSize" name="dynamic-table_length" aria-controls="dynamic-table" class="form-control input-sm">
                                    <option value="10">10</option>
                                    <option value="25">25</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                </select> 条记录 </label>

                            </div>
                        </div>
                    <table id="dynamic-table" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid"
                           aria-describedby="dynamic-table_info" style="font-size:14px">
                        <thead>
                        <tr role="row">
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                训练计划名称
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                组织单位
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                参训人员数量
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                枪械种类
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                弹药数量
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                靶场名称/地址
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                日期
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                备注
                            </th>
                            <th class="sorting_disabled" rowspan="1" colspan="1" aria-label=""></th>
                        </tr>
                        </thead>
                        <tbody id="trainingList"></tbody>
                    </table>
                    <div class="row" id="trainingPage">
                    </div>
                    </div>
                </div>
             </div>
    </div>
</div>

<div id="dialog-training-form" style="display: none;">
    <form id="trainingForm">
        <table class="table table-striped table-bordered table-hover dataTable no-footer" role="grid">
            <tr>
                <td style="width: 80px;"><label for="training_title">训练计划名称</label></td>
                <input type="hidden" name="id" id="trainingId"/>
                <td style="width: 200px;"><input type="text" name="title" id="training_title" value="" class="text ui-widget-content ui-corner-all"></td>
            </tr>
            <tr>
                <td><label for="training_orgDept">组织单位</label></td>
                <td><input type="text" name="orgDept" id="training_orgDept" value="" class="text ui-widget-content ui-corner-all"></td>
            </tr>
            <tr>
                <td><label for="training_traineeNumber">参训人员数量</label></td>
                <td><input type="text" name="traineeNumber" id="training_traineeNumber" value="" class="text ui-widget-content ui-corner-all"></td>
            </tr>

            <tr>
                <td><label for="training_gun">枪械种类</label></td>
                <td><input type="text" name="gun" id="training_gun" value="" class="text ui-widget-content ui-corner-all"></td>
            </tr>

            <tr>
                <td><label for="training_bulletNumber">弹药数量</label></td>
                <td><input type="text" name="bulletNumber" id="training_bulletNumber" value="" class="text ui-widget-content ui-corner-all"></td>
            </tr>

            <tr>
                <td><label for="training_addr">靶场名称/地址</label></td>
                <td><input type="text" name="addr" id="training_addr" value=""  class="text ui-widget-content ui-corner-all"></td>
            </tr>

            <tr>
                <td><label for="training_dot">日期 </label></td>
                <td><input type="text" name="dot" id="training_dot" placeholder="请选择日期" value=""  class="text ui-widget-content ui-corner-all"></td>

            </tr>
            <tr>
                <td><label for="training_memo">备注</label></td>
                <td><textarea name="memo" id="training_memo" class="text ui-widget-content ui-corner-all" rows="3" cols="25"></textarea></td>
            </tr>
        </table>
    </form>
</div>
<script id="trainingListTemplate" type="x-tmpl-mustache">
{{#trainingList}}
<tr role="row"  data-id="{{id}}"><!--even -->
    <td><a href="#" class="training-edit" data-id="{{id}}">{{title}}</a></td>
    <td>{{orgDept}}</td>
    <td>{{traineeNumber}}</td>
    <td>{{gun}}</td>
    <td>{{bulletNumber}}</td>
    <td>{{addr}}</td>
    <td>{{dot}}</td>
    <td>{{memo}}</td>
    <td>
        <div class="hidden-sm hidden-xs action-buttons">
            <a class="green training-edit" href="#" data-id="{{id}}">
                <i class="ace-icon fa fa-pencil bigger-100"></i>
            </a>
            &nbsp;
            <a class="red training-delete" href="#" data-id="{{id}}" data-name="{{title}}">
                <i class="ace-icon fa fa-trash-o bigger-100"></i>
            </a>
         </div>
    </td>
</tr>
{{/trainingList}}
</script>
<script type="application/javascript">
    $(function() {

        var trainingMap = {}; // 存储map格式的训练计划信息
        var trainingListTemplate = $('#trainingListTemplate').html();
        Mustache.parse(trainingListTemplate);

        loadTrainingList();

        $(".training-add").click(function() {
            $("#dialog-training-form").dialog({
                modal: true,
                minWidth: 450,
                title: "新增训练计划",
                open: function(event, ui) {
                    $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                    $("#trainingForm")[0].reset();
                },
                buttons : {
                    "添加": function(e) {
                        e.preventDefault();
                        updateTraining(true, function (data) {
                            $("#dialog-training-form").dialog("close");
                            loadTrainingList();
                        }, function (data) {
                            showMessage("新增训练计划", data.msg, false);
                        })
                    },
                    "取消": function () {
                        $("#dialog-training-form").dialog("close");
                    }
                }
            });
        });

        function updateTraining(isCreate, successCallback, failCallback) {
            $.ajax({
                url: isCreate ? "/sys/training/save.json" : "/sys/training/update.json",
                data: $("#trainingForm").serializeArray(),
                type: 'POST',
               position: {
                    my: 'center',
                    at: 'center',
                    of: window,
                    collision: 'fit',
                    // ensure that the titlebar is never outside the document
                    using: function(pos) {
                        var topOffset = $(this).css(pos).offset().top;
                        if (topOffset < 0) {
                            $(this).css('top', pos.top - topOffset);
                        }
                    }
                },
                success: function(result) {
                    if (result.ret) {
                        if (successCallback) {
                            successCallback(result);
                        }
                    } else {
                        if (failCallback) {
                            failCallback(result);
                        }
                    }
                }
            })
        }
        function loadTrainingList(){
            var pageSize = $("#pageSize").val();
            var url = "/sys/training/page.json";
            var pageNo = $("#trainingPage .pageNo").val() || 1;
            $.ajax({
                url : url,
                data: {
                    pageSize: pageSize,
                    pageNo: pageNo
                },
                success: function (result) {
                    renderTrainingListAndPage(result, url);
                }
            })
        }

        function renderTrainingListAndPage(result, url) {
            if (result.ret) {
                if (result.data.total > 0){
                    var rendered = Mustache.render(trainingListTemplate, {
                        trainingList: result.data.data,
                    });
                    $("#trainingList").html(rendered);
                    bindTrainingClick();
                    $.each(result.data.data, function(i, training) {
                        trainingMap[training.id] = training;
                    })
                } else {
                    $("#trainingList").html('');
                }
                var pageSize = $("#pageSize").val();
                var pageNo = $("#trainingPage .pageNo").val() || 1;

                renderPage(url, result.data.total, pageNo, pageSize, result.data.total > 0 ? result.data.data.length : 0, "trainingPage", renderTrainingListAndPage);
            } else {
                showMessage("获取部门下用户列表", result.msg, false);
            }
        }

    function bindTrainingClick() {

        $(".training-edit").click(function(e) {
            e.preventDefault();
            e.stopPropagation();
            var trainingId = $(this).attr("data-id");
            $("#dialog-training-form").dialog({
                modal: true,
                minWidth: 450,
                title: "编辑训练计划",
                open: function(event, ui) {
                    $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                    $("#trainingForm")[0].reset();
                    var targetTraining = trainingMap[trainingId];
                    if (targetTraining) {
                        $("#trainingId").val(targetTraining.id);
                        $("#training_title").val(targetTraining.title);
                        $("#training_orgDept").val(targetTraining.orgDept);
                        $("#training_traineeNumber").val(targetTraining.traineeNumber);
                        $("#training_bulletNumber").val(targetTraining.bulletNumber);
                        $("#training_gun").val(targetTraining.gun);
                        $("#training_addr").val(targetTraining.addr);
                        $("#training_dot").val(targetTraining.dot);
                        $("#training_memo").val(targetTraining.memo);
                    }
                },
                buttons : {
                    "更新": function(e) {
                        e.preventDefault();
                        updateTraining(false, function (data) {
                            $("#dialog-training-form").dialog("close");
                            loadTrainingList();
                        }, function (data) {
                            showMessage("更新训练计划", data.msg, false);
                        })
                    },
                    "取消": function () {
                        $("#dialog-training-form").dialog("close");
                    }
                }
            });
        });

        $(".training-delete").click(function (e) {
            e.preventDefault();
            e.stopPropagation();
            var trainingId = $(this).attr("data-id");
            var trainingName = $(this).attr("data-name");
            if (confirm("确定要删除训练计划[" + trainingName + "]吗?")) {
                $.ajax({
                    url: "/sys/training/delete.json",
                    data: {
                        id: trainingId
                    },
                    type: 'POST',
                    success: function (result) {
                        if (result.ret) {
                            showMessage("删除训练计划[" + trainingName + "]", "操作成功", true);
                            loadTrainingList();
                        } else {
                            showMessage("删除训练计划[" + trainingName + "]", result.msg, false);
                        }
                    }
                });
            }
        })
    }
    //时间空间Laydate
    lay('#version').html('-v'+ laydate.v);
    //执行一个laydate实例
    laydate.render({
       elem: '#training_dot' //指定元素
    });

    })
</script>
</body>
</html>
