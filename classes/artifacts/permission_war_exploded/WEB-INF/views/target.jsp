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
        靶机设备维护
        <small>
            <i class="ace-icon fa fa-angle-double-right"></i>
            维护靶机设备
        </small>
    </h1>
</div>
<div class="main-content-inner">
    <div class="col-xs-12">
        <div class="table-header">
            靶机设备列表&nbsp;&nbsp;
            <a class="green" href="#">
                <i class="ace-icon fa fa-plus-circle orange bigger-130  target-add"></i>
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
                                设备名称
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                设备编号
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                MAC地址
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                IP地址
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                靶位编号
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                设备状态
                            </th>
                            <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
                                备注
                            </th>
                            <th class="sorting_disabled" rowspan="1" colspan="1" aria-label=""></th>
                        </tr>
                        </thead>
                        <tbody id="targetList"></tbody>
                    </table>
                    <div class="row" id="targetPage">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="dialog-target-form" style="display: none;">
    <form id="targetForm">
        <table class="table table-striped table-bordered table-hover dataTable no-footer" role="grid">
            <tr>
                <td style="width: 80px;"><label for="device_name">设备名称</label></td>
                <input type="hidden" name="id" id="targetId"/>
                <td style="width: 200px;"><input type="text" name="name" id="device_name" value="靶机设备" class="text ui-widget-content ui-corner-all"></td>
            </tr>
            <tr>
                <td style="width: 120px;"><label for="deviceIndex">设备编号</label></td>
                <td>
                    <select id="deviceIndex" name="device_index" data-placeholder="选择设备编号" style="width: 170px;"></select>
                </td>
            </tr>
            <tr>
                <td><label for="device_mac">MAC地址</label></td>
                <td><input type="text" name="mac" id="device_mac" value="" class="text ui-widget-content ui-corner-all"></td>
            </tr>
            <tr>
                <td><label for="device_ip">IP地址</label></td>
                <td><input type="text" name="ip" id="device_ip" value="" class="text ui-widget-content ui-corner-all"></td>
            </tr>

            <tr>
                <td><label for="device_number">所处靶位编号</label></td>
                <td><input type="text" name="number" id="device_number" value="" placeholder="未知" readonly class="text ui-widget-content ui-corner-all"></td>
            </tr>

            <tr>
                <td><label for="device_status">设备状态</label></td>
                <td>
                    <select id="device_status" name="status" data-placeholder="选择状态" style="width: 150px;">
                        <option value="2">新添加</option>
                        <option value="0">正常</option>
                        <option value="1">异常</option>
                    </select>
                </td>

            </tr>
            <tr>
                <td><label for="target_memo">备注</label></td>
                <td><textarea name="memo" id="target_memo" class="text ui-widget-content ui-corner-all" rows="3" cols="25"></textarea></td>
            </tr>
        </table>
    </form>
