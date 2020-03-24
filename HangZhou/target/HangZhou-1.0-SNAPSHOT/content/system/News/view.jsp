<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>新闻详情</title>
    <s:include value="/common/include.jsp"></s:include>
    <link rel="stylesheet" type="text/css"
          href="css/validate-tip-bottom.css"/>
</head>

<body>

<div class="page-content">

    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <div>
                <form id="newsesInsertForm" class="form-horizontal" role="form"
                      method="post" action="System/News/save">
                    <div class="col-xs-12 no-padding"
                         style="margin-top: 40px; margin-bottom: 40px">
                        <input type="hidden" id="id" name="id"
                               value='<s:property value="id"/>'>
                        <%--新闻--%>
                        <div class="form-group">
                            <div class="col-xs-1"></div>
                            <label class="col-xs-2 control-label no-padding-right">新闻类型</label>
                            <div class="col-xs-6">
                                <input type="text" id="dictName" value='<s:property value="type"/>' class="col-xs-12"
                                       readonly="readonly"/>
                                <input type="hidden" id="dictId" value='<s:property value="dict.id"/>' class="col-xs-10"
                                       readonly="readonly"/>

                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-xs-1"></div>
                            <label class="col-xs-2 control-label no-padding-right" for="content"> 内容 </label>
                            <div class="col-xs-6">
                                <input type="text" id="content" placeholder="请输入内容" name="content"
                                       class="col-xs-12" value='<s:property value="content"/>' readonly="readonly"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-xs-1"></div>
                            <label class="col-xs-2 control-label no-padding-right"> 访问量 </label>
                            <div class="col-xs-6">
                                <input type="text" id="pageView" name="founder"
                                       class="col-xs-12" value='<s:property value="pageView"/>'/>
                            </div>
                        </div>


                    </div>

                    <div class="col-xs-12 no-padding">
                        <div class="clearfix form-actions">
                            <div class="col-mx-9 pull-right">
                                <a href="javascript:void(0)" class="btn btn-info"
                                   onclick="closeWindow()"> <i class="icon-ok bigger-110"></i>
                                    确定
                                </a>
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
    function closeWindow() {
        var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
        parent.maincontent_datatable.fnReloadAjax();
        parent.layer.close(index); //再执行关闭
    }

    var data = $("#state").attr("data");
    if (data == 1) {
        $("#stateT").prop("checked", true);
    } else {
        $("#stateF").prop("checked", true);
    }
    ;
    var businessEditValidator;
    jQuery(function ($) {
        sendAjax("BaseInfo/Town/getAreaData", "", function (json) {
            $('#element_id').cxSelect({
                //url: 'common/areaData3.json',   // 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件
                url: json,
                selects: ['town', 'village'],
                firstValue: ''
            });
        });

        businessEditValidator = $('#newsesInsertForm')
            .validate(
                {
                    focusInvalid: false,
                    rules: {
                        type: {
                            required: true
                        },
                        content: {
                            required: true
                        }
                    },
                    messages: {
                        type: {
                            required: '<div class="tip-box"><p>请选择新闻类型</p></div>'
                        },
                        content: {
                            required: '<div class="tip-box"><p>请输入新闻内容</p></div>'
                        }
                    },
                    errorPlacement: function (error, element) {
                        if (element.next().is("span")) {
                            element.parent().after(error);
                        } else {
                            error.appendTo(element.parent());
                        }
                    },
                    submitHandler: function (form) {
                        sendAjax(
                            "System/News/save",
                            $(form).serialize(),
                            function (json) {
                                if (json.state) {
                                    parent.ui_info(json.info);
                                    var index = parent.layer
                                        .getFrameIndex(window.name); //先得到当前iframe层的索引
                                    parent.window.location = parent.window.location.href;
                                    parent.layer.close(index); //再执行关闭
                                } else {
                                    ui_error(json.info);
                                }
                            });
                        return false;
                    }
                });
        $('[data-rel=tooltip]').tooltip();
    });


</script>

</body>
</html>
