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
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 所属模块 </label>
								<div class="col-xs-9" style="padding-top:4px;">
									<span><s:if test="parent==null||parent.name==null">无</s:if><s:else><s:property value="parent.name"/></s:else></span>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 模块名 </label>
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="模块名" name="name" class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 模块代号 </label>
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="模块代号" name="code" class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 模块链接 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="模块链接" name="link" class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 资源链接 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="资源链接" name="resourceUri" class="col-xs-10"/>
								</div>
							</div>
							<input type="hidden" name="parentid" value="<s:property value="id"/>">
							
					</form>
						
						</div>

						<div class="col-xs-12 no-padding">
							<div class="clearfix form-actions">
								<div class="col-mx-9 pull-right">
									<button class="btn btn-info" type="button" onclick="saveAuth()">
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
	var isDoing = false;
		function saveAuth(){
			var getLink = $("input[name=link]").val();
			var getUri = $("input[name=resourceUri]").val();
			var modName = $("input[name=modName]").val();
			var regulax = /^[a-zA-Z0-9]+[/][a-zA-Z0-9]+[/][a-zA-Z0-9]+$/;
			if(regulax.test(getUri) || getUri.indexOf("http") >= 0){
				if(!isDoing){
					isDoing = true;
					sendAjax("System/Module/addModule?actionOperation=save",$("#townAddForm").serialize(), function(json){
						isDoing = false;
						if(json.ok){
							 parent.ui_info(json.info);
			    			 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			    			 //parent.maincontent_datatable.fnReloadAjax();
			    			 parent.reloadAjax();
			    			 parent.reOpen = true;
			    			 parent.layer.close(index); //再执行关闭  
			    		 }else{
			    			 ui_error(json.info);
			    		 }
			    	 });
				}else{
					ui_error("上一个操作正在进行中....");
				}
					
			}else{
				ui_error("填写的地址有误,请检查.例如:BaseInfo/Member/list");
			}
		}
		</script>

</body>
</html>
