<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta http-equiv="pragma" content="no-cache"/>
<meta charset="utf-8"/>
<title>管理员控制台</title>

<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="/assets/css/bootstrap.min.css"/>

<!-- page specific plugin styles -->
<!-- text fonts -->

<!-- ace styles -->
<link rel="stylesheet" href="/assets/css/ace.min.css"/>
<!--[if lte IE 9]>
<link rel="stylesheet" href="/assets/css/ace-part2.min.css"/>
<![endif]-->






<link rel="stylesheet" href="/assets/css/contextmenu/jquery.contextMenu.css" />
<link rel="stylesheet" href="/assets/css/contextmenu/screen.css" />
<link rel="stylesheet" href="/assets/css/contextmenu/prettify.sunburst.css" />




<!--[if lte IE 9]>

<![endif]-->
<!-- inline styles related to this page -->
<!-- ace settings handler -->

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lte IE 8]>
<script src="/js/html5shiv.min.js"></script>
<script src="/js/respond.min.js"></script>
<![endif]-->

<script src="/assets/js/jquery-1.8.2.min.js"></script>
<script src="/assets/js/jquery-ui.min.js"></script>



<script src="/assets/js/contextmenu/jquery.contextMenu.js"></script>
<script src="/assets/js/contextmenu/jquery.ui.position.js"></script>
<script src="/assets/js/contextmenu/screen.js"></script>
<script src="/assets/js/contextmenu/prettify/prettify.js"></script>



<script src="/js/mustache.js"></script>

<script type="text/javascript">
    // 展示提示信息
    function showMessage(title, msg, isSuccess) {
        if (!isSuccess) {
            msg = msg || '';
        } else {
            msg = msg || '操作成功'
        }
        $.gritter.add({
            title: title,
            text: msg != '' ? msg : "服务器处理异常, 建议刷新页面来保证数据是最新的",
            time: '',
            class_name: (isSuccess ? 'gritter-success' : 'gritter-warning') + (!$('#gritter-light').get(0).checked ? ' gritter-light' : '')
        });
    }
</script>