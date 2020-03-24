<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>新增</title>
<s:include value="/common/include.jsp"></s:include>
<link rel="stylesheet" href='<s:url value="/css/css-system.css"/>'>
<script type="text/javascript" src='<s:url value="/js/js-system.js"/>'></script>
</head>

<body id="mybody">
	<div class="page-content">

		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>
					
						<div class="col-xs-10 no-padding">
						<form id="townAddForm" class="form-horizontal" role="form"  method="post">
							<input type="hidden" name="id" value='<s:property value="id"/>'>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 用户组名 </label>
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="用户组名" name="name" class="col-xs-10" value='<s:property value="name"/>'/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 所属组 </label>
								<div class="col-xs-9">
									<input type="text" id="userGroupName" placeholder="请选择上级用户组" class="col-xs-10 isAddSign" readonly="readonly" value='<s:property value="parent.name"/>'>
									<input type="hidden" id="userGroupID" name="parentid" readonly="readonly"  value='<s:property value="parent.id"/>'> 
									<a class="green tooltip-info col-xs-1" data-rel="tooltip" data-placement="top" title="" onclick="showLayerDialog('组列表','System/UserGroup/listTreeForSelect','100%','100%');" data-original-title="添加">
										<i class="icon-pencil light-orange bigger-130"></i>
									</a>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 描述  </label>
	
								<div class="col-xs-9">
									<textarea class="form-control limited istextarea" id="editor1" maxlength="600" rows="5" name="description" style="width:250px;"><s:property value="description"/></textarea>
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
			    	 /* if (isMark == true) {
					     	$("#lng").val(marker.getPosition().lng);
							$("#lat").val(marker.getPosition().lat);
			    	}else{
			    		$("#lat").val();
						$("#lng").val();
			    	} */
			    	sendAjax("System/UserGroup/save", $(form).serialize(), function(json){
			    		 if(json.ok){
			    			 parent.ui_info(json.info);
			    			 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			    			// parent.maincontent_datatable.fnReloadAjax();
			    			 parent.reloadAjax();
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
