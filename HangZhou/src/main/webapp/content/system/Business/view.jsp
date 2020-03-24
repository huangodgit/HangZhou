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
					<form id="businessEditForm" class="form-horizontal" role="form"
						method="post" action="System/Business/save">
						<div class="col-xs-12 no-padding"
							style="margin-top: 40px; margin-bottom: 40px">
							<input type="hidden" id="id" name="id"
								value='<s:property value="id"/>'>
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"> 名称 </label>
								<div class="col-xs-6">
									<input type="text" id="name" placeholder="请输入名称" name="name"
										class="col-xs-12" value='<s:property value="name"/>' readonly="readonly" />
								</div>
							</div>

							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"> 公司 </label>
								<div class="col-xs-6">
									<input type="text" id="company" placeholder="请输入公司" name="company"
										   class="col-xs-12" value='<s:property value="company"/>' readonly="readonly" />
								</div>
							</div>

							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"> 电话 </label>
								<div class="col-xs-6">
									<input type="text" id="tel" placeholder="请输入电话" name="tel"
										   class="col-xs-12" value='<s:property value="tel"/>' readonly="readonly" />
								</div>
							</div>

							<%--特殊情况--%>
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"> 时间 </label>
								<div class="col-xs-6">
									<input type="text" id="time"
										   name="time"
										   class="col-xs-12" value='<s:property value="time"/>' readonly="readonly" />
								</div>
							</div>

							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"> 状态</label>
								<div class="col-xs-6" id="state"
									data='<s:property value="state"/>'>
									<div class="col-xs-6" style="margin-top: 1px; font-size: 14px">
										<label><input type="radio" value="true" id="stateT"
											name="flag" disabled>有效</label>
									</div>
									<div class="col-xs-6" style="margin-top: 1px; font-size: 14px">
										<label><input type="radio" value="false" id="stateF"
											name="flag" disabled>无效</label>
									</div>
								</div>
							</div>

							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"> 情况描述</label>
								<div class="col-xs-6">
									<input type="text" id="description" placeholder="请输入情况描述" name="description"
										class="col-xs-12" value='<s:property value="description"/>' readonly="readonly" />
								</div>
							</div>

							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"> 创建人 </label>
								<div class="col-xs-6">
									<input type="text" id="founder" placeholder="请输入创建人" name="founder"
										class="col-xs-12" value='<s:property value="founder"/>' readonly="readonly" />
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
		};
		var businessEditValidator;
		jQuery(function($) {
			sendAjax("BaseInfo/Town/getAreaData", "", function(json) {
				$('#element_id').cxSelect({
					//url: 'common/areaData3.json',   // 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
					url : json,
					selects : [ 'town', 'village' ],
					firstValue : ''
				});
			});

			businessEditValidator = $('#businessEditForm')
					.validate(
							{
								focusInvalid : false,
								rules : {
									name : {
										required : true
									},
									company : {
										required : true
									},
									tel : {
										required : true,
									},
									time : {
										required : false,
									},
									state : {
										required : true,
									},
									description : {
										required : true,
									},
									founder : {
										required : true,
									}
								},
								messages : {
									name : {
										required : '<div class="tip-box"><p>请输入名称</p></div>'
									},
									company : {
										required : '<div class="tip-box"><p>请输入公司</p></div>'
									},
									tel : {
										required : '<div class="tip-box"><p>请输入电话</p></div>'
									},
									time : {
										required : '<div class="tip-box"><p>请输入时间</p></div>'
									},
									description : {
										required : '<div class="tip-box"><p>请输入情况描述</p></div>'
									},
									founder : {
										required : '<div class="tip-box"><p>请输入创建人</p></div>'
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
											"System/Business/save",
											$(form).serialize(),
											function(json) {
												if (json.state) {
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
