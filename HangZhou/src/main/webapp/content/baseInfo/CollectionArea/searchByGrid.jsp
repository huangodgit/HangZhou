<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
    <title>网格查询</title>
    <s:include value="/common/include.jsp"></s:include>
    <script src="${pageContext.request.contextPath}/js/GeoUtils.js"></script>
</head>


<body>
<div class="page-content" id="enterpriseAdd">
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <div>
                <form id="enterpriseAddForm" class="form-horizontal" role="form"
                      method="post" action="">
                    <input type="hidden" id="areaId" value='<s:property value="id"/>'/>
                    <input type="hidden" id="pointSet" name="pointSet"
                           class="col-xs-10" value='<s:property value="pointSet"/>'/>
                    <div class="table-responsive col-xs-6" style="float: left;">
                        <ul class="nav nav-tabs padding-12  tab-color-blue "
                            id="projecttab">
                            <li class="active"><a data-toggle="tab" href="#projectList">项目信息</a></li>

                            <li class="" id="enterprisestab"><a data-toggle="tab"
                                                                href="#enterprisesList">企业信息</a></li>


                        </ul>
                        <div class="tab-content" style="overflow: auto; height: 450px;">
                            <div id="projectList" class="tab-pane active">
                                <table id="sample-table-2"
                                       class="table table-striped table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <th style="width: 90px">序号</th>
                                        <th>项目名称</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>

                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                            <div id="enterprisesList" class="tab-pane">

                                <table id="sample-table-3"
                                       class="table table-striped table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <th style="width: 92px">序号</th>
                                        <th>企业名称</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>

                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6 no-padding-right no-padding-left"
                         style="float: right;">
                        <style type="text/css">
                            .anchorBL {
                                display: none;
                            }
                        </style>
                        <div id="allmap" class="col-xs-12"
                             style="float: right; height: 485px;"></div>
                    </div>
                    <div class="col-xs-12 no-padding">
                        <div class="clearfix form-actions">
                            <div class="col-mx-offset-3 col-mx-9 pull-right">
                                <button id="relevance" class="btn btn-info" type="submit">
                                    <i class="icon-ok bigger-110"></i> 全部关联
                                </button>
                                &nbsp;
                                <button class="btn" type="reset">
                                    <i class="icon-undo bigger-110"></i> 重置
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <!-- PAGE CONTENT ENDS -->
        </div>
        <!-- /.col -->
    </div>
    <!-- /.row -->
</div>
<!-- /.page-content -->


