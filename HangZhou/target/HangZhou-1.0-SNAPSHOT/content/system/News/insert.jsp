<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>新闻新增</title>
    <s:include value="/common/include.jsp"></s:include>
    <link rel="stylesheet" type="text/css" href="css/validate-tip-bottom.css"/>
</head>

<body>

<div class="page-content">

    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->
            <div>
                <form id="newsesInsertForm" class="form-horizontal"
                      role="form" method="post"
                      action="System/News/save">
                    <div class="col-xs-12 no-padding" style="margin-top:40px;margin-bottom:40px">

                        <%--新闻--%>
                        <div class="form-group">
                            <div class="col-xs-1"></div>
                            <label class="col-xs-2 control-label no-padding-right">新闻类型</label>
                            <div class="col-xs-6">
                                <input type="text" id="dictName" placeholder="选择新闻类型"
                                       name="type" class="col-xs-11" readonly="readonly"/>
                                <input type="hidden" id="dictId" name="dict.id" class="col-xs-10" readonly="readonly"/>
                                <a class="green tooltip-info col-xs-1 "
                                   data-rel="tooltip" data-placement="top"
                                   style="padding-top: 5px;" title="添加"
                                   onclick="showLayerDialogXY('新闻类型列表','System/Dict/listForSelect','94%','90%','3%','3%');">
                                    <i class="icon-plus-sign light-orange bigger-130"></i>
                                </a>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-xs-1"></div>
                            <label class="col-xs-2 control-label no-padding-right"
                                   for="content"> 内容 </label>
                            <div class="col-xs-6">
                                <input type="text" id="content" placeholder="请输入内容"
                                       name="content" class="col-xs-12"/>
                            </div>
                        </div>
                </form>

                <div class="col-xs-12 no-padding">
                    <div class="clearfix form-actions">
                        <div class="col-md-offset-3 col-md-9 pull-right">
                            <button class="btn btn-info" type="submit" form="newsesInsertForm">
                                <i class="icon-ok bigger-110"></i> 保存
                            </button>

                            &nbsp; &nbsp; &nbsp;
                            <button class="btn" type="reset">
                                <i class="icon-undo bigger-110"></i> 重置
                            </button>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /.col -->
        </div>
        <!-- /.row -->
    </div>
    <!-- PAGE CONTENT ENDS -->

    <script type="text/javascript">
        var newsAddValidator;
        jQuery(function ($) {
            newsAddValidator = $('#newsesInsertForm')
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
                                    if (json.status) {
                                        parent.ui_info(json.info);
                                        var index = parent.layer
                                            .getFrameIndex(window.name); //先得到当前iframe层的索引
                                        parent.maincontent_datatable
                                            .fnReloadAjax();
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
