<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>修改</title>
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
						<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> id </label>
									
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="id" readonly name="id" value='<s:property value="id"/>' class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 姓名 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="姓名" readonly name="name" value='<s:property value="name"/>' class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 年龄 </label>
									
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="年龄" readonly name="age" value='<s:property value="age"/>' class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 性别 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="性别" readonly name="sex" value='<s:property value="sex"/>' class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 是否为党员 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="是否为党员" readonly name="isMember" value='<s:property value="isMember"/>' class="col-xs-10"/>
								</div>
							</div>
							
					</form>
						
						</div>

						<div class="col-xs-12 no-padding-bottom">
						<div class="clearfix form-actions">
								<div class="col-mx-9 pull-right">
									<a href="javascript:void(0)" class="btn btn-info" onclick="closeWindow()">
										<i class="icon-ok bigger-110"></i> 确定
									</a>
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
		$(document).ready(function(e){
			var getTime = $("input[name=startDate]").val();
			formatSQLDate($("input[name=startDate]").val());
			var getPointPosition = getTime.indexOf(".");
		})
		function formatSQLDate(date){
			var getPointPosition = date.indexOf(".");
			var formatoneDate = date.substring(0,getPointPosition);
			formatoneDate = formatoneDate.replace(/-/g,'/');
			var createDate = new Date(date);
		}
		</script>

</body>
</html>
