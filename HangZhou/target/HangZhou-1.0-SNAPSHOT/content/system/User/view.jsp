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
									for="form-field-1"> 用户名 </label>
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="用户名" readonly name="loginName" value='<s:property value="loginName"/>' class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 显示名称 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="显示名称" readonly name="name" value='<s:property value="name"/>' class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 所属部门 </label>
								<div class="col-xs-9">
									<input type="text" id="orgName" placeholder="请选择部门" name="parent.name" class="col-xs-10" readonly="readonly" value='<s:property value="org.name"/>'>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 所属成员 </label>
	
								<div class="col-xs-9">
									<input type="text" id="memberName" placeholder="请选择户内成员" name="member.name" class="col-xs-10" readonly="readonly" value='<s:property value="member.name"/>'>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 登陆次数 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="显示名称" readonly name="name" value='<s:property value="logincount"/>' class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right" for="form-field-1" style="margin-right:12px;"> 上次登陆时间 </label>
								<div class="input-group isdatepicker" style="margin-left:20px;">
								<input class="form-control date-picker valid" name="startDate" placeholder="时间" readonly="" id="form-field-DatePicker isdatepicker" type="text" value='<s:property value="lastlogintime"/>'> <span class="input-group-addon"> <i class="icon icon-calendar bigger-110"></i>
										</span>
									</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 所属角色  </label>
	
								<div class="col-xs-9">
									<textarea class="form-control limited istextarea" id="editor1" maxlength="600" rows="5" name="remark" style="width:250px;" readonly><s:property value="rolename"/></textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 说明  </label>
	
								<div class="col-xs-9">
									<textarea class="form-control limited istextarea" id="editor1" maxlength="600" rows="5" name="remark" style="width:250px;" readonly><s:property value="remark"/></textarea>
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
