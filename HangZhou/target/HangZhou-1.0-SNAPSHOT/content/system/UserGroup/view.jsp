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
									<input type="text" id="form-field-1" placeholder="用户组名" name="name" class="col-xs-10" readonly value='<s:property value="name"/>'/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 所属组 </label>
								<div class="col-xs-9">
									<input type="text" id="userGroupName" placeholder="无" class="col-xs-10 isAddSign" readonly="readonly" value='<s:property value="parent.name"/>'>
									
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 描述  </label>
	
								<div class="col-xs-9">
									<textarea class="form-control limited istextarea" id="editor1" maxlength="600" rows="5" readonly name="description" style="width:250px;"><s:property value="description"/></textarea>
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

</body>
</html>
