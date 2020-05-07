<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<style type="text/css">
    li{ display:inline;}
</style>--%>
<script id="paginateTemplate" type="x-tmpl-mustache">
<div class="col-xs-6">
    <div class="dataTables_info" id="dynamic-table_info" role="status" aria-live="polite">
        总共 {{total}} 中的 {{from}} ~ {{to}}
    </div>
</div>
    
<div class="col-xs-6">
    <div class="dataTables_paginate paging_simple_numbers" id="dynamic-table_paginate">
        <ul class="pagination" style="width: 300px;">
            <li class="paginate_button previous {{^firstUrl}}disabled{{/firstUrl}}" aria-controls="dynamic-table" tabindex="0">
                <a href="#" data-target="1" data-url="{{firstUrl}}" class="page-action">首页</a>
            </li>
            <li class="paginate_button {{^beforeUrl}}disabled{{/beforeUrl}}" aria-controls="dynamic-table" tabindex="0">
                <a href="#" data-target="{{beforePageNo}}" data-url="{{beforeUrl}}" class="page-action">前一页</a>
            </li>
            <li class="paginate_button active" aria-controls="dynamic-table" tabindex="0">
                <a href="#" data-id="{{pageNo}}" >第{{pageNo}}页</a>
                <input type="hidden" class="pageNo" value="{{pageNo}}" />
            </li>
            <li class="paginate_button {{^nextUrl}}disabled{{/nextUrl}}" aria-controls="dynamic-table" tabindex="0">
                <a href="#" data-target="{{nextPageNo}}" data-url="{{nextUrl}}" class="page-action">后一页</a>
            </li>
            <li class="paginate_button next {{^lastUrl}}disabled{{/lastUrl}}" aria-controls="dynamic-table" tabindex="0">
                <a href="#" data-target="{{maxPageNo}}" data-url="{{lastUrl}}" class="page-action">尾页</a>
            </li>
        </ul>
    </div>
</div>
</script>


<script id="simplePaginateTemplate" type="x-tmpl-mustache">

    <div class="dataTables_paginate paging_simple_numbers" id="dynamic-table_paginate">
        <ul class="pagination">
            <li class="paginate_button {{^beforeUrl}}disabled{{/beforeUrl}}" aria-controls="dynamic-table" tabindex="0">
                <a href="#" data-target="{{beforePageNo}}" data-url="{{beforeUrl}}" class="page-action-simple">前一页</a>
            </li>
            <li class="paginate_button active" aria-controls="dynamic-table" tabindex="0">
                <a href="#" data-id="{{pageNo}}" >第{{pageNo}}页</a>
                <input type="hidden" class="pageNo" value="{{pageNo}}" />
            </li>
            <li class="paginate_button {{^nextUrl}}disabled{{/nextUrl}}" aria-controls="dynamic-table" tabindex="0">
                <a href="#" data-target="{{nextPageNo}}" data-url="{{nextUrl}}" class="page-action-simple">后一页</a>
            </li>
        </ul>
</div>
</script>


<script type="text/javascript">
    var paginateTemplate = $("#paginateTemplate").html();
    var simplePaginateTemplate= $("#simplePaginateTemplate").html();
    Mustache.parse(paginateTemplate);
    Mustache.parse(simplePaginateTemplate);
    
    function renderPage(url, total, pageNo, pageSize, currentSize, idElement, callback) {
        var maxPageNo = Math.ceil(total / pageSize);
        var paramStartChar = url.indexOf("?") > 0 ? "&" : "?";
        var from = (pageNo - 1) * pageSize + 1;
        var view = {
            from: from > total ? total : from,
            to: (from + currentSize - 1) > total ? total : (from + currentSize - 1),
            total : total,
            pageNo : pageNo,
            maxPageNo : maxPageNo,
            nextPageNo: pageNo >= maxPageNo ? maxPageNo : (pageNo - 0 + 1),
            beforePageNo : pageNo == 1 ? 1 : (pageNo - 1),
            firstUrl : (pageNo == 1) ? '' : (url + paramStartChar + "pageNo=1&pageSize=" + pageSize),
            beforeUrl: (pageNo == 1) ? '' : (url + paramStartChar + "pageNo=" + (pageNo - 1) + "&pageSize=" + pageSize),
            nextUrl : (pageNo >= maxPageNo) ? '' : (url + paramStartChar + "pageNo=" + (pageNo - 0 + 1) + "&pageSize=" + pageSize),
            lastUrl : (pageNo >= maxPageNo) ? '' : (url + paramStartChar + "pageNo=" + maxPageNo + "&pageSize=" + pageSize)
        };
        $("#" + idElement).html(Mustache.render(paginateTemplate, view));

        $(".page-action").click(function(e) {//单击前一页，后一页时的动作
            e.preventDefault();
            $("#" + idElement + " .pageNo").val($(this).attr("data-target"));
            var targetUrl  = $(this).attr("data-url");
            if(targetUrl != '') {
                $.ajax({
                    url : targetUrl,
                    success: function (result) {
                        if (callback) {
                            callback(result, url);
                        }
                    }
                })
            }
        })
    }

    function renderSimplePage(url, total, pageNo, pageSize, currentSize, idElement, callback) {
        var maxPageNo = Math.ceil(total / pageSize);
        var paramStartChar = url.indexOf("?") > 0 ? "&" : "?";
        var from = (pageNo - 1) * pageSize + 1;
        var view = {
            from: from > total ? total : from,
            to: (from + currentSize - 1) > total ? total : (from + currentSize - 1),
            total : total,
            pageNo : pageNo,
            maxPageNo : maxPageNo,
            nextPageNo: pageNo >= maxPageNo ? maxPageNo : (pageNo - 0 + 1),
            beforePageNo : pageNo == 1 ? 1 : (pageNo - 1),
            firstUrl : (pageNo == 1) ? '' : (url + paramStartChar + "pageNo=1&pageSize=" + pageSize),
            beforeUrl: (pageNo == 1) ? '' : (url + paramStartChar + "pageNo=" + (pageNo - 1) + "&pageSize=" + pageSize),
            nextUrl : (pageNo >= maxPageNo) ? '' : (url + paramStartChar + "pageNo=" + (pageNo - 0 + 1) + "&pageSize=" + pageSize),
            lastUrl : (pageNo >= maxPageNo) ? '' : (url + paramStartChar + "pageNo=" + maxPageNo + "&pageSize=" + pageSize)
        };
        $("#" + idElement).html(Mustache.render(simplePaginateTemplate, view));

        $(".page-action-simple").click(function(e) {
            e.preventDefault();
            $("#" + idElement + " .pageNo").val($(this).attr("data-target"));
            var targetUrl  = $(this).attr("data-url");
            if(targetUrl != '') {
                $.ajax({
                    url : targetUrl,
                    success: function (result) {
                        if (callback) {
                            callback(result, url);
                        }
                    }
                })
            }
        })
    }
</script>
