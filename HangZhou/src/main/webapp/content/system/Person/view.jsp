<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>字典详情</title>
<s:include value="/common/include.jsp"></s:include>
<link rel="stylesheet" type="text/css"
	href="css/validate-tip-bottom.css" />
</head>

<body>

	<div class="page-content">

		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>
					<form id="dictEditForm" class="form-horizontal" role="form"
						method="post" action="System/Person/save">
						<div class="col-xs-12 no-padding"
							style="margin-top: 40px; margin-bottom: 40px">
							<input type="hidden" id="id" name="id"
								value='<s:property value="id"/>'>
								
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> ID </label>
								<div class="col-xs-6">
									<input type="text" id="name" placeholder="输入名称" name="name"
										class="col-xs-12" value='<s:property value="id"/>' readonly="readonly" />
								</div>
							</div>

							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 姓名 </label>
								<div class="col-xs-6">
									<input type="text" id="name" placeholder="输入名称" name="name"
										class="col-xs-12" value='<s:property value="name"/>' readonly="readonly" />
								</div>
							</div>
							
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 性别 </label>
								<div class="col-xs-6">
									<input type="text" id="name" placeholder="输入名称" name="name"
										class="col-xs-12" value='<s:property value="sex"/>' readonly="readonly" />
								</div>
							</div>
							
							
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 年龄 </label>
								<div class="col-xs-6">
									<input type="text" id="name" placeholder="输入名称" name="name"
										class="col-xs-12" value='<s:property value="age"/>' readonly="readonly" />
								</div>
							</div>
							
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 职业 </label>
								<div class="col-xs-6">
									<input type="text" id="name" placeholder="输入名称" name="name"
										class="col-xs-12" value='<s:property value="occupation"/>' readonly="readonly" />
								</div>
							</div>
							
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 卡号 </label>
								<div class="col-xs-6">
									<input type="text" id="name" placeholder="输入名称" name="name"
										class="col-xs-12" value='<s:property value="persononetoone.cardNumber"/>' readonly="readonly" />
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
		var data = $("#status").attr("data");
		if (data == "true") {
			//$("#flagT").checked = true;
			$("#flagT").prop("checked", true);
		} else {
			//$("#flagF").checked = true;
			$("#flagF").prop("checked", true);
		}
	
			dictEditValidator = $('#dictEditForm')
					.validate(
							{
								focusInvalid : false,
								rules : {
									name : {
										required : true
									},
									seqno : {
										required : true
									},
									code : {
										required : true,
										code : true
									}
								},
								messages : {
									name : {
										required : '<div class="tip-box"><p>请输入名称</p></div>'
									},
									seqno : {
										required : '<div class="tip-box"><p>请输入排序位</p></div>'
									},
									code : {
										required : '<div class="tip-box"><p>请输入代码</p></div>'
									}
								},
								errorPlacement : function(error, element) {
									if (element.next().is("span")) {
										element.parent().after(error);
									} else {
										error.appendTo(element.parent());
									}
								},
								submitHandler : function(form) {
									sendAjax(
											"System/Person/save",
											$(form).serialize(),
											function(json) {
												if (json.status) {
													parent.ui_info(json.info);
													var index = parent.layer
															.getFrameIndex(window.name); //先得到当前iframe层的索引
													//parent.maincontent_datatable.fnReloadAjax();
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
