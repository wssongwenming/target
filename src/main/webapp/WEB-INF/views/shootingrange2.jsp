<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/1/26
  Time: 19:48
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
<script id="tmple" type="text-x-mustache-tmpl">
	<div>{{name}}<div>

<div>--------分割线第一个---------</div>
	{{#list}}
		<div>
			姓名：{{name}}
		</div>
		<div>
			年龄：{{age}}
		</div>
		<div>
			性别：{{sex}}
		</div>
	 {{/list}}

 <div>--------分割线第二个---------</div>
	{{#list}}
		<div>
			姓名：{{name}}
		</div>
		<div>
			年龄：{{age}}
		</div>
		<div>
			性别：{{sex}}-->格式化后:{{{formatSex}}}
		</div>
		<div>
			朋友：<div id="people_{{id}}" style="margin-left:20px">
				 </div>
		</div>

 	{{/list}}
</script>

<script id="friends" type="text-x-mustache-tmpl">

	{{#friends}}
		<div>
			姓名：{{name}}
		</div>
		<div>
			年龄：{{age}}
		</div>
		<div>
			性别：{{sex}}
		</div>
 	{{/friends}}
</script>

<script type="application/javascript">
$(function(){

var tmple = $('#tmple').html();
Mustache.parse(tmple);

//读取普通数据
var data={"name":"张三"}
var rendered = Mustache.render(tmple, data);
$("#tmpleHtml").html(rendered);

//读取数组
data=[
{"name":"张三",
"age":"18",
"sex":"男"},
{"name":"李四",
"age":"19",
"sex":"男"},
{"name":"王五",
"age":"20",
"sex":"女"},
]
var rendered = Mustache.render(tmple, {list:data});
$("#tmpleHtml").html(rendered);

//读取二数组
data=[
{
"id":1,
"name":"张三",
"age":"18",
"sex":"男",
"friends":[{
"name":"张三朋友一",
"age":"18",
"sex":"男",
},{
"name":"张三朋友二",
"age":"18",
"sex":"男",
}]},
{
"id":2,
"name":"李四",
"age":"19",
"sex":"男",
"friends":[{
"name":"李四朋友一",
"age":"18",
"sex":"男",
}]},
{
"id":3,
"name":"王五",
"age":"20",
"sex":"女",
"friends":[{
"name":"王五朋友一",
"age":"18",
"sex":"男",
}]},
]
var rendered = Mustache.render(tmple, {list:data});
$("#tmpleHtml").html(rendered);

var friends = $('#friends').html();
for(var i=0;i<data.length;i++){
Mustache.parse(friends);
var rendered = Mustache.render(friends, {friends:data[i].friends});
$("#people_"+data[i].id).append(rendered);//注意这里是append,不是html(html是覆盖,append是添加)
}

})
</script>


<div id="tmpleHtml"></div>

</body>
</html>
