<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>参训人员分组</title>
    <jsp:include page="/common/backend_common.jsp"/>
    <jsp:include page="/common/page.jsp"/>
</head>
<body class="no-skin" youdao="bind" style="background: white">
<input id="gritter-light" checked="" type="checkbox" class="ace ace-switch ace-switch-5"/>

<div class="page-header">
    <h1>
        参训人员分组
        <small>
            <i class="ace-icon fa fa-angle-double-right"></i>
            按照靶位数目对参训人员进行分组
        </small>
    </h1>
</div>
<div >
    <div id="smartwizard">
        <ul>
            <li><a href="#step-1">第一步<br /><small>选择待分组人员所在训练计划</small></a></li>
            <li><a href="#step-2">第二步<br /><small>选择靶位</small></a></li>
            <li><a href="#step-3">第三步<br /><small>确认分组信息</small></a></li>
        </ul>

        <div>
            <div id="step-1" class="">
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
            <div id="step-2" class="">
                请选择靶位列表:<div id="deviceGroupList"></div>
            </div>
            <div id="step-3" class="">
                <div class="card">
                    <div class="card-header">人员编组情况</div>
                    <div class="card-block p-1">
                        <table class="table">
                            <tbody>
                            <tr> <th>训练计划:</th> <td id="trainingname"></td> </tr>
                            <tr> <th>选择靶位:</th> <td id="selecteddevicegroup"></td> </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>


</div>
<script id="trainingListTemplate" type="x-tmpl-mustache">
{{#trainingList}}
<tr role="row"  data-id="{{id}}"><!--even -->
    <td><a href="#" class="training-edit" data-id="{{id}}">{{title}}</a></td>
    <td>{{orgDept}}</td>
    <td>{{traineeNumber}}</td>
    <td>{{addr}}</td>
    <td>{{dot}}</td>
    <td>{{memo}}</td>
    <td>
        <input type="radio" class="selectTrainingId" name="optionsRadios" data-id="{{id}}">
    </td>
</tr>
{{/trainingList}}
</script>

<script id="deviceGroupListTemplate" type="x-tmpl-mustache">
{{#deviceGroupList}}
   <input type="checkbox" class="selectDeviceGroup" value="{{groupIndex}}" {{showStatus}}  name="deviceGroup"/>靶位{{groupIndex}}
{{/deviceGroupList}}
</script>
<script type="text/javascript">
    $(document).ready(function(){
        var final =false;
        var trainingMap = {}; // 存储map格式的训练计划信息
        var trainingName="";
        var numberpergroup=-1;
        var trainingId=-1;
        var selecteddevicegroup= "";
        var deviceGroupListTemplate = $('#deviceGroupListTemplate').html();
        var trainingListTemplate = $('#trainingListTemplate').html();
        Mustache.parse(trainingListTemplate);
        Mustache.parse(deviceGroupListTemplate);

        // Step show event
        $("#smartwizard").on("showStep", function(e, anchorObject, stepNumber, stepDirection, stepPosition) {

            if(trainingId==-1&&stepNumber==0){
                $('.sw-btn-next').addClass('disabled');
            }
            if($("input[name='deviceGroup']:checked").length==0&&stepNumber==1){
                $('.sw-btn-next').addClass('disabled');
            }
            if(stepPosition === 'first'){
                final =false;
            }else if(stepPosition === 'final'){
                final=true;
            }else{
                final =false;
            }
            if(stepNumber==1){
                selecteddevicegroup.length=0;
            }
            if(stepNumber==2)
            {
                numberpergroup=$("input[name='deviceGroup']:checked").length;
                selecteddevicegroup="";
                $("input[name='deviceGroup']:checked").each(function(i,d){
                    selecteddevicegroup=selecteddevicegroup+d.value+",";
                });

                $("#selecteddevicegroup").text(selecteddevicegroup.toString());
            }
        });

        // Toolbar extra buttons
        var btnFinish = $('<button></button>').text('完成')
            .addClass('btn btn-info')
            .on('click', function(){
                if(final){
                   // alert(trainingId+":"+numberpergroup)
                    $.ajax({
                        url: "/sys/trainee/group.json",
                        contentType : "application/json",
                        data: {
                            id: trainingId,
                            number:numberpergroup,
                            selecteddevicegroup:selecteddevicegroup
                        },
                        success: function (result) {
                            if (result.ret) {
                                showMessage("分组成功", "操作成功", true);

                            } else {
                                showMessage("分组失败", result.msg, false);
                            }
                        }
                    });
                }else{
                    alert("请完成前面步骤的")

                }
            });
        var btnCancel = $('<button></button>').text('取消')
            .addClass('btn btn-danger')
            .on('click', function(){ $('#smartwizard').smartWizard("reset"); });


        // Smart Wizard
        $('#smartwizard').smartWizard({
            selected: 0,
            theme: 'default',
            transitionEffect:'fade',
            showStepURLhash: true,
            toolbarSettings: {toolbarPosition: 'top',
                //toolbarButtonPosition: 'end',
                toolbarExtraButtons: [btnFinish, btnCancel]
            }
        });

        $(".sw-btn-next").on("click", function(){
            if(trainingId==-1){
                alert("请选择训练计划");
                $('.sw-btn-prev').click();
                $('#smartwizard').smartWizard("prev");
                //$('#smartwizard').smartWizard("reset");
            }else {
                // Navigate next
                $('#smartwizard').smartWizard("next");
                return true;
            }
        });
        loadTrainingList();
        loadDeviceGroupList();
        function loadDeviceGroupList(){
            var url="/sys/devicegroup/devicegroup.json";
            $.ajax({
                url : url,
                success: function (result) {
                    renderDeviceGroupList(result, url);
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
        function renderDeviceGroupList (result){
            if (result.ret) {
                if (result.data.total > 0){
                    var rendered = Mustache.render(deviceGroupListTemplate, {
                        deviceGroupList: result.data.data,
                        "showStatus": function() {
                            return this.number == 1 ? 'checked' : "";
                        }
                    });
                    $("#deviceGroupList").html(rendered);
                    bindDeviceGroupClick();
                    //$.each(result.data.data, function(i, training) {
                    //    trainingMap[training.id] = training;
                   // })
                } else {
                    $("#targetList").html('');
                }
                var pageSize = $("#pageSize").val();
                var pageNo = $("#trainingPage .pageNo").val() || 1;
                renderPage(url, result.data.total, pageNo, pageSize, result.data.total > 0 ? result.data.data.length : 0, "trainingPage", renderTrainingListAndPage);
            } else {
                showMessage("获取部门下用户列表", result.msg, false);
            }
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

            $(".selectTrainingId").click(function(e) {
                e.stopPropagation();
                trainingId = $(this).attr("data-id");
                trainingName=trainingMap[trainingId].title;
                $("#trainingname").text( trainingName.toString());
                $('#smartwizard').smartWizard("reset");

            });
        }
        function bindDeviceGroupClick() {

            $(".selectDeviceGroup").click(function(e) {
                e.stopPropagation();

                $('#smartwizard').smartWizard("reset");
                $('.sw-btn-next').click();
                //$('#smartwizard').smartWizard("next");

            });
        }


    });



</script>
</body>
</html>