<script type="text/javascript">
    // 百度地图API功能
    var marker;
    var isMark = false;
    var map = new BMap.Map("allmap", {
        mapType: BMAP_HYBRID_MAP
    });
    //map.centerAndZoom(new BMap.Point(119.470313, 29.957016),20);
    map.addControl(new BMap.NavigationControl());
    map.setMinZoom(8);
    map.setMaxZoom(20);
    map.enableScrollWheelZoom();
    $('#map div.anchorBL').hide();//隐藏百度地图logo

    var pointArray = document.getElementById("pointSet").value;
    var first = pointArray.indexOf("[");
    var last = pointArray.lastIndexOf("]");
    var polygonPoint = pointArray.substring(first + 1, last);
    polygonPoint = polygonPoint.replace(/],/g, ";");
    polygonPoint = polygonPoint.replace(/\[/g, "");
    //alert(polygonPoint);
    var polygon = new BMap.Polygon(polygonPoint, {
        strokeColor: "red",
        fillColor: "red",
        strokeWeight: 2,
        strokeOpacity: 0.5
    }); //创建多边形
    map.addOverlay(polygon);
    var bounds = polygon.getBounds();

    var sw = bounds.getSouthWest();
    var ne = bounds.getNorthEast();
    var lngSpan = (sw.lng + ne.lng) / 2;
    var latSpan = (ne.lat + sw.lat) / 2;
    //map.centerAndZoom(new BMap.Point(lngSpan, latSpan), 14);
    var p = [bounds.getSouthWest(), bounds.getNorthEast()]
    map.setViewport(p);

    // 编写自定义函数,创建标注
    function addMarker(point) {
        var marker = new BMap.Marker(point);
        map.addOverlay(marker);
    }

    var maincontent_datatable = null;
    var projectList = new Array();
    var enterpriseList = new Array();
    jQuery(function ($) {
        sendAjax("BaseInfo/Town/getAreaData?type=noid", "", function (json) {
            $('#element_id').cxSelect({
                url: json,
                selects: ['town', 'village'],
                firstValue: ''
            });
        });
        /* 	$('#element_id').cxSelect({
                  url: 'common/areaData.json',   // 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件
                  selects: ['town', 'village'],
                  firstValue: ''
                });  */
        $('[data-rel=tooltip]').tooltip();
        maincontent_datatable = $('#sample-table-2')
            .dataTable(
                {
                    "oLanguage": { // 汉化
                        "sProcessing": "正在加载数据...",
                        "sLengthMenu": "显示_MENU_条 ",
                        "sZeroRecords": "没有您要搜索的内容",
                        "sInfo": "",
                        "sInfoEmpty": "记录数为0",
                        "sInfoFiltered": "(全部记录数 _MAX_  条)",
                        "sInfoPostFix": "",
                        "sSearch": "搜索",
                        "sUrl": "",
                        "oPaginate": {
                            "sFirst": "第一页",
                            "sPrevious": " 上一页 ",
                            "sNext": " 下一页 ",
                            "sLast": " 最后一页 "
                        }
                    },
                    "aoColumns": [{
                        "mData": "id",
                        "mRender": function (data, type, full) {
                            return data;
                        }
                    }, {
                        "mData": "projectName",
                        "mRender": function (data, type, full) {
                            return data;
                        }
                    },
                        {
                            "mData": "id",
                            "mRender": function (data, type, full) {
                                var strhtml = "";
                                if (full.attribute) {
                                    strhtml = "<a class=\"blue tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"取消关联\" onclick=\"canclerelation('BaseInfo/Project/canclerelation?id=" + data + "&areaId=" + $("#areaId").val() + "');\"> <i class=\" icon-remove bigger-130\"></i> </a>";
                                } else {
                                    strhtml = "<a class=\"blue tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"关联\" onclick=\"relation('BaseInfo/Project/relation?id=" + data + "&areaId=" + $("#areaId").val() + "');\"> <i class=\" icon-ok bigger-130\"></i> </a>";
                                }
                                return "<div class=\"action-buttons\">" + strhtml + "</div>";
                            }
                        }

                    ],
                    "bJQueryUI": true,
                    "bPaginate": false,// 分页按钮
                    "bFilter": false,// 搜索栏
                    "bLengthChange": false,// 每行显示记录数
                    "iDisplayLength": 10,// 每页显示行数
                    "bSort": true,// 排序
                    //"aLengthMenu": [[50,100,500,1000,10000], [50,100,500,1000,10000]],//定义每页显示数据数量
                    //"iScrollLoadGap":400,//用于指定当DataTable设置为滚动时，最多可以一屏显示多少条数据
                    //"aaSorting": [[4, "desc"]],
                    "bInfo": true,// Showing 1 to 10 of 23 entries 总记录数没也显示多少等信息
                    "bWidth": true,
                    //"sScrollY": "62%",
                    //"sScrollX": "210%",
                    "bScrollCollapse": true,
                    //"sPaginationType" : "two_button", // 分页，一共两种样式 另一种为two_button // 是datatables默认
                    "bProcessing": false,
                    "bServerSide": true,
                    "bDestroy": true,
                    "bSortCellsTop": true,
                    "sAjaxSource": 'BaseInfo/Project/listAllForCollectionArea?swlng='
                        + sw.lng
                        + "&swlat="
                        + sw.lat
                        + "&nelng="
                        + ne.lng
                        + "&nelat="
                        + ne.lat,
                    "fnServerData": function (sSource, aoData,
                                              fnCallback) {
                        var aa = $("#maincontent_dataserchform")
                            .serializeArray();
                        aa.push({
                            'name': 'aoData',
                            'value': JSON.stringify(aoData)
                        });
                        $
                            .ajax({
                                "type": 'post',
                                "url": sSource,
                                "dataType": "json",
                                "data": aa,
                                "success": function (resp) {
                                    var x, y;
                                    var marker;
                                    var enterpriseIcon = new BMap.Icon(
                                        "images/enterprise.png",
                                        new BMap.Size(32,
                                            32));

                                    $.each(
                                        resp,
                                        function (
                                            index) {
                                            x = resp[index].longitude;
                                            y = resp[index].latitude;
                                            var pt = new BMap.Point(
                                                x,
                                                y);
                                            var result = BMapLib.GeoUtils
                                                .isPointInPolygon(
                                                    pt,
                                                    polygon);
                                            if (result == true) {
                                                projectList
                                                    .push(resp[index]);
                                                marker = new BMap.Marker(
                                                    pt,
                                                    {
                                                        icon: enterpriseIcon
                                                    }); // 创建标注
                                                map
                                                    .addOverlay(marker); // 将标注添加到地图中
                                            }

                                        });
                                    //格式转换
                                    var myJSONText = JSON
                                        .stringify(projectList);
                                    var json = "{\"sEcho\":"
                                        + resp.sEcho
                                        + ",\"iTotalDisplayRecords\":"
                                        + projectList.length
                                        + ",\"iTotalRecords\":"
                                        + projectList.length
                                        + ",\"aaData\":"
                                        + myJSONText + "}";
                                    var jsondata = eval("("
                                        + json + ")");
                                    fnCallback(jsondata);
                                },
                                "error": function (data,
                                                   status, e) {
                                    fnCallback(data);
                                }
                            });
                    }
                });

        $('table th input:checkbox').on(
            'click',
            function () {
                var that = this;
                $(this).closest('table').find(
                    'tr > td:first-child input:checkbox').each(
                    function () {
                        this.checked = that.checked;
                        $(this).closest('tr').toggleClass(
                            'selected');
                    });

            });

        $('[data-rel="tooltip"]').tooltip({
            placement: tooltip_placement
        });
        maincontent_datatable = $('#sample-table-3')
            .dataTable(
                {
                    "oLanguage": { // 汉化
                        "sProcessing": "正在加载数据...",
                        "sLengthMenu": "显示_MENU_条 ",
                        "sZeroRecords": "没有您要搜索的内容",
                        "sInfo": "",
                        "sInfoEmpty": "记录数为0",
                        "sInfoFiltered": "(全部记录数 _MAX_  条)",
                        "sInfoPostFix": "",
                        "sSearch": "搜索",
                        "sUrl": "",
                        "oPaginate": {
                            "sFirst": "第一页",
                            "sPrevious": " 上一页 ",
                            "sNext": " 下一页 ",
                            "sLast": " 最后一页 "
                        }
                    },
                    "aoColumns": [{
                        "mData": "id",
                        "mRender": function (data, type, full) {
                            return data;
                        }
                    }, {
                        "mData": "name",
                        "mRender": function (data, type, full) {
                            return data;
                        }
                    },
                        {
                            "mData": "id",
                            "mRender": function (data, type, full) {
                                var strhtml = "";
                                if (full.attribute) {
                                    strhtml += "<a class=\"blue tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"取消关联\" onclick=\"canclerelation('BaseInfo/Enterprise/canclerelation?id=" + data + "&areaId=" + $("#areaId").val() + "');\"> <i class=\" icon-remove bigger-130\"></i> </a>";
                                } else {
                                    strhtml += "<a class=\"blue tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"关联\" onclick=\"relation('BaseInfo/Enterprise/relation?id=" + data + "&areaId=" + $("#areaId").val() + "');\"> <i class=\" icon-ok bigger-130\"></i> </a>";
                                }
                                return "<div class=\"action-buttons\">" + strhtml + "</div>";
                            }
                        }

                    ],
                    "bJQueryUI": true,
                    "bPaginate": false,// 分页按钮
                    "bFilter": false,// 搜索栏
                    "bLengthChange": false,// 每行显示记录数
                    "iDisplayLength": 10,// 每页显示行数
                    "bSort": true,// 排序
                    //"aLengthMenu": [[50,100,500,1000,10000], [50,100,500,1000,10000]],//定义每页显示数据数量
                    //"iScrollLoadGap":400,//用于指定当DataTable设置为滚动时，最多可以一屏显示多少条数据
                    //"aaSorting": [[4, "desc"]],
                    "bInfo": true,// Showing 1 to 10 of 23 entries 总记录数没也显示多少等信息
                    "bWidth": true,
                    //"sScrollY": "62%",
                    //"sScrollX": "210%",
                    "bScrollCollapse": true,
                    //"sPaginationType" : "two_button", // 分页，一共两种样式 另一种为two_button // 是datatables默认
                    "bProcessing": false,
                    "bServerSide": true,
                    "bDestroy": true,
                    "bSortCellsTop": true,
                    "sAjaxSource": 'BaseInfo/Enterprise/listAllForCollectionArea?swlng='
                        + sw.lng
                        + "&swlat="
                        + sw.lat
                        + "&nelng="
                        + ne.lng
                        + "&nelat="
                        + ne.lat
                        + "&gridid"
                        + $("#gridid").val(),
                    "fnServerData": function (sSource, aoData,
                                              fnCallback) {
                        var aa = $("#maincontent_dataserchform")
                            .serializeArray();
                        aa.push({
                            'name': 'aoData',
                            'value': JSON.stringify(aoData)
                        });
                        $
                            .ajax({
                                "type": 'post',
                                "url": sSource,
                                "dataType": "json",
                                "data": aa,
                                "success": function (resp) {
                                    var x, y;
                                    var marker;
                                    var enterpriseIcon = new BMap.Icon(
                                        "images/enterprise.png",
                                        new BMap.Size(32,
                                            32));

                                    $.each(
                                        resp,
                                        function (
                                            index) {
                                            x = resp[index].longitude;
                                            y = resp[index].latitude;
                                            var pt = new BMap.Point(
                                                x,
                                                y);
                                            var result = BMapLib.GeoUtils
                                                .isPointInPolygon(
                                                    pt,
                                                    polygon);
                                            if (result == true) {
                                                enterpriseList
                                                    .push(resp[index]);
                                                marker = new BMap.Marker(
                                                    pt,
                                                    {
                                                        icon: enterpriseIcon
                                                    }); // 创建标注
                                                map
                                                    .addOverlay(marker); // 将标注添加到地图中
                                            }

                                        });
                                    //格式转换
                                    var myJSONText = JSON
                                        .stringify(enterpriseList);
                                    var json = "{\"sEcho\":"
                                        + resp.sEcho
                                        + ",\"iTotalDisplayRecords\":"
                                        + enterpriseList.length
                                        + ",\"iTotalRecords\":"
                                        + enterpriseList.length
                                        + ",\"aaData\":"
                                        + myJSONText + "}";
                                    var jsondata = eval("("
                                        + json + ")");
                                    fnCallback(jsondata);
                                },
                                "error": function (data,
                                                   status, e) {
                                    fnCallback(data);
                                }
                            });
                    }
                });

        function tooltip_placement(context, source) {
            var $source = $(source);
            var $parent = $source.closest('table');
            var off1 = $parent.offset();
            var w1 = $parent.width();

            var off2 = $source.offset();
            var w2 = $source.width();

            if (parseInt(off2.left) < parseInt(off1.left)
                + parseInt(w1 / 2))
                return 'right';
            return 'left';
        }
    });

    function viewMsg(id, name, url) {
        layer.open({
            type: 2,
            //skin: 'layui-layer-lan',
            title: name,
            fix: false,
            shadeClose: true,
            maxmin: false,
            area: ['800px', '500px'],
            content: url
        });
    }

    function del(url) {
        ui_confirm("确定要删除吗？", function () {
            sendAjax(url, " ", function (json) {
                if (json.status) {
                    ui_info(json.info);
                    maincontent_datatable.fnReloadAjax();
                } else {
                    ui_error(json.info);
                }
            });
        });
    }

    function relation(url) {
        ui_confirm("确定要关联吗？", function () {
            sendAjax(url, " ", function (json) {
                if (json.status) {
                    ui_info(json.info);
                    //maincontent_datatable.fnReloadAjax();
                    setTimeout("window.location = window.location.href;", 1000);

                } else {
                    ui_error(json.info);
                }
            });
        });
    }

    function canclerelation(url) {
        ui_confirm("确定要取消关联吗？", function () {
            sendAjax(url, " ", function (json) {
                if (json.status) {
                    ui_info(json.info);
                    //maincontent_datatable.fnReloadAjax();
                    setTimeout("window.location = window.location.href;", 1000);
                } else {
                    ui_error(json.info);
                }
            });
        });
    }

    function replaceAll(json) {
        if (json != null) {
            json = json.replace(/\{\[/g, "{");
            json = json.replace(/\]\}\{/g, "},{");
            json = json.replace(/\]\}\]\}/g, "}]}");
            json = json.replace(/\]\}\]/g, "}]");
        }
        return json;
    }

    function searchMaincontentDatatable() {
        if (maincontent_datatable) {
            maincontent_datatable.fnReloadAjax();
        }
    }

    /* $(function() {
        $arr = $('#sample-table-2_wrapper>.row:eq(1)>.col-sm-6:eq(1)')
                .addClass("col-sm-12");
    }) */

    function btnAjax() {
        var $btn = $("#relevance");

        $btn.bind("click", function () {
            var projectIds = "";
            var enterpriseIds = "";
            $.each(projectList, function (index) {
                if (index == 0) {
                    projectIds = projectList[index].id;
                } else {
                    projectIds += "," + projectList[index].id;
                }

            });
            $.each(enterpriseList, function (index) {
                if (index == 0) {
                    enterpriseIds = enterpriseList[index].id;
                } else {
                    enterpriseIds += "," + enterpriseList[index].id;
                }

            });

            /* var projectArrayJsonStr = JSON.stringify(projectList);
            var enterpriseArrayJsonStr = JSON.stringify(enterpriseList); */
            $.ajax({
                type: "post",
                url: "BaseInfo/CollectionArea/areaForRelevance",
                data: {
                    id: $("#areaId").val(),
                    projectIds: projectIds,
                    enterpriseIds: enterpriseIds
                },
                dataType: "json",
                //traditional:true,
                success: function (data) {
                    //var d = eval("("+data+")");
                    //alert("关联成功")
                    if (data.status) {
                        ui_info(data.info);
                        setTimeout("window.location = window.location.href;", 1000);
                    } else {
                        ui_error(data.info);
                    }
                    //ui_error("关联成功！");
                },
                error: function () {
                    //alert("关联错误！");
                    ui_error("关联失败！");
                }
            });
            return false;
        });

    }

    $(document).ready(function () {
        btnAjax();
    })
</script>

</body>
</html>