</div>
<script id="targetListTemplate" type="x-tmpl-mustache">
{{#targetList}}
<tr role="row"  data-id="{{id}}"><!--even -->
    <td><a href="#" class="target-edit" data-id="{{id}}">{{name}}</a></td>
    <td>{{device_index}}</td>
    <td>{{mac}}</td>
    <td>{{ip}}</td>
    <td>{{number}}</td>
    <td>{{showStatus}}</td>
    <td>{{memo}}</td>
    <td>
        <div class="hidden-sm hidden-xs action-buttons">
            <a class="green target-edit" href="#" data-id="{{id}}">
                <i class="ace-icon fa fa-pencil bigger-100"></i>
            </a>
            &nbsp;
            <a class="red target-delete" href="#" data-id="{{id}}" data-name="{{name}}">
                <i class="ace-icon fa fa-trash-o bigger-100"></i>
            </a>
         </div>
    </td>
</tr>
{{/targetList}}
</script>
<script type="application/javascript">
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


    $(function() {
        var deviceIndexOptionStr = "";
        var targetMap = {}; // 存储map格式的训练计划信息
        var targetListTemplate = $('#targetListTemplate').html();
        Mustache.parse(targetListTemplate);

        loadTargetList();

        $(".target-add").click(function() {
            $("#dialog-target-form").dialog({
                modal: true,
                minWidth: 450,
                title: "新增拍照设备",
                open: function(event, ui) {
                    $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                    deviceIndexOptionStr = "";
                    loadTargetIndexArrayForSelect("");
                    $("#targetForm")[0].reset();
                },
                buttons : {
                    "添加": function(e) {
                        e.preventDefault();
                        updateTarget(true, function (data) {
                            $("#dialog-target-form").dialog("close");
                            loadTargetList();
                        }, function (data) {
                            showMessage("新增靶机设备", data.msg, false);
                        })
                    },
                    "取消": function () {
                        $("#dialog-target-form").dialog("close");
                    }
                }
            });
        });
        function loadTargetIndexArrayForSelect(optionStr) {//这里加了一个参数，就是为了在编辑时将当前的index带入
            $.ajax({
                url: "/sys/target/target.json",
                success : function (result) {
                    var device_index_array=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];

                    if (result.ret) {
                        var targetlist= result.data.data;
                        if(targetlist!=null) {
                            $.each(targetlist, function(i, target) {
                                var device_index=target.device_index;
                                device_index_array.remove(device_index);
                            });
                        }

                        $(device_index_array).each(function (i, device_index) {

                            deviceIndexOptionStr += Mustache.render("<option value='{{id}}'>{{id}}</option>",{id: device_index});

                        });
                        if(optionStr==null || optionStr=="" || optionStr=='undefined'){
                            $("#deviceIndex").html(deviceIndexOptionStr);
                        }else {
                            $("#deviceIndex").html(Mustache.render("<option value='{{id}}'>{{id}}</option>", {id: optionStr}) + deviceIndexOptionStr);
                        }
                    } else {
                        showMessage("加载部门列表", result.msg, false);
                    }
                }
            })
        }
        function updateTarget(isCreate, successCallback, failCallback) {
            $.ajax({
                url: isCreate ? "/sys/target/save.json" : "/sys/target/update.json",
                data: $("#targetForm").serializeArray(),
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
        function loadTargetList(){
            var pageSize = $("#pageSize").val();
            var url = "/sys/target/page.json";
            var pageNo = $("#targetPage .pageNo").val() || 1;
            $.ajax({
                url : url,
                data: {
                    pageSize: pageSize,
                    pageNo: pageNo
                },
                success: function (result) {
                    renderTargetListAndPage(result, url);
                }
            })
        }

        function renderTargetListAndPage(result, url) {
            if (result.ret) {
                if (result.data.total > 0){
                    var rendered = Mustache.render(targetListTemplate, {
                        targetList: result.data.data,
                        "showStatus": function() {
                            return this.status == 0 ? '正常' :(this.status == 1 ? '异常':"新添加" );
                        }
                    });
                    $("#targetList").html(rendered);
                    bindTargetClick();
                    $.each(result.data.data, function(i, target) {
                        targetMap[target.id] = target;
                    })
                } else {
                    $("#targetList").html('');
                }
                var pageSize = $("#pageSize").val();
                var pageNo = $("#targetPage .pageNo").val() || 1;
                renderPage(url, result.data.total, pageNo, pageSize, result.data.total > 0 ? result.data.data.length : 0, "targetPage", renderTargetListAndPage);
            } else {
                showMessage("获取照靶设备列表", result.msg, false);
            }
        }

        function bindTargetClick() {

            $(".target-edit").click(function(e) {
                e.preventDefault();
                e.stopPropagation();
                var targetId = $(this).attr("data-id");
                $("#dialog-target-form").dialog({
                    modal: true,
                    minWidth: 450,
                    title: "编辑照靶设备",
                    open: function(event, ui) {
                        $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                        $("#targetForm")[0].reset();
                        var targetTarget = targetMap[targetId];
                        deviceIndexOptionStr = ""
                        loadTargetIndexArrayForSelect(targetTarget.device_index);
                        if (targetTarget) {
                            $("#targetId").val(targetTarget.id);
                            $("#device_name").val(targetTarget.name);
                            $("#device_mac").val(targetTarget.mac);
                            $("#device_ip").val(targetTarget.ip);
                            $("#device_status").val(targetTarget.status);
                            $("#device_number").val(targetTarget.number);
                            $("#device_memo").val(targetTarget.memo);
                        }
                    },
                    buttons : {
                        "更新": function(e) {
                            e.preventDefault();
                            updateTarget(false, function (data) {
                                $("#dialog-target-form").dialog("close");
                                loadTargetList();
                            }, function (data) {
                                showMessage("更新照靶设备", data.msg, false);
                            })
                        },
                        "取消": function () {
                            $("#dialog-target-form").dialog("close");
                        }
                    }
                });
            });

            $(".target-delete").click(function (e) {
                e.preventDefault();
                e.stopPropagation();
                var targetId = $(this).attr("data-id");
                var targetName = $(this).attr("data-name");
                if (confirm("确定要删除照靶设备[" + targetName + "]吗?")) {
                    $.ajax({
                        url: "/sys/target/delete.json",
                        data: {
                            id: targetId
                        },
                        type: 'POST',
                        success: function (result) {
                            if (result.ret) {
                                showMessage("删除设备[" + targetName + "]", "操作成功", true);
                                loadTargetList();
                            } else {
                                showMessage("删除设备[" + targetName + "]", result.msg, false);
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