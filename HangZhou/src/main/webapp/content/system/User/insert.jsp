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
									for="form-field-1"> 用户名 </label>
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="用户名" name="loginName" class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 显示名称 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="显示名称" name="name" class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 密码 </label>
	
								<div class="col-xs-9">
									<input type="password" id="form-field-1" placeholder="密码" name="password1" class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 确认密码 </label>
	
								<div class="col-xs-9">
									<input type="password" id="form-field-1" placeholder="确认密码" name="password2" class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 所属机构 </label>
								<div class="col-xs-9">
									<input type="text" id="orgName" placeholder="请选择机构" name="org.name" class="col-xs-10 isAddSign" readonly="readonly">
									<input type="hidden" id="orgID" name="org.id" readonly="readonly" value=""> 
									<a class="green tooltip-info col-xs-1" data-rel="tooltip" data-placement="top" title="" onclick="showLayerDialog('人员列表','System/Org/listTreeForSelect','90%','100%');" data-original-title="添加">
										<i class="icon-pencil light-orange bigger-130"></i>
									</a>
								</div>
							</div>
							<!-- <div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 所属成员 </label>
	
								<div class="col-xs-9">
									<input type="text" id="memberName" placeholder="请选择户内成员" name="member.name" class="col-xs-10 isAddSign" readonly="readonly">
									<input type="hidden" id="memberID" name="member.id" readonly="readonly" value=""> 
									<a class="green tooltip-info col-xs-1" data-rel="tooltip" data-placement="top" title="" onclick="showLayerDialog('人员列表','BaseInfo/Member/listForUserSelect','100%','100%');" data-original-title="添加">
										<i class="icon-pencil light-orange bigger-130"></i>
									</a>
								</div>
							</div> -->
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 说明  </label>
	
								<div class="col-xs-9">
									<textarea class="form-control limited istextarea" id="editor1" maxlength="600" rows="5" name="remark" style="width:250px;"></textarea>
								</div>
							</div>
							
							
					</form>
						
						</div>

						<div class="col-xs-12 no-padding">
							<div class="clearfix form-actions">
								<div class="col-md-offset-3 col-md-9 pull-right">
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
			    	sendAjax("System/User/save", $(form).serialize(), function(json){
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
