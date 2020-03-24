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
						method="post" action="System/Dict/save">
						<div class="col-xs-12 no-padding"
							style="margin-top: 40px; margin-bottom: 40px">
							<input type="hidden" id="id" name="id"
								value='<s:property value="id"/>'>
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1">所属类型</label>
								<div class="col-xs-6">
									<input type="text" id="dictName" placeholder="选择所属类型"
										name="dictName" class="col-xs-11" readonly="readonly"
										value='<s:property value="dictType.name"/>' /> <input
										type="hidden" id="dictId" name="dictId" class="col-xs-10"
										readonly="readonly" value='<s:property value="dictType.id"/>' />
								</div>
							</div>

							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 名称 </label>
								<div class="col-xs-6">
									<input type="text" id="name" placeholder="输入名称" name="name"
										class="col-xs-12" value='<s:property value="name"/>' readonly="readonly" />
								</div>

							</div>
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 状态</label>
								<div class="col-xs-6" id="status"
									data='<s:property value="flag"/>'>
									<div class="col-xs-6" style="margin-top: 1px; font-size: 14px">
										<label><input type="radio" value="true" id="flagT"
											name="flag" disabled>有效</label>
									</div>
									<div class="col-xs-6" style="margin-top: 1px; font-size: 14px">
										<label><input type="radio" value="false" id="flagF"
											name="flag" disabled>无效</label>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 列表排序位</label>
								<div class="col-xs-6">
									<input type="text" id="seqno" placeholder="输入排序位" name="seqno"
										class="col-xs-12" value='<s:property value="seqno"/>' readonly="readonly" />
								</div>

							</div>
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 代码 </label>
								<div class="col-xs-6">
									<input type="text" id="code" placeholder="输入代码" name="code"
										class="col-xs-12" value='<s:property value="code"/>' readonly="readonly" />
								</div>
							</div>
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 备注</label>
								<div class="col-xs-6">
									<textarea class="form-control limited" id="editor1"
										maxlength="600" rows="5" name="remark" readonly="readonly"><s:property
											value="remark" /></textarea>
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
		jQuery.validator.addMethod("code", function(value, element) {
			var deferred = $.Deferred();//创建一个延迟对象
			$.ajax({
				url : "System/Dict/validateCode?validateCode="
						+ $("#code").val() + "&&dictId=" + $("#dictId").val()
						+ "&&validateId=" + $("#id").val(),
				async : false,//要指定不能异步,必须等待后台服务校验完成再执行后续代码
				dataType : "json",
				success : function(res) {
					var len = res.length;
					if (len > 0) {
						deferred.reject();
					} else {
						deferred.resolve();
					}
				}
			});
			//deferred.state()有3个状态:pending:还未结束,rejected:失败,resolved:成功
			return deferred.state() == "resolved" ? true : false;
		}, '<div class="tip-box"><p>代码已存在</p></div>');
		var dictEditValidator;
		jQuery(function($) {
			sendAjax("BaseInfo/Town/getAreaData", "", function(json) {
				$('#element_id').cxSelect({
					//url: 'common/areaData3.json',   // 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
					url : json,
					selects : [ 'town', 'village' ],
					firstValue : ''
				});
			});

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
											"System/Dict/save",
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
