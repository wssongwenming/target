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
        靶位编组
        <small>
            <i class="ace-icon fa fa-angle-double-right"></i>
            将已有设备编组生成靶位
        </small>
    </h1>
</div>
<div class="main-content-inner">
    <div class="col-xs-12">
        <div class="table-header">
            靶位列表&nbsp;&nbsp;
            <a class="green" href="#">
                <i class="ace-icon fa fa-plus-circle orange bigger-130  device-group-add"></i>
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
                                靶位编号
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                靶机设备编号
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                照靶终端编号
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                显靶终端编号
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                靶位状态
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                备注
                            </th>
                            <th class="sorting_disabled" rowspan="1" colspan="1" aria-label=""></th>
                        </tr>
                        </thead>
                        <tbody id="deviceGroupList"></tbody>
                    </table>
                    <div class="row" id="deviceGroupPage">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="dialog-device-group-form" style="display: none;">
    <form id="deviceGroupForm">
        <table class="table table-striped table-bordered table-hover dataTable no-footer" role="grid">
            <tr>
                <td style="width: 80px;"><label for="device_group_index">靶位编号</label></td>
                <input type="hidden" name="id" id="device_group_id"/>
                <td>
                    <select id="device_group_index" name="group_index" data-placeholder="选择靶位编号" style="width: 170px;"></select>
                </td>
            </tr>
            <tr>
                <td><label for="device_group_target_id">靶机设备</label></td>
                <td>
                    <select id="device_group_target_id" name="target_id" data-placeholder="选择靶机编号" style="width: 170px;"></select>
                </td>
            </tr>
            <tr>
                <td><label for="device_group_camera_id">照靶终端</label></td>
                <td>
                    <select id="device_group_camera_id" name="camera_id" data-placeholder="选择照靶终端编号" style="width: 170px;"></select>
                </td>
            </tr>
            <tr>
                <td><label for="device_group_display_id">显靶终端</label></td>
                <td>
                    <select id="device_group_display_id" name="display_id" data-placeholder="选择照靶终端编号" style="width: 170px;"></select>
                </td>
            </tr>
            <tr>
                <td><label for="device_group_status">靶位状态</label></td>
                <td>
                    <select id="device_group_status" name="status" data-placeholder="选择照靶终端编号" style="width: 170px;">
                        <option value="000">000</option>
                        <option value="001">001</option>
                        <option value="011">011</option>
                        <option value="010">010</option>
                        <option value="111">111</option>
                        <option value="100">100</option>
                        <option value="110">110</option>
                        <option value="101">101</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="device_group_memo">备注</label></td>
                <td><textarea name="memo" id="device_group_memo" class="text ui-widget-content ui-corner-all" rows="3" cols="25"></textarea></td>
            </tr>
        </table>
    </form>
