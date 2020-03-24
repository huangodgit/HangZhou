<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>处理</title>
<s:include value="/common/include.jsp"></s:include>
<link rel="stylesheet" type="text/css" href="css/validate-tip-bottom.css" />
</head>
<body>
	<div class="page-content">
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>
					<form id="VillageLivelihoodNewsForm" class="form-horizontal" role="form"
						method="post" action="News/News/save">
						<input type="hidden" name="id" value='<s:property value="id"/>'>
						<input type="hidden" id="status" value='<s:property value="status"/>'>
						<div class="col-xs-12 no-padding-right">
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 处理结果</label>
								<div class="col-xs-8">
									<textarea class="form-control limited" id="editor1"
										maxlength="600" rows="5" name="handleResult"><s:property value="handleResult"/></textarea>
								</div>
							</div>
						</div>
						</div>

						<div class="col-xs-12 no-padding">
							<div class="clearfix form-actions">
								<div class="col-mx-9 pull-right">
									<button class="btn btn-info" type="submit">
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

	<!-- inline scripts related to this page -->

	<script type="text/javascript">
		$(function() {
			$('.date-picker').datepicker({
				autoclose : true,
				language : 'zh-CN'
			}).next().on(ace.click_event, function() {
				$(this).prev().focus();
			});
		})
		if($("#status").val()=="已转为待决策项目"){
			$("#toDecide").attr("style","display:none");
		}
		
		function closeWindow() {
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.maincontent_datatable.fnReloadAjax();
			parent.layer.close(index); //再执行关闭  
		}
		var nvillageAddValidator;
		jQuery(function($) {

			/* $('#element_id').cxSelect({
				  url: 'common/areaData3.json',   // 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
				  selects: ['town', 'village'],
				  firstValue: ''
			}); */

			nvillageAddValidator = $('#VillageLivelihoodNewsForm')
					.validate(
							{
								focusInvalid : false,
								rules : {
									handleResult: {
										required : true
									}
								},
								messages : {
									handleResult: {
										required : '<div class="tip-box"><p>请填写处理结果</p></div>'
									}
								},
								submitHandler : function(form) {
									sendAjax(
											"News/News/save",
											$(form).serialize(),
											function(json) {
												if (json.status) {
													parent.ui_info(json.info);
													var index = parent.layer
															.getFrameIndex(window.name); //先得到当前iframe层的索引
													/* parent.maincontent_datatable.fnReloadAjax(); */
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
		function toDecided(url,obj){
			ui_confirm("确定转为待决策项目吗？",function(){
				 sendAjax(url," ", function(json){
		    		 if(json.status){
		    			 ui_info("已成功转为待决策项目");
		    			 parent.maincontent_datatable.fnReloadAjax();
		    		 }else{
		    			 ui_error("转换失败");
		    		 }
		    	 });
			  });
		}
	</script>

</body>

</html>
