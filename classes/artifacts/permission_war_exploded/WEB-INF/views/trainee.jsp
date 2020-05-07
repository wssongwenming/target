<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>训练准备</title>
    <jsp:include page="/common/backend_common.jsp"/>
    <jsp:include page="/common/page.jsp"/>
    <style>
        .modal.fade.in {
            z-index: 9999 !important;
        }
    </style>
</head>
<body class="no-skin" youdao="bind" style="background: white">
<input id="gritter-light" checked="" type="checkbox" class="ace ace-switch ace-switch-5"/>

<div class="page-header">
    <h1>
        参训人员数据维护
        <small>
            <i class="ace-icon fa fa-angle-double-right"></i>
            维护训练计划-参训人员关系
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
                参训人员列表&nbsp;&nbsp;
                <a class="green" href="#">
                    <i class="ace-icon fa fa-plus-circle orange bigger-130 trainee-add"></i>
                </a>
                <a class="black" href="#">
                     <i class="ace-icon fa fa-angle-double-right black bigger-130"></i>
                </a>
                参训人员数据(被导入excel字段应为：姓名、部职别、手机号、备注)&nbsp;&nbsp;
                <a class="green" href="#">
                    <i class="ace-icon fa fa-file-excel-o orange bigger-120 trainee-import"></i>
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
<%--                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                密码
                            </th>--%>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                备注
                            </th>
                            <th class="sorting_disabled" rowspan="1" colspan="1" aria-label=""></th>
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

<div id="dialog-trainee-form" style="display: none;">
    <form id="traineeForm">
        <table class="table table-striped table-bordered table-hover dataTable no-footer" role="grid">
            <tr>
                <td style="width: 120px;"><label for="trainingSelectId">所在训练计划</label></td>
                <td>
                    <select id="trainingSelectId" name="trainingId" data-placeholder="选择训练计划" style="width: 170px;"></select>
                </td>
            </tr>
            <tr>
                <td><label for="traineeName">姓名</label></td>
                <input type="hidden" name="id" id="traineeId"/>
                <td><input type="text" name="name" id="traineeName" value="" class="text ui-widget-content ui-corner-all"></td>
            </tr>
            <tr>
                <td><label for="traineeWorkUnit">部职别</label></td>
                <td><input type="text" name="workunit" id="traineeWorkUnit" value="" class="text ui-widget-content ui-corner-all"></td>
            </tr>
            <tr>
                <td><label for="traineePhone">手机号码</label></td>
                <td><input type="text" name="phone" id="traineePhone" value="" class="text ui-widget-content ui-corner-all"></td>
            </tr>
            <tr>
                <td><label for="traineeStatus">状态</label></td>
                <td>
                    <select id="traineeStatus" name="status" data-placeholder="选择状态" style="width: 170px;">
                        <option value="0">等候中</option>
                        <option value="1">正常登陆</option>
                        <option value="2">未登陆</option>
                        <option value="3">打靶中</option>
                        <option value="4">打靶完毕</option>
                        <option value="5">缺席</option>
                       <%-- 0等候中，1正常登陆，2未登陆，3打靶中，4打靶完毕，5缺席--%>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="traineePassword">密码</label></td>
                <td><input type="text" name="password" id="traineePassword" value="" class="text ui-widget-content ui-corner-all"></td>
            </tr>

            <tr>
                <td><label >照片</label></td>
                <td align="left"> <img style="width:70px;height:70px" id="imgEmdImg" class="img-circle">
                    <input type="text" name="photo" id="traineePhoto" value="" style="display:none">
                    <button type="button" id="btnImg" class="btn btn-default" data-dismiss="modal">修改头像</button>
                </td>
            </tr>
            <tr>
                <td><label for="traineeMemo">备注</label></td>
                <td><textarea name="memo" id="traineeMemo" class="text ui-widget-content ui-corner-all" rows="2" cols="25"></textarea></td>
            </tr>
        </table>
    </form>
</div>

<div class="modal fade in" id="uploadPhoto" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content animated flipInY">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    照片上传
                </h4>
            </div>
            <div class="modal-body">
                <form id="videoForm">
                    <input id="photo_file" name="photo_file" type="file">
                </form>
            </div>
   <%--         <div class="modal-footer">
                <button type="button" class="btn btn-default"
                        data-dismiss="modal">关闭
                </button>
                <button type="button" class="btn btn-primary">
                    提交更改
                </button>
            </div>--%>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!--导入excel数据操作层-->
