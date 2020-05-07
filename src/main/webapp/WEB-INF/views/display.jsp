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
        显靶终端设备维护
        <small>
            <i class="ace-icon fa fa-angle-double-right"></i>
            维护显靶终端设备
        </small>
    </h1>
</div>
<div class="main-content-inner">
    <div class="col-xs-12">
        <div class="table-header">
            显靶终端设备列表&nbsp;&nbsp;
            <a class="green" href="#">
                <i class="ace-icon fa fa-plus-circle orange bigger-130  display-add"></i>
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
                        <tbody id="displayList"></tbody>
                    </table>
                    <div class="row" id="displayPage">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="dialog-display-form" style="display: none;">
    <form id="displayForm">
        <table class="table table-striped table-bordered table-hover dataTable no-footer" role="grid">
            <tr>
                <td style="width: 80px;"><label for="device_name">设备名称</label></td>
                <input type="hidden" name="id" id="displayId"/>
                <td style="width: 200px;"><input type="text" name="name" id="device_name" value="显靶终端" class="text ui-widget-content ui-corner-all"></td>
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
                <td><label for="display_memo">备注</label></td>
                <td><textarea name="memo" id="display_memo" class="text ui-widget-content ui-corner-all" rows="3" cols="25"></textarea></td>
            </tr>
        </table>
    </form>
</div>
<script id="displayListTemplate" type="x-tmpl-mustache">
{{#displayList}}
<tr role="row"  data-id="{{id}}"><!--even -->
    <td><a href="#" class="display-edit" data-id="{{id}}">{{name}}</a></td>
    <td>{{device_index}}</td>
    <td>{{mac}}</td>
    <td>{{ip}}</td>
    <td>{{number}}</td>
    <td>{{showStatus}}</td>
    <td>{{memo}}</td>
    <td>
        <div class="hidden-sm hidden-xs action-buttons">
            <a class="green display-edit" href="#" data-id="{{id}}">
                <i class="ace-icon fa fa-pencil bigger-100"></i>
            </a>
            &nbsp;
            <a class="red display-delete" href="#" data-id="{{id}}" data-name="{{name}}">
                <i class="ace-icon fa fa-trash-o bigger-100"></i>
            </a>
         </div>
    </td>
</tr>
{{/displayList}}
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
        var displayMap = {}; // 存储map格式的训练计划信息
        var displayListTemplate = $('#displayListTemplate').html();
        Mustache.parse(displayListTemplate);

        loadDisplayList();

        $(".display-add").click(function() {
            $("#dialog-display-form").dialog({
                modal: true,
                minWidth: 450,
                title: "新增拍照设备",
                open: function(event, ui) {
                    $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                    deviceIndexOptionStr = "";
                    loadDisplayIndexArrayForSelect("");
                    $("#displayForm")[0].reset();
                },
                buttons : {
                    "添加": function(e) {
                        e.preventDefault();
                        updateDisplay(true, function (data) {
                            $("#dialog-display-form").dialog("close");
                            loadDisplayList();
                        }, function (data) {
                            showMessage("新增拍照设备", data.msg, false);
                        })
                    },
                    "取消": function () {
                        $("#dialog-display-form").dialog("close");
                    }
                }
            });
        });

        function loadDisplayIndexArrayForSelect(optionStr) {//这里加了一个参数，就是为了在编辑时将当前的index带入
            $.ajax({
                url: "/sys/display/display.json",
                success : function (result) {
                    var device_index_array=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];

                    if (result.ret) {
                        var displaylist = result.data.data;
                        if(displaylist!=null) {
                            $.each(displaylist, function (i, display) {
                                var device_index = display.device_index;
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
        function updateDisplay(isCreate, successCallback, failCallback) {
            $.ajax({
                url: isCreate ? "/sys/display/save.json" : "/sys/display/update.json",
                data: $("#displayForm").serializeArray(),
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
        function loadDisplayList(){
            var pageSize = $("#pageSize").val();
            var url = "/sys/display/page.json";
            var pageNo = $("#displayPage .pageNo").val() || 1;
            $.ajax({
                url : url,
                data: {
                    pageSize: pageSize,
                    pageNo: pageNo
                },
                success: function (result) {
                    renderDisplayListAndPage(result, url);
                }
            })
        }

        function renderDisplayListAndPage(result, url) {
            if (result.ret) {
                if (result.data.total > 0){
                    var rendered = Mustache.render(displayListTemplate, {
                        displayList: result.data.data,
                        "showStatus": function() {
                            return this.status == 0 ? '正常' :(this.status == 1 ? '异常':"新添加" );
                        }
                    });
                    $("#displayList").html(rendered);
                    bindDisplayClick();
                    $.each(result.data.data, function(i, display) {
                        displayMap[display.id] = display;
                    })
                } else {
                    $("#displayList").html('');
                }
                var pageSize = $("#pageSize").val();
                var pageNo = $("#displayPage .pageNo").val() || 1;
                renderPage(url, result.data.total, pageNo, pageSize, result.data.total > 0 ? result.data.data.length : 0, "displayPage", renderDisplayListAndPage);
            } else {
                showMessage("获取照靶设备列表", result.msg, false);
            }
        }

        function bindDisplayClick() {

            $(".display-edit").click(function(e) {
                e.preventDefault();
                e.stopPropagation();
                var displayId = $(this).attr("data-id");
                $("#dialog-display-form").dialog({
                    modal: true,
                    minWidth: 450,
                    title: "编辑照靶设备",
                    open: function(event, ui) {
                        $(".ui-dialog-titlebar-close", $(this).parent()).hide();
                        $("#displayForm")[0].reset();
                        var targetDisplay = displayMap[displayId];
                        deviceIndexOptionStr = ""
                        loadDisplayIndexArrayForSelect(targetDisplay.device_index);
                        if (targetDisplay) {
                            $("#displayId").val(targetDisplay.id);
                            $("#device_name").val(targetDisplay.name);
                            $("#device_mac").val(targetDisplay.mac);
                            $("#device_ip").val(targetDisplay.ip);
                            $("#device_status").val(targetDisplay.status);
                            $("#device_number").val(targetDisplay.number);
                            $("#device_memo").val(targetDisplay.memo);
                        }
                    },
                    buttons : {
                        "更新": function(e) {
                            e.preventDefault();
                            updateDisplay(false, function (data) {
                                $("#dialog-display-form").dialog("close");
                                loadDisplayList();
                            }, function (data) {
                                showMessage("更新照靶设备", data.msg, false);
                            })
                        },
                        "取消": function () {
                            $("#dialog-display-form").dialog("close");
                        }
                    }
                });
            });

            $(".display-delete").click(function (e) {
                e.preventDefault();
                e.stopPropagation();
                var displayId = $(this).attr("data-id");
                var displayName = $(this).attr("data-name");
                if (confirm("确定要删除照靶设备[" + displayName + "]吗?")) {
                    $.ajax({
                        url: "/sys/display/delete.json",
                        data: {
                            id: displayId
                        },
                        type: 'POST',
                        success: function (result) {
                            if (result.ret) {
                                showMessage("删除设备[" + displayName + "]", "操作成功", true);
                                loadDisplayList();
                            } else {
                                showMessage("删除设备[" + displayName + "]", result.msg, false);
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