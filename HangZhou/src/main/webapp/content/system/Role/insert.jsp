<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>新增</title>
<s:include value="/common/include.jsp"></s:include>
<link rel="stylesheet" href='<s:url value="/css/css-system.css"/>'>
<script type="text/javascript" src='<s:url value="/js/js-system.js"/>'></script>
<script>
$(function() {
	$('.date-picker').datepicker({
		format:'yyyy-mm-dd',
		autoclose:true,
		language:'zh-CN'
	}).next().on(ace.click_event,function(){
		$(this).prev().focus();
	});
})
</script>
</head>

<body id="mybody">
	<div class="page-content">

		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>
					
						<div class="col-xs-10 no-padding">
						<form id="townAddForm" class="form-horizontal" role="form"  method="post">
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 角色名 </label>
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="功能名" name="name" class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 角色描述 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="代号" name="description" class="col-xs-10"/>
								</div>
							</div>
							
							<!-- <div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 上级角色 </label>
								<div class="col-xs-9">
									<input type="text" id="roleName" placeholder="请选择上级角色" name="OrgNames" class="col-xs-10 isAddSign" readonly="readonly">
									<input type="hidden" id="roleID" name="parentid" readonly="readonly" value=""> 
									<a class="green tooltip-info col-xs-1" data-rel="tooltip" data-placement="top" title="" onclick="showLayerDialog('角色树','System/Role/listTreeForSelect','100%','100%');" data-original-title="添加">
										<i class="icon-plus-sign light-orange bigger-130"></i>
									</a>
								</div>
							</div> -->
							
							
					</form>
						
						</div>
						<div class="col-xs-12 no-padding">
							<div class="clearfix form-actions">
								<div class="col-mx-9 pull-right">
									<button class="btn btn-info" type="button" onclick="$('#townAddForm').submit();">
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
				<!-- PAGE CONTENT ENDS -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /.page-content -->

	<script type="text/javascript">
		var townAddValidator;
		jQuery(function($) {
			townAddValidator = $('#townAddForm').validate({
			     focusInvalid: false,
			     rules: {
			    	  name:{
						required:true		    	  
				      }
			     },
			     messages: {
			    	  name: {
				       required: "请输入名称"
					  }
			     },
			     submitHandler: function (form) {
			    	 /* if (isMark == true) {
					     	$("#lng").val(marker.getPosition().lng);
							$("#lat").val(marker.getPosition().lat);
			    	}else{
			    		$("#lat").val();
						$("#lng").val();
			    	} */
			    	sendAjax("System/Role/save", $(form).serialize(), function(json){
			    		 if(json.ok){
			    			 parent.ui_info(json.info);
			    			 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			    			 parent.maincontent_datatable.fnReloadAjax();
			    			 parent.layer.close(index); //再执行关闭  
			    		 }else{
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