<div class="modal fade in" id="uploadExcel" tabindex="-1" role="dialog" aria-labelledby="excelModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content animated flipInY">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="excelModalLabel">
                    excel文件上传
                </h4>
            </div>
            <div class="modal-body">
                <form id="excelForm">
                    <input id="excel_file" name="excel_file" type="file">
                </form>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->



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
   <%-- <td>{{password}}</td>--%>
    <td>{{memo}}</td>
    <td>
        <div class="hidden-sm hidden-xs action-buttons">
            <a class="green trainee-edit" href="#" data-id="{{id}}">
                <i class="ace-icon fa fa-pencil bigger-100"></i>
            </a>
            <a class="red trainee-acl" href="#" data-id="{{id}}">
                <i class="ace-icon fa fa-flag bigger-100"></i>
            </a>
            <a class="red trainee-delete" href="#" data-id="{{id}}" data-name="{{name}}">
                <i class="ace-icon fa fa-trash-o bigger-100"></i>
            </a>
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
            var url = "/sys/trainee/pageByTrainingId.json?trainingId=" + trainingId;
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
                            return this.status == 0 ? '等候中' : (this.status == 2 ? '打靶中' : (this.status == 3 ? '打靶完毕' : (this.status == 1 ? '正常登陆' : "缺席")));
                        },
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

        $(".trainee-add").click(function() {
            $("#dialog-trainee-form").dialog({
                modal: true,
                minWidth: 450,
                title: "新增参训人员",
                open: function(event, ui) {
                    $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                    optionTrainingStr="";
                    recursiveRenderTrainingSelect(trainingList);
                    $("#traineeForm")[0].reset();
                    $("#trainingSelectId").html(optionTrainingStr);
                },
                buttons : {
                    "添加": function(e) {
                        e.preventDefault();
                        updateTrainee(true, function (data) {
                            $("#dialog-trainee-form").dialog("close");
                            loadTraineeListByTrainingId(lastClickTrainingId);
                        }, function (data) {
                            showMessage("新增用户", data.msg, false);
                        })
                    },
                    "取消": function () {
                        $("#dialog-trainee-form").dialog("close");
                    }
                }
            });
        });

        function updateTrainee(isCreate, successCallback, failCallback) {
            $.ajax({
                url: isCreate ? "/sys/trainee/save.json" : "/sys/trainee/update.json",
                data: $("#traineeForm").serializeArray(),
                type: 'POST',
                /*               position: {
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
                               },*/
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


        //初始化用于照片上传的fileinput控件
        var FileInput_Photo = function () {
            var oFile = new Object();
            //初始化fileinput控件（第一次初始化）
            oFile.Init = function (ctrlName, uploadUrl) {
                var control = $('#' + ctrlName);

                //初始化上传控件的样式
                control.fileinput({
                    language: 'zh', //设置语言
                    uploadUrl: uploadUrl, //上传的地址
                    allowedFileExtensions: ['jpg', 'png'],//接收的文件后缀
                    showUpload: true, //是否显示上传按钮
                    showCaption: false,//是否显示标题
                    browseClass: "btn btn-primary", //按钮样式
                    //dropZoneEnabled: false,//是否显示拖拽区域
                    //minImageWidth: 50, //图片的最小宽度
                    //minImageHeight: 50,//图片的最小高度
                    //maxImageWidth: 1000,//图片的最大宽度
                    //maxImageHeight: 1000,//图片的最大高度
                    maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
                    //minFileCount: 0,
                    maxFileCount: 1, //表示允许同时上传的最大文件个数
                    enctype: 'multipart/form-data',
                    validateInitialCount: true,
                    previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
                    msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
                });

                //导入文件上传完成之后的事件
                $("#photo_file").on("fileuploaded", function (event, data, previewId, index) {

                    var data = data.response.data;
                    //showMessage("上传照片失败", data, false);
                    //document.getElementById('videoForm').outerHtml = document.getElementById('videoForm').outerHtml;
                    //document.getElementById("videoForm").reset();
                    $("#traineePhoto").val(data);
                    $("#uploadPhoto").modal('hide');
                    $("#imgEmdImg").attr("src", data);
                });
            }
            return oFile;
        };

        //初始化用于excel上传的fileinput控件
        var FileInput_Excel = function () {
            var oFile = new Object();
            //初始化fileinput控件（第一次初始化）
            oFile.Init = function (ctrlName, uploadUrl) {
                var control = $('#' + ctrlName);

                //初始化上传控件的样式
                control.fileinput({
                    language: 'zh', //设置语言
                    uploadUrl: uploadUrl, //上传的地址
                    allowedFileExtensions: ['xls', 'xlsx'],//接收的文件后缀
                    showUpload: true, //是否显示上传按钮
                    showCaption: false,//是否显示标题
                    browseClass: "btn btn-primary", //按钮样式
                    //dropZoneEnabled: false,//是否显示拖拽区域
                    //minImageWidth: 50, //图片的最小宽度
                    //minImageHeight: 50,//图片的最小高度
                    //maxImageWidth: 1000,//图片的最大宽度
                    //maxImageHeight: 1000,//图片的最大高度
                    maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
                    //minFileCount: 0,
                    maxFileCount: 1, //表示允许同时上传的最大文件个数
                    enctype: 'multipart/form-data',
                    validateInitialCount: true,
                    previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
                    msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
                });

                //导入文件上传完成之后的事件
                $("#excel_file").on("fileuploaded", function (event, data, previewId, index) {
                    var data = data.response.data;
                    //showMessage("上传照片", data, false);
                    $("#uploadExcel").modal('hide');
                    loadTraineeListByTrainingId(lastClickTrainingId);
                });
            }
            return oFile;
        };


        //上传头像
        var oPhotoUpload = new FileInput_Photo();
        oPhotoUpload.Init("photo_file", "/sys/file/upload");

        //上传Excel
        var oExcelUpload = new FileInput_Excel();
        //oExcelUpload.Init("excel_file", "/sys/file/uploadExcel/"+lastClickTrainingId);//lastClickTrainingId会在一开始时就被赋值为-1所以点选后无法改变，所以必须放在新的位置

        //弹出添加图片模态
        $("#btnImg").click(function () {
            $("#uploadPhoto").modal("show");
        });

        //弹出添加excel模态
        $(".trainee-import").click(function () {

            if(lastClickTrainingId==-1){
                showMessage("提示", "您还没有选中训练计划", false);
            }else {
                oExcelUpload.Init("excel_file", "/sys/file/uploadExcel/"+lastClickTrainingId);
                $("#uploadExcel").modal("show");
            }
        });


    })
</script>
</body>
</html>
