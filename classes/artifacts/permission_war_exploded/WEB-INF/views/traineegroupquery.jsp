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
  <%--                  <div class="col-xs-6">
                        <div class="dataTables_length align-middle" id="dynamic-table_length" ><label>
                            展示
                            <select id="pageSize" name="dynamic-table_length" aria-controls="dynamic-table" class="form-control input-sm">
                                <option value="2">2</option>
                                <option value="25">25</option>
                                <option value="50">50</option>
                                <option value="100">100</option>
                            </select> 条记录 </label>
                        </div>
                    </div>--%>
                    <table id="traineeGroupTable" class="table table-striped table-bordered table-hover dataTable no-footer" role="grid"
                           aria-describedby="dynamic-table_info" style="font-size:14px">

                    </table>
                    <div class="row" id="traineeGroupPage">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script id="traineeGroupTableTemplate" type="x-tmpl-mustache">
     <thead>
         <tr role="row">
         <th style="display:none;">
         </th>
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
            <td style="display:none;">{{id}}</td>
    　　　　<td>第{{groupNumber}}组</td>
            {{#traineeList}}
   　　　　　<td class="trainee_td">{{name}}</td>
            {{/traineeList}}
　　　　　　</tr>
　　　　{{/traineeGroupList}}
     </tbody>
</script>


<script type="application/javascript">
    $(function() {
        var col_length;//总共有多少列
        var row_length;//总共有多少列
        var rows;//当前表格的所有行
        var tb;//当前表格
        var traineeGroupMap = {}; // 存储map格式的用户分组信息
        var trainee_Ids_Map={};
        var group_id;//靶位编组Id
        var group_number;//靶位编组序号
        var current_col_index;//单击右键获得列号
        var current_row_index;//单击右键获得行号
        var traineeGroupTableTemplate = $('#traineeGroupTableTemplate').html();
        Mustache.parse(traineeGroupTableTemplate);

        loadTraineeGroupList();
        $("body").on("contextmenu", "table tr td", function(e) {
            var target = e.target;
            //var text = target.innerText || target.textContent;
            tb = document.getElementById("traineeGroupTable");    // table 的 id
            rows = tb.rows;
            current_col_index = $(e.target)[0].cellIndex;
            current_row_index = $(e.target).parent()[0].rowIndex;
            group_number=rows[current_row_index].cells[1].innerHTML.substring(1,rows[current_row_index].cells[1].innerHTML.length-1);
            group_id=rows[current_row_index].cells[0].innerHTML;
            //row_length=document.getElementById("traineeGroupTable").rows.length-1;//除去表头的行数,此处不用了，后改为记录的行数，用于判断是否“下一组”操作时是否是最后一条记录
            col_length=document.getElementById("traineeGroupTable").rows.item(0).cells.length-1;//除去第一列的列数
            return true;
        });

        function loadTraineeGroupList(){
            //var pageSize = $("#pageSize").val();
            var pageSize=1000;
            var url = "/sys/trainee/traineeGroupPage.json";
            //var pageNo = $("#trainingPage .pageNo").val() || 1;
            var pageNo=1;
            $.ajax({
                url : url,
                data: {
                    pageSize: pageSize,
                    pageNo: pageNo
                },
                success: function (result) {
                    renderTraineeGroupListAndPage(result,url);
                }
            })
        }

        function renderTraineeGroupListAndPage(result,url) {
            if (result.ret) {
                 var rendered = Mustache.render(traineeGroupTableTemplate, {
                        deviceGroupNumberList: result.data.deviceGroupNumberList,
                        traineeGroupList:result.data.traineeGroupList
                    });
                    $("#traineeGroupTable").html(rendered);
                    var traineeGroupIdMap={};//存储Map格式的TraineeGroup的Id

                    $.each(result.data.traineeGroupList, function(i, traineeGroup) {
                        traineeGroupMap[traineeGroup.groupNumber] = traineeGroup;
                        traineeGroupIdMap[traineeGroup.groupNumber]=traineeGroup.id;
                        trainee_Ids_Map[traineeGroup.groupNumber]=traineeGroup.traineeIds;
                        row_length=result.data.total;
                    });

                    //alert(JSON.stringify(trainee_Ids_Map));

                    //加入用户自定义菜单
                $.contextMenu({
                    selector: '.trainee_td',
                    callback: function(key, options) {
                        switch (key) {
                            case "pretarget":
                                var row_index=current_row_index;//记录在表格中的行号
                                var new_col=parseInt(current_col_index)-1;
                                if(new_col>1) {//第0列为隐藏列，第一列为分组列
                                    var traineeIds=trainee_Ids_Map[group_number];
                                    var traineeIdArray=traineeIds.split(",");

                                    var temp=traineeIdArray[parseInt(current_col_index)-2];//i-2，因为每行有个隐藏列，和一个“组”列表头，
                                    traineeIdArray[parseInt(current_col_index)-2]=traineeIdArray[parseInt(new_col)-2];
                                    traineeIdArray[parseInt(new_col)-2]=temp;
                                    var newTraineeIds=traineeIdArray.join(",");

                                   $.ajax({
                                        url : "/sys/trainee/updateTraineeGroup_target.json?id="+group_id+"&trainee_ids="+newTraineeIds,
                                        success: function () {
                                            var temp = rows[row_index].cells[current_col_index].innerHTML;
                                            rows[row_index].cells[current_col_index].innerHTML = rows[row_index].cells[parseInt(current_col_index) - 1].innerHTML;
                                            rows[row_index].cells[parseInt(current_col_index) - 1].innerHTML = temp;
                                            trainee_Ids_Map[group_number]=newTraineeIds;
                                        }
                                    })
                                }
                                break;
                            case "nexttarget":
                                var row_index=current_row_index;//记录在表格中的行号
                                var new_col=parseInt(current_col_index)+1;
                                if(new_col<=col_length) {
                                    var traineeIds=trainee_Ids_Map[group_number];
                                    var traineeIdArray=traineeIds.split(",");
                                    var temp=traineeIdArray[parseInt(current_col_index)-2];//i-2，因为每行有个隐藏列，和一个“组”列表头，
                                    traineeIdArray[parseInt(current_col_index)-2]=traineeIdArray[parseInt(new_col)-2];
                                    traineeIdArray[parseInt(new_col)-2]=temp;
                                    var newTraineeIds=traineeIdArray.join(",");
                                    $.ajax({
                                        url : "/sys/trainee/updateTraineeGroup_target.json?id="+group_id+"&trainee_ids="+newTraineeIds,
                                        success: function () {
                                            var temp = rows[row_index].cells[current_col_index].innerHTML;
                                            rows[row_index].cells[current_col_index].innerHTML = rows[row_index].cells[parseInt(current_col_index) + 1].innerHTML;
                                            rows[row_index].cells[parseInt(current_col_index) + 1].innerHTML = temp;
                                            trainee_Ids_Map[group_number]=newTraineeIds;
                                        }
                                    })
                                }
                                break;
                            case "pregroup":
                                var row_index=current_row_index;//记录在表格中的行号
                                var new_row_index=current_row_index-1;
                                //if(group_number>1) {
                                    if(current_row_index>1) {
                                        var traineeIds_befor=trainee_Ids_Map[parseInt(group_number)-1];
                                        var traineeIds      =trainee_Ids_Map[group_number];
                                        var traineeIdArray=traineeIds.split(",");
                                        var traineeIdArray_befor=traineeIds_befor.split(",");

                                        var temp=traineeIdArray[parseInt(current_col_index)-2];//i-2，因为每行有个隐藏列，和一个“组”列表头，
                                        traineeIdArray[parseInt(current_col_index)-2]= traineeIdArray_befor[parseInt(current_col_index)-2];
                                        traineeIdArray_befor[parseInt(current_col_index)-2]=temp;
                                        var newTraineeIds=traineeIdArray.join(",");
                                        var newTraineeIds_befor=traineeIdArray_befor.join(",");

                                        var group_id_before=parseInt(group_id)-1;//靶位编组的id
                                        var group_number_before=parseInt(group_number)-1;//靶位编组的序号

                                        $.ajax({
                                            url : "/sys/trainee/updateTraineeGroup_group.json?id1="+group_id+"&group_index="+group_number+"&trainee_ids1="+newTraineeIds+"&id2="+group_id_before+"&group_index_before_or_next="+group_number_before+"&trainee_ids2="+newTraineeIds_befor,
                                            success: function () {

                                                var temp1 = rows[current_row_index].cells[current_col_index].innerHTML;
                                                rows[current_row_index].cells[current_col_index].innerHTML = rows[parseInt(current_row_index) - 1].cells[current_col_index].innerHTML;
                                                rows[parseInt(current_row_index) - 1].cells[current_col_index].innerHTML = temp1;
                                                trainee_Ids_Map[group_number]=newTraineeIds;
                                                trainee_Ids_Map[parseInt(group_number)-1]=newTraineeIds_befor;
                                            }
                                        })


                                    }else{//


                                    }
                                //}
                                break;
                            case "nextgroup":

                                if(group_number<row_length) {
                                    var traineeIds_next=trainee_Ids_Map[parseInt(group_number)+1];
                                    var traineeIds      =trainee_Ids_Map[group_number];
                                    var traineeIdArray=traineeIds.split(",");
                                    var traineeIdArray_next=traineeIds_next.split(",");

                                    var temp=traineeIdArray[parseInt(current_col_index)-2];//i-2，因为每行有个隐藏列，和一个“组”列表头，
                                    traineeIdArray[parseInt(current_col_index)-2]= traineeIdArray_next[parseInt(current_col_index)-2];
                                    traineeIdArray_next[parseInt(current_col_index)-2]=temp;

                                    var newTraineeIds=traineeIdArray.join(",");
                                    var newTraineeIds_next=traineeIdArray_next.join(",");
                                    var group_id_next=parseInt(group_id)+1;
                                    var group_number_next=parseInt(group_number)+1;//靶位编组的序号


                                    $.ajax({
                                        url : "/sys/trainee/updateTraineeGroup_group.json?id1="+group_id+"&group_index="+group_number+"&trainee_ids1="+newTraineeIds+"&id2="+group_id_next+"&group_index_before_or_next="+group_number_next+"&trainee_ids2="+newTraineeIds_next,
                                        success: function () {
                                      var temp=rows[current_row_index].cells[current_col_index].innerHTML;
                                      rows[current_row_index].cells[current_col_index].innerHTML = rows[parseInt(current_row_index) + 1].cells[current_col_index].innerHTML;
                                      rows[parseInt(current_row_index) + 1].cells[current_col_index].innerHTML = temp;
                                            trainee_Ids_Map[group_number]=newTraineeIds;
                                            trainee_Ids_Map[parseInt(group_number)+1]=newTraineeIds_next;
                                        }
                                    })



                                }
                                break

                        }
                    },
                    items: {
                        "pretarget": {name: "前一个靶位", accesskey: "a"},
                        "nexttarget": {name: "后一个靶位",accesskey: "b"},
                        "pregroup": {name: "前一编组", accesskey: "c"},
                        "nextgroup": {name: "后一编组",accesskey: "d"},

                    }
                });


                //var pageSize = $("#pageSize").val();
                var pageSize=1000;
                //var pageNo = $("#traineeGroupPage .pageNo").val() || 1;
                var pageNo=1;
                renderPage(url, result.data.total, pageNo, pageSize, result.data.total > 0 ? result.data.traineeGroupList.length : 0, "traineeGroupPage", renderTraineeGroupListAndPage);
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

    });

    function ClearArr(arr){
        for( key in arr){
            arr.remove(key);
        }
        return arr;
    }
</script>

</body>
</html>
