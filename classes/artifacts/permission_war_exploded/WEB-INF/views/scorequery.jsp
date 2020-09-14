<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>训考总结</title>
    <jsp:include page="/common/backend_common.jsp"/>
    <jsp:include page="/common/page.jsp"/>
</head>
<body class="no-skin" youdao="bind" style="background: white">
<input id="gritter-light" checked="" type="checkbox" class="ace ace-switch ace-switch-5"/>

<div class="page-header">
    <h1>
        训练(考核)成绩统计查询
        <small>
            <i class="ace-icon fa fa-angle-double-right"></i>
            查询打靶人员成绩
        </small>
    </h1>
</div>
<div class="main-content-inner">

    <div class="col-sm-3">
        <div class="table-header">
            训练计划列表&nbsp;&nbsp;
        </div>
        <div id="dynamic-table_wrapper_training" class="dataTables_wrapper form-inline no-footer">
            <div class="row">
                <div class="dataTables_length align-middle" id="dynamic-table_length_training"><label>
                    每页
                    <select id="pageSize_training" name="dynamic-table_length_training" aria-controls="dynamic-table" class="form-control input-sm">
                        <option value="10">10</option>
                        <option value="25">25</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                    </select>条记录</label>
                </div>
                <table id="dynamic-table_training" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid"
                       aria-describedby="dynamic-table_info" style="font-size:14px">
                    <thead>
                    <tr role="row">
                        <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                            训练计划名称
                        </th>
                    </tr>
                    </thead>
                    <tbody id="trainingList"></tbody>
                </table>
                <div class="row" id="trainingPage">
                </div>
            </div>
        </div>
    </div>

    <div class="col-sm-9">
        <div class="col-xs-12">
            <div class="table-header">
                　打靶人员成绩列表
                 <a class="black" href="#">
                    <i class="ace-icon fa fa-angle-double-right black bigger-130"></i>
                </a>

            </div>
            <div>
                <div id="dynamic-table_wrapper" class="dataTables_wrapper form-inline no-footer">
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="dataTables_length" id="dynamic-table_length"><label>
                                每页
                                <select id="pageSize_trainee" name="dynamic-table_length" aria-controls="dynamic-table" class="form-control input-sm">
                                    <option value="10">10</option>
                                    <option value="25">25</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                </select> 条记录 </label>
                            </div>
                        </div>
                    </div>
                    <table id="dynamic-table" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid"
                           aria-describedby="dynamic-table_info" style="font-size:14px">
                        <thead>
                        <tr role="row">
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                人员编码
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                姓名
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                部职别
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                手机号码
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                参训人员状态
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                成绩环数
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                射击次数
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                总评
                            </th>

                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                 备注
                            </th>
                            <th class="sorting_disabled" rowspan="1" colspan="1" aria-label=""><span id="selectAll">全选</span></th>
                        </tr>
                        </thead>
                        <tbody id="traineeList"></tbody>
                    </table>
                    <div class="row" id="traineePage">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>