</div>
<script id="deviceGroupListTemplate" type="x-tmpl-mustache">
{{#deviceGroupList}}
<tr role="row"  data-id="{{id}}"><!--even -->
    <td><a href="#" class="device-group-edit"  data-id="{{id}}">{{groupIndex}}</a></td>
    <td>{{targetId}}</td>
    <td>{{cameraId}}</td>
    <td>{{displayId}}</td>
    <td>{{status}}</td>
    <td>{{memo}}</td>
    <td>
        <div class="hidden-sm hidden-xs action-buttons">
            <a class="green device-group-edit" href="#" data-id="{{id}}" group-index="{{groupIndex}}" target-id="{{targetId}}" camera-id="{{cameraId}}" display-id="{{displayId}}" status="{{status}}" memo="{{memo}}">
                <i class="ace-icon fa fa-pencil bigger-100"></i>
            </a>
            &nbsp;
            <a class="red device-group-delete" href="#" data-id="{{id}}" data-name="靶位">
                <i class="ace-icon fa fa-trash-o bigger-100"></i>
            </a>
         </div>
    </td>
</tr>
{{/deviceGroupList}}
</script>
<script type="application/javascript">
    $(function() {
        Array.prototype.remove = function (obj) {
            for (var i = 0; i < this.length; i++) {//遍历数组。
                var temp = this[i];
                if (temp == obj) {//当遍历到传入的下标/元素位置时，进入下面循环。
                    for (var j = i; j < this.length; j++) {//将下标为i之后的元素，往前移动。这样就覆盖了该下标。最后记得数组长度减1.
                        this[j] = this[j + 1];
                    }
                    this.length = this.length - 1;
                }
            }
        }

        var targetMap = {}; // 存储已有靶位信息map格式的靶机信息
        var cameraMap = {};// 存储已有靶位信息map格式的照靶终端信息
        var displayMap= {};// 存储已有靶位信息map格式的显靶终端信息
        var deviceGroupMapForSelect={};//存储了已有的靶位信息
        var deviceGroupMap={};//存储了已有的靶位信息
        var groupIndexOptionStr = "";
        var cameraIndexOptionStr="";
        var displayIndexOptionStr="";
        var targetIndexOptionStr="";


        //var deviceGroupMap = {}; //
        var deviceGroupListTemplate = $('#deviceGroupListTemplate').html();
        Mustache.parse(deviceGroupListTemplate);
        loadDeviceGroupList();

        $(".device-group-add").click(function() {

            //loadGroupIndexArrayForSelect("");

            $("#dialog-device-group-form").dialog({
                modal: true,
                minWidth: 450,
                title: "新增靶位",
                open: function(event, ui) {
                    $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                    $("#deviceGroupForm")[0].reset();
                    groupIndexOptionStr = "";
                    loadGroupIndexArrayForSelect("","","","");//加入靶位信息，目的是取得改组编配的target，camera，和display，为其他下拉列表准备
/*                    targetIndexOptionStr="";
                    loadTargetIndexArrayForSelect("");
                    cameraIndexOptionStr="";
                    loadCameraIndexArrayForSelect("");
                    displayIndexOptionStr="";
                    loadDisplayIndexArrayForSelect("");*/
                },
                buttons : {
                    "添加": function(e) {
                        e.preventDefault();
                        updateDeviceGroup(true, function (data) {
                            $("#dialog-device-group-form").dialog("close");
                            loadDeviceGroupList();
                        }, function (data) {
                            showMessage("新增训练计划", data.msg, false);
                        })
                    },
                    "取消": function () {
                        $("#dialog-device-group-form").dialog("close");
                    }
                }
            });
        });
        function loadGroupIndexArrayForSelect(groupindex,targetid,cameraid,displayid) {//这里加了一个参数，就是为了在编辑时将当前的index带入,加到select的上面，编辑时也neng
            $.ajax({
                url: "/sys/devicegroup/devicegroup.json",
                success : function (result) {
                    var device_group_index_array=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
                    if (result.ret) {
                        var deviceGrouplist= result.data.data;
                        deviceGroupMap={};
                        if(deviceGrouplist!=null){
                            $.each(deviceGrouplist, function(i, devicegroup) {
                                var device_group_index=devicegroup.groupIndex;
                                deviceGroupMap[device_group_index]=devicegroup;
                                device_group_index_array.remove(device_group_index);
                            });

                        }
                        $(device_group_index_array).each(function (i,device_index) {
                            groupIndexOptionStr += Mustache.render("<option value='{{id}}'>{{id}}</option>",{id: device_index});

                        });
                        $("#deviceGroupForm")[0].reset();
                        if(groupindex==null || groupindex=="" || groupindex=='undefined'){
                            $("#device_group_index").html(groupIndexOptionStr);
                        }else {
                            $("#device_group_index").html(Mustache.render("<option value='{{id}}'>{{id}}</option>", {id: groupindex}) + groupIndexOptionStr);
                        }
                        targetIndexOptionStr="";
                        loadTargetIndexArrayForSelect(targetid);
                        cameraIndexOptionStr="";
                        loadCameraIndexArrayForSelect(cameraid);
                        displayIndexOptionStr="";
                        loadDisplayIndexArrayForSelect(displayid);
                    } else {
                        showMessage("提示", result.msg, false);
                    }
                }
            })
        }


        function loadTargetIndexArrayForSelect(optionStr) {//这里加了一个参数，就是为了在编辑时将当前的index带入
            $.ajax({
                url: "/sys/target/target.json",
                success : function (result) {
                    var target_index_array=[];
                    if (result.ret) {
                        var targetlist= result.data.data;
                        if(targetlist!=null) {
                            $.each(targetlist, function(i, target) {
                                var target_index=target.device_index;
                                target_index_array.push(target_index);
                            });
                        }

                        $.map(deviceGroupMap,function(devicegroup,key){
                            target_index_array.remove(devicegroup.targetId);
                        });
                        targetIndexOptionStr="";
                        $(target_index_array).each(function (i,device_index) {
                            targetIndexOptionStr += Mustache.render("<option value='{{id}}'>{{id}}</option>",{id: device_index});
                        });
                        if(optionStr==null || optionStr=="" || optionStr=='undefined'){
                            $("#device_group_target_id").html(targetIndexOptionStr);
                        }else {
                            $("#device_group_target_id").html(Mustache.render("<option value='{{id}}'>{{id}}</option>", {id: optionStr}) + targetIndexOptionStr);
                        }
                    } else {
                        showMessage("提示", result.msg, false);
                    }
                }
            })
        }

        function loadCameraIndexArrayForSelect(optionStr) {//这里加了一个参数，就是为了在编辑时将当前的index带入
            $.ajax({
                url: "/sys/camera/camera.json",
                success : function (result) {
                    var camera_index_array=[];
                    if (result.ret) {
                        var cameralist= result.data.data;
                        if(cameralist!=null) {
                            $.each(cameralist, function(i, camera) {
                                var camera_index=camera.device_index;
                                camera_index_array.push(camera_index);
                            });
                        }
                        $.map(deviceGroupMap,function(devicegroup,key){
                            camera_index_array.remove(devicegroup.cameraId);
                        });
                        cameraIndexOptionStr="";
                        $(camera_index_array).each(function (i,device_index) {
                            cameraIndexOptionStr += Mustache.render("<option value='{{id}}'>{{id}}</option>",{id: device_index});
                        });
                        if(optionStr==null || optionStr=="" || optionStr=='undefined'){
                            $("#device_group_camera_id").html(cameraIndexOptionStr);
                        }else {
                            $("#device_group_camera_id").html(Mustache.render("<option value='{{id}}'>{{id}}</option>", {id: optionStr}) + cameraIndexOptionStr);
                        }
                    } else {
                        showMessage("提示", result.msg, false);
                    }
                }
            })
        }

        function loadDisplayIndexArrayForSelect(optionStr) {//这里加了一个参数，就是为了在编辑时将当前的index带入
            $.ajax({
                url: "/sys/display/display.json",
                success : function (result) {
                    var display_index_array=[];//存储了所有display的编号，然后去除掉已经编入靶位的该类设备编号就是点前展示的可供选择的display编号
                    if (result.ret) {
                        var displaylist= result.data.data;
                        if(displaylist!=null) {
                            $.each(displaylist, function(i, display) {
                                var display_index=display.device_index;
                                display_index_array.push(display_index);
                            });
                        }

                        $.map(deviceGroupMap,function(devicegroup,key){
                            display_index_array.remove(devicegroup.displayId);//去掉已经编组的display
                        });
                        displayIndexOptionStr="";
                        $(display_index_array).each(function (i,device_index) {

                            displayIndexOptionStr += Mustache.render("<option value='{{id}}'>{{id}}</option>",{id: device_index});

                        });
                        if(optionStr==null || optionStr=="" || optionStr=='undefined'){
                            $("#device_group_display_id").html(displayIndexOptionStr);
                        }else {
                            $("#device_group_display_id").html(Mustache.render("<option value='{{id}}'>{{id}}</option>", {id: optionStr}) + displayIndexOptionStr);
                        }
                    } else {
                        showMessage("提示", result.msg, false);
                    }
                }
            })
        }

        function updateDeviceGroup(isCreate, successCallback, failCallback) {
            $.ajax({
                url: isCreate ? "/sys/devicegroup/save.json" : "/sys/devicegroup/update.json",
                data: $("#deviceGroupForm").serializeArray(),
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
        function loadDeviceGroupList(){
            var pageSize = $("#pageSize").val();
            var url = "/sys/devicegroup/page.json";
            var pageNo = $("#deviceGroupPage .pageNo").val() || 1;
            $.ajax({
                url : url,
                data: {
                    pageSize: pageSize,
                    pageNo: pageNo
                },
                success: function (result) {
                    renderDeviceGroupListAndPage(result, url);
                }
            })
        }

        function renderDeviceGroupListAndPage(result, url) {
            if (result.ret) {
                if (result.data.total > 0){
                    var rendered = Mustache.render(deviceGroupListTemplate, {
                        deviceGroupList: result.data.data,
                    });
                    $("#deviceGroupList").html(rendered);
                    bindDeviceGroupClick();
/*                   deviceGroupMap={};
                    $.each(result.data.data, function(i, deviceGroup) {
                        deviceGroupMap[deviceGroup.id] = deviceGroup;
                    })*/

                } else {
                    $("#deviceGroupList").html('');
                }
                var pageSize = $("#pageSize").val();
                var pageNo = $("#deviceGroupPage .pageNo").val() || 1;
                renderPage(url, result.data.total, pageNo, pageSize, result.data.total > 0 ? result.data.data.length : 0, "deviceGroupPage", renderTrainingListAndPage);
            } else {
                showMessage("获取部门下用户列表", result.msg, false);
            }
        }

        function bindDeviceGroupClick() {

            $(".device-group-edit").click(function(e) {

                e.preventDefault();

                e.stopPropagation();

                var deviceGroupId = $(this).attr("data-id");

                var deviceGroupIndex=$(this).attr("group-index");

                var targetId= $(this).attr("target-id");

                var cameraId= $(this).attr("camera-id");

                var displayId= $(this).attr("display-id");

                var status=$(this).attr("status");

                var memo=$(this).attr("memo");

                $("#dialog-device-group-form").dialog({
                    modal: true,
                    minWidth: 450,
                    title: "编辑训练计划",
                    open: function(event, ui) {
                        $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                        $("#deviceGroupForm")[0].reset();
                        var targetDeviceGroup = deviceGroupMap[deviceGroupId];
                        groupIndexOptionStr  = "";
                        loadGroupIndexArrayForSelect(deviceGroupIndex,targetId,cameraId,displayId);
                        /*targetIndexOptionStr="";
                        loadTargetIndexArrayForSelect(targetDeviceGroup.targetId);
                        cameraIndexOptionStr="";
                        loadCameraIndexArrayForSelect(targetDeviceGroup.cameraId);
                        displayIndexOptionStr="";
                        loadDisplayIndexArrayForSelect(targetDeviceGroup.displayId);*/

                        if (targetDeviceGroup) {
                            $("#device_group_id").val(deviceGroupId);
                            $("#device_group_index").val(deviceGroupIndex);
                            $("#device_group_target_id").val(targetId);
                            $("#device_group_camera_id").val(cameraId);
                            $("#device_group_display_id").val(displayId);
                            $("#device_group_status").val(status);
                            $("#device_group_memo").val(memo);

                        }
                    },
                    buttons : {
                        "更新": function(e) {
                            e.preventDefault();
                            updateDeviceGroup(false, function (data) {
                                $("#dialog-device-group-form").dialog("close");
                                loadDeviceGroupList();
                            }, function (data) {
                                showMessage("更新训练计划", data.msg, false);
                            })
                        },
                        "取消": function () {
                            $("#dialog-device-group-form").dialog("close");
                        }
                    }
                });
            });

            $(".device-group-delete").click(function (e) {
                e.preventDefault();
                e.stopPropagation();
                var deviceGroupId = $(this).attr("data-id");
                //var deviceGroupName = $(this).attr("data-name");//就是靶位
                if (confirm("确定要删除靶位[" + deviceGroupId + "]吗?")) {
                    $.ajax({
                        url: "/sys/devicegroup/delete.json",
                        data: {
                            id: deviceGroupId
                        },
                        type: 'POST',
                        success: function (result) {
                            if (result.ret) {
                                showMessage("删除靶位[" + deviceGroupId + "]", "操作成功", true);
                                loadDeviceGroupList();
                            } else {
                                showMessage("删除靶位[" + deviceGroupId + "]", result.msg, false);
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

