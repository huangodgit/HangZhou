<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>修改</title>
<s:include value="/common/include.jsp"></s:include>
<s:include value="/common/include-ueditor.jsp" />
<link rel="stylesheet" type="text/css" href="css/validate-tip.css" />
</head>
<body>
	<div class="page-content">
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>
					<form id="villageLivelihoodNewsAddForm" class="form-horizontal"
						role="form" method="post"
						action="News/News/save">
						<div class="col-xs-12 no-padding-right">
							<div class="form-group">
									<label class="col-xs-2 control-label no-padding-right" for="form-field-1"> 信息类型 </label>
								<div class="col-xs-2">
									<div class="col-xs-5 no-padding">
										<s:select name="newsType" listKey="name" listValue="name" disabled="true" list="getDictList('columnManagemen')" headerKey="" headerValue="--请选择--"/>
									</div>
								</div>
								<div class="col-xs-6">
									<label class="col-xs-2 control-label no-padding-right" for="form-field-1"> 标题</label>
									<div class="col-xs-9">
										<input type="text"  placeholder="输入标题" name="title" class="col-xs-10" disabled="true" value='<s:property value="title"/>'/>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 发布人 </label>
								<div class="col-xs-8">
									<input type="text"  placeholder="输入发布人"
										name="operator" class="col-xs-10" disabled="true" value='<s:property value="operator"/>' />
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 信息内容 </label>
								<table width="100%" border="0" cellspacing="0"
									class="input_table">
									<tr>
										<td width="" height="64" class="input_titletext"></td>
										<td style="padding-bottom: 10px; padding-top: 10px;">
											<div class="text_daoruF">
												<script type="text/plain" id="editor"
													style="width:100%;height:450px;">
												<s:property value="content" escape="false"/>
										</script>
											</div>
										</td>
									</tr>
								</table>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right" for="form-field-1"> 处理结果 </label>
								<div class="col-xs-8">
										<textarea class="form-control limited" id="editor1"
										maxlength="600" rows="5" name="handleResult" disabled="true"><s:property value="handleResult"/></textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1">处理时间</label>
								<div class="col-xs-8">
								    <div class="input-group">
										<input class="form-control date-picker" id="id-date-picker-2" disabled="true"
											type="text" data-date-format="yyyy-mm-dd" name="handleTime" value='<s:property value="handleTime"/>'/>
										<span class="input-group-addon"> <i
											class="icon-calendar bigger-110"></i>
										</span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right" for="form-field-1"> 处理人 </label>
								<div class="col-xs-8">
									<input type="text" id="form-field-1" disabled="true" name="handleOperator" class="col-xs-10"  value="<s:property value='handleOperator'/>"/>
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

	<!-- inline scripts related to this page -->

	<script type="text/javascript">
	function closeWindow() {
		var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.maincontent_datatable.fnReloadAjax();
		parent.layer.close(index); //再执行关闭  
	}
	jQuery.validator.addMethod("newsSource", function(value, element) {
		if(value==""){
			return false;
		}else{
			return true;
		}
		}, '<div class="tip-box"><p>请选择信息来源</p></div>');
	
		var ue = UE.getEditor('editor', {
			autoHeightEnabled:false,
			'textarea' : 'content',
			readonly:true,
			toolbars:[]
		});
		var nvillageAddValidator;
		jQuery(function($) {

			/* $('#element_id').cxSelect({
				  url: 'common/areaData3.json',   // 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
				  selects: ['town', 'village'],
				  firstValue: ''
			}); */

			nvillageAddValidator = $('#villageLivelihoodNewsAddForm')
					.validate(
							{
								focusInvalid : false,
								rules : {
									title : {
										required : true
									},
									operator:{
										required : true
									}
								},

								messages : {
									title : {
										required : '<div class="tip-box"><p>请输入标题</p></div>'
									},
									operator : {
									    required : '<div class="tip-box"><p>请输入发布人</p></div>'
								    }
								},
								errorPlacement: function (error, element) { //指定错误信息位置
									if (element.is(':checkbox')) { //如果是radio或checkbox
										$(".inline").parent().after(error);
									} else {
										error.appendTo(element.parent().parent());
									}
								},
								submitHandler : function(form) {
									sendAjax(
											"News/News/save",
											$(form).serialize(),
											function(json) {
												if (json.status) {
													parent.ui_info(json.info);
													var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
													parent.maincontent_datatable.fnReloadAjax();
													parent.layer.close(index); //再执行关闭  
												} else {
													ui_error(json.info);
												}
											});
									return false;
								}
							});
		});
	</script>

</body>

</html>
