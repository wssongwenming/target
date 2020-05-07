<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/12/13
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
        参训人员分组情况
        <small>
            <i class="ace-icon fa fa-angle-double-right"></i>
            查看、修改参训人员分组数据
        </small>
    </h1>
</div>
<div class="main-content-inner">
    <div class="col-xs-12">
        <div class="table-header">
            参训人员分组列表&nbsp;&nbsp;
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
                    <div  id="traineeGroupTable">
                    </div>
                    <div class="row" id="traineeGroupPage">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script id="traineeGroupTableTemplate" type="x-tmpl-mustache">
 <table id="dynamic-table" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid"
        aria-describedby="dynamic-table_info" style="font-size:14px">
     <thead>
         <tr role="row">
         <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
            分组序号
         </th>
         {{#deviceGroupNumberList}}
         <th tabindex="0" aria-controls="dynamic-table" rowspan="1" colspan="1">
           靶位{{deviceGroupIndex}}
         </th>
         {{/deviceGroupNumberList}}
         </tr>
     </thead>
     <tbody>
    　　 {{#traineeGroupList}}
　　　　　　<tr role="row">
    　　　　<td>{{groupNumber}}</td>
            {{#traineeList}}
   　　　　　<td>{{#name}}{{name}}{{/name}}</td>
            {{/traineeList}}
　　　　　　</tr>
　　　　{{/traineeGroupList}}
     </tbody>
 </table>
</script>


<script type="application/javascript">
    $(function() {


        var traineeGroupTableTemplate = $('#traineeGroupTableTemplate').html();
        Mustache.parse(traineeGroupTableTemplate);

        loadTraineeGroupList();


        function loadTraineeGroupList(){
            var pageSize = $("#pageSize").val();
            var url = "/sys/trainee/traineeGroupPage.json";
            var pageNo = $("#trainingPage .pageNo").val() || 1;

            $.ajax({
                url : url,
                data: {
                    pageSize: pageSize,
                    pageNo: pageNo
                },
                success: function (result) {
                    renderTraineeGroupListAndPage(result);
                }
            })
        }

        function renderTraineeGroupListAndPage(result) {
            if (result.ret) {

                    showMessage("获取部门下用户列表", JSON.stringify(result.data.deviceGroupNumberList), false);
                    showMessage("获取部门下用户列表", JSON.stringify(result.data.traineeGroupList), false);
                    var rendered = Mustache.render(traineeGroupTableTemplate, {
                        deviceGroupNumberList: result.data.deviceGroupNumberList,
                        traineeGroupList:result.data.traineeGroupList
                    });

                    $("#traineeGroupTable").html(rendered);



                var pageSize = $("#pageSize").val();
                var pageNo = $("#traineeGroupTable .pageNo").val() || 1;
                renderPage(url, result.data.total, pageNo, pageSize, result.data.total > 0 ? result.data.data.length : 0, "traineeGroupPage", renderTrainingListAndPage);
            } else {
                showMessage("获取部门下用户列表", result.msg, false);
            }
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
