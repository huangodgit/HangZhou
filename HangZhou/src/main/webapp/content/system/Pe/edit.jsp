<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>字典修改</title>
<s:include value="/common/include.jsp"></s:include>
<link rel="stylesheet" type="text/css" href="css/validate-tip-bottom.css" />
</head>

<body>

	<div class="page-content">

		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>
					<form id="dictEditForm" class="form-horizontal" role="form"
						method="post" action="System/Pe/save">
						<div class="col-xs-12 no-padding"
							style="margin-top: 40px; margin-bottom: 40px">
							<input type="hidden" id="id" name="id"
								value='<s:property value="id"/>'>
						</div>
                        
                        
                   
                        
                        							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 姓名 </label>
								<div class="col-xs-6">
									<input type="text" id="name" placeholder="输入名称"
										name="name" class="col-xs-12"
										value='<s:property value="name"/>' />
								</div>

							</div>
							
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 性别</label>
								<div class="col-xs-6">
									<input type="text" id="sex" placeholder="输入性别"
										name="sex" class="col-xs-12" value='<s:property value="sex"/>' />
								</div>

							</div>
							
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 年龄 </label>
								<div class="col-xs-6">
									<input type="text" id="age" placeholder="输入年龄" name="age"
										class="col-xs-12" value='<s:property value="age"/>' />
								</div>
							</div>
							
							
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 创建人信息</label>
								<div class="col-xs-6">
									<input type="text" id="job" placeholder="输入创建人信息"
										name="pespecialcondtion.createman" class="col-xs-12"
										value='<s:property value="pespecialcondtion.createman"/>' />
								</div>

							</div>
							
							
							<div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 状态 </label>
								<div class="col-xs-6">
									<input type="text" id="pespecialcondtion.state" placeholder="输入状态" name="age"
										class="col-xs-12" value='<s:property value="pespecialcondtion.state"/>' />
								</div>
							</div>
                        
                        <div class="form-group">
								<div class="col-xs-1"></div>
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 描述 </label>
								<div class="col-xs-6">
									<input type="text" id="pespecialcondtion.describel" placeholder="输入描述" name="age"
										class="col-xs-12" value='<s:property value="pespecialcondtion.describel"/>' />
								</div>
							</div>
                        
                        
                        
                        
                        
                        
                        


						<div class="col-xs-12 no-padding">
							<div class="clearfix form-actions">
								<div class="col-md-offset-3 col-md-9 pull-right">
									<button class="btn btn-info" type="submit" form="dictEditForm">
										<i class="icon-ok bigger-110"></i> 保存
									</button>

									&nbsp; &nbsp; &nbsp;
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
									sex : {
										required : true
									},
									age : {
										required : true,
										code : true
									},
									job : {
										required : true,
										code : true
									}
								},
								messages : {
									name : {
										required : '<div class="tip-box"><p>请输入名称</p></div>'
									},
									sex : {
										required : '<div class="tip-box"><p>请输入性别 </p></div>'
									},
									age : {
										required : '<div class="tip-box"><p>请输入年龄</p></div>'
									},
									job : {
										required : '<div class="tip-box"><p>请输入类型</p></div>'
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
											"System/Pe/save",
											$(form).serialize(),
											function(json) {
												if(json.status){
									    			 parent.ui_info(json.info);
									    			 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
									    			 //parent.maincontent_datatable.fnReloadAjax();
									    			 parent.reloadAjax();
									    			 parent.layer.close(index); //再执行关闭  
									    		 }else{
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
