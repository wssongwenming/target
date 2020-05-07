<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="de" lang="de">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <title>Accesskeys Demo - jQuery contextMenu Plugin</title>
    <jsp:include page="/common/backend_common1.jsp"/>
    <meta name="description" content="simple contextMenu generator for interactive web applications based on jQuery" />

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



    </head>
    <body class="no-skin" youdao="bind" style="background: white">

    <div class="context-menu-one">
        <strong>right click me</strong>
    </div>
    <script type="text/javascript">
        $(function(){
            $.contextMenu({
                selector: '.context-menu-one',
                callback: function(key, options) {
                    var m = "clicked: " + key;
                    window.console && console.log(m) || alert(m);
                },
                items: {
                    "edit": {name: "Edit", icon: "edit", accesskey: "e"},
                    "cut": {name: "Cut", icon: "cut", accesskey: "c"},
                    // first unused character is taken (here: o)
                    "copy": {name: "Copy", icon: "copy", accesskey: "c o p y"},
                    // words are truncated to their first letter (here: p)
                    "paste": {name: "Paste", icon: "paste", accesskey: "cool paste"},
                    "delete": {name: "Delete", icon: "delete"},
                    "sep1": "---------",
                    "quit": {name: "Quit", icon: "quit"}
                }
            });
        });
    </script>
    </body>
    </html>