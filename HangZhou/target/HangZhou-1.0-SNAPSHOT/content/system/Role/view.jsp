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
							<input type="hidden" name="id" value='<s:property value="id"/>'/>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 角色名 </label>
								<div class="col-xs-9">
									<input type="text" readonly id="form-field-1" placeholder="功能名" name="name" class="col-xs-10" value='<s:property value="name"/>'/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 角色描述 </label>
	
								<div class="col-xs-9">
									<input type="text" readonly id="form-field-1" placeholder="代号" name="description" class="col-xs-10" value='<s:property value="description"/>'/>
								</div>
							</div>
							
							
					</form>
						
						</div>

						
				</div>
				<!-- PAGE CONTENT ENDS -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /.page-content -->


</body>
</html>