<script id="trainingListTemplate" type="x-tmpl-mustache">
<ol class="dd-list">
    {{#trainingList}}
         <li class="dd-item dd2-item training-name" id="training_{{id}}" href="javascript:void(0)" data-id="{{id}}">
              <div class="dd2-content" style="cursor:pointer;">{{title}}</div>
         </li>
    {{/trainingList}}
</ol>
</script>

<script id="traineeListTemplate" type="x-tmpl-mustache">
{{#traineeList}}
<tr role="row" class="trainee-name odd" data-id="{{id}}"><!--even -->
    <td>{{id}}</td>
    <td><a href="#" class="trainee-edit" data-id="{{id}}">{{name}}</a></td>
    <td>{{workunit}}</td>
    <td>{{phone}}</td>
    <td>{{showStatus}}</td>
    <td>{{ringNumbers}}</td>
    <td>{{bulletCout}}</td>
    <td>{{showGrade}}</td>
    <td>{{memo}}</td>
    <td>
        <div class="hidden-sm hidden-xs action-buttons">
            <input type="checkbox" name="c1" value="{{id}}" />
        </div>
    </td>
</tr>
{{/traineeList}}
</script>

<script type="application/javascript">
    $(function() {

        var trainingList//训练计划部门列表
        var traineeMap = {}; // 存储map格式的用户信息
        var optionTrainingStr="";
        var lastClickTrainingId=-1;

        var trainingMap = {}; // 存储map格式的训练计划信息
        var trainingListTemplate = $('#trainingListTemplate').html();
        Mustache.parse(trainingListTemplate);

        var traineeListTemplate = $('#traineeListTemplate').html();
        Mustache.parse(traineeListTemplate);


        loadTrainingList();

        function loadTrainingList(){
            var pageSize = $("#pageSize_training").val();
            var url = "/sys/training/page.json";
            var pageNo = $("#trainingPage .pageNo").val() || 1;
            $.ajax({
                url : url,
                data: {
                    pageSize: pageSize,
                    pageNo: pageNo
                },
                success: function (result) {
                    if(result.ret) {
                        trainingList = result.data.data;
                        renderTrainingListAndPage(result, url)
                    }else{
                        showMessage("加载训练计划列表", result.msg, false);
                    }
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
                var pageSize = $("#pageSize_training").val();
                var pageNo = $("#trainingPage .pageNo").val() || 1;
                renderSimplePage(url, result.data.total, pageNo, pageSize, result.data.total > 0 ? result.data.data.length : 0, "trainingPage", renderTrainingListAndPage);
            } else {
                showMessage("获取部门下用户列表1", result.msg, false);
            }
        }

        function bindTrainingClick(){
            $(".training-name").click(function(e) {
                e.preventDefault();
                e.stopPropagation();
                var trainingId = $(this).attr("data-id");
                handleTrainingSelected(trainingId);
            });
        }

        function handleTrainingSelected(trainingId){
            if (lastClickTrainingId != -1) {
                var lastTraining = $("#training_" + lastClickTrainingId + " .dd2-content:first");
                lastTraining.removeClass("btn-yellow");
                lastTraining.removeClass("no-hover");
            }

            var currentTraining = $("#training_" + trainingId + " .dd2-content:first");
            currentTraining.addClass("btn-yellow");
            currentTraining.addClass("no-hover");
            lastClickTrainingId = trainingId;
            $("#trainingId_for_uploaded_excel").val(lastClickTrainingId);
            loadTraineeListByTrainingId(trainingId);
        }

        function loadTraineeListByTrainingId(trainingId) {
            var pageSize = $("#pageSize").val();
            var url = "/sys/trainee/scoresByTrainingId.json?trainingId=" + trainingId;
            var pageNo = $("#userPage .pageNo").val() || 1;
            $.ajax({
                url : url,
                data: {
                    pageSize: pageSize,
                    pageNo: pageNo
                },
                success: function (result) {
                    renderTraineeListAndPage(result, url);
                }
            })
        }

        function renderTraineeListAndPage(result, url) {

            if (result.ret) {
                if (result.data.total > 0){

                    var rendered = Mustache.render(traineeListTemplate, {
                        traineeList: result.data.data,
                        "showStatus": function() {
                            return this.status == 0 ? '等候中' : (this.status == 1 ? '正常登录' : (this.status == 2 ? '未登陆' : (this.status == 3 ? '打靶中' : (this.status == 4 ? '打靶完毕' : "缺席"))));
                        },
                        "showGrade":function () {
                            return this.status==4 ? (this.average<=5 ? '不及格':(this.average>5&&this.average<=8 ? '良好':(this.average>8 ? '优秀':''))):''
                        }
                    });
                    $("#traineeList").html(rendered);
                    bindTraineeClick();
                    $.each(result.data.data, function(i, trainee) {
                        traineeMap[trainee.id] =trainee;
                    })
                } else {
                    $("#traineeList").html('');
                }
                var pageSize = $("#pageSize_trainee").val();
                var pageNo = $("#traineePage .pageNo").val() || 1;
                renderPage(url, result.data.total, pageNo, pageSize, result.data.total > 0 ? result.data.data.length : 0, "traineePage", renderTraineeListAndPage);
            } else {
                showMessage("获取部门下用户列表", result.msg, false);
            }
        }
        function bindTraineeClick() {
            $(".trainee-acl").click(function (e) {
                e.preventDefault();
                e.stopPropagation();
                var traineeId = $(this).attr("data-id");
                $.ajax({
                    url: "/sys/trainee/acls.json",
                    data: {
                        trianeeId: traineeId
                    },
                    success: function(result) {
                        if (result.ret) {
                            console.log(result)
                        } else {
                            showMessage("获取用户权限数据", result.msg, false);
                        }
                    }
                })
            });
            $(".trainee-edit").click(function(e) {
                e.preventDefault();
                e.stopPropagation();
                var traineeId = $(this).attr("data-id");
                $("#dialog-trainee-form").dialog({
                    modal: true,
                    minWidth: 450,
                    title: "编辑参训人员",
                    open: function(event, ui) {
                        $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                        optionStr = "";

                        recursiveRenderTrainingSelect(trainingList);;
                        $("#traineeForm")[0].reset();
                        $("#trainingSelectId").html(optionTrainingStr);

                        var targetTrainee = traineeMap[traineeId];
                        if (targetTrainee) {
                            $("#trainingSelectId").val(targetTrainee.trainingId);
                            $("#traineeId").val(targetTrainee.id);
                            $("#traineeName").val(targetTrainee.name);
                            $("#traineeWorkUnit").val(targetTrainee.workunit);
                            $("#traineePhone").val(targetTrainee.phone);
                            $("#traineeStatus").val(targetTrainee.status);
                            $("#traineePassword").val(targetTrainee.password);
                            $("#traineePhoto").val(targetTrainee.photo);
                            $("#imgEmdImg").attr("src", targetTrainee.photo);
                            $("#traineeMemo").val(targetTrainee.memo);
                        }
                    },
                    buttons : {
                        "更新": function(e) {
                            e.preventDefault();
                            updateTrainee(false, function (data) {
                                $("#dialog-trainee-form").dialog("close");
                                loadTraineeListByTrainingId(lastClickTrainingId);
                            }, function (data) {
                                showMessage("更新参训人员失败", data.msg, false);
                            })
                        },
                        "取消": function () {
                            $("#dialog-trainee-form").dialog("close");
                        }
                    }
                });
            });
            $(".trainee-delete").click(function(e) {
                e.preventDefault();
                e.stopPropagation();
                var traineeId = $(this).attr("data-id");
                var traineeName = $(this).attr("data-name");
                if (confirm("确定要删除参训人员[" + traineeName + "]吗?")) {
                    $.ajax({
                        url: "/sys/trainee/delete.json",
                        data: {
                            id: traineeId
                        },
                        success: function (result) {
                            if (result.ret) {
                                showMessage("删除参训人员[" + traineeName + "]", "操作成功", true);
                                loadTraineeListByTrainingId(lastClickTrainingId);
                            } else {
                                showMessage("删除参训人员[" + traineeName + "]", result.msg, false);
                            }
                        }
                    });
                }
            });
        }

        function  recursiveRenderTrainingSelect(trainingList){
            if (trainingList && trainingList.length > 0) {
                $(trainingList).each(function (i, training) {
                    trainingMap[training.id] = training;
                    optionTrainingStr += Mustache.render("<option value='{{id}}'>{{title}}</option>", {id: training.id, title:training.title});

                });
            }
        }

        $("#selectAll").click(function(e) {
            $("input[type=checkbox]").prop("checked","checked");
        })


    })
</script>
</body>
</html>
