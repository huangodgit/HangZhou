<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>修改</title>
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
							<input type="hidden" name="id" value='<s:property value="id"/>'/>
							<s:if test="parent.id != null">
								<div class="form-group">
									<label class="col-xs-3 control-label no-padding-right"
										for="form-field-1"> 所属模块 </label>
									<div class="col-xs-9">
										<span><s:property value="name"/></span>
									</div>
								</div>
							</s:if>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 模块名 </label>
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="模块名" name="name" class="col-xs-10" value='<s:property value="name"/>'/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 模块代号 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="代号" name="code" class="col-xs-10" value='<s:property value="code"/>'/>
								</div>
							</div>
							<%-- <div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 排序序号 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="排序序号" name="sortnum" class="col-xs-10" value='<s:property value="sortnum"/>'/>
								</div>
							</div> --%>
							<s:if test="parent.id != null">
								<div class="form-group">
									<label class="col-xs-3 control-label no-padding-right"
										for="form-field-1"> 模块链接 </label>
		
									<div class="col-xs-9">
										<input type="text" id="form-field-1" placeholder="模块链接" name="link" class="col-xs-10" value='<s:property value="link"/>'/>
									</div>
								</div>
								<div class="form-group">
									<label class="col-xs-3 control-label no-padding-right"
										for="form-field-1"> 资源链接 </label>
		
									<div class="col-xs-9">
										<input type="text" id="form-field-1" placeholder="资源链接" name="resourceUri" class="col-xs-10" value='<s:property value="resourceUri"/>'/>
									</div>
								</div>
							</s:if>
							<input type="hidden" name="parentid" value='<s:property value="parent.id"/>'>
							<input type="hidden" name="actionOperation" value="edit">
							<%-- <div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 上级模块 </label>
								<div class="col-xs-9">
									<input type="text" id="moduleName" placeholder="请选择上级模块" name="OrgNames" class="col-xs-10 isAddSign" readonly="readonly" value='<s:property value="parent.name"/>'>
									<input type="hidden" id="moduleID" name="parentid" readonly="readonly" value='<s:property value="parent.id"/>'> 
									<a class="green tooltip-info col-xs-1" data-rel="tooltip" data-placement="top" title="" onclick="showLayerDialog('模块树','System/Module/listTreeForSelect','100%','100%');" data-original-title="添加">
										<i class="icon-pencil light-orange bigger-130"></i>
									</a>
								</div>
							</div> --%>
							
							<%-- <div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 模块描述  </label>
	
								<div class="col-xs-9">
									<textarea class="form-control limited istextarea" id="editor1" maxlength="600" rows="5" name="description" style="width:250px;"><s:property value="description"/></textarea>
								</div>
							</div> --%>
							
							
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
			    	sendAjax("System/Module/save", $(form).serialize(), function(json){
			    		 if(json.ok){
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
			
				
				
			});
			$(function(){
				
				autoSizeIFrameHeight(true,true);
			})
		</script>

</body>
</html>
