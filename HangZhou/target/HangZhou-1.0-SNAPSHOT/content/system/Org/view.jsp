<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>浏览</title>
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
							<input type="hidden" name="id" value='<s:property value="id"/>'/>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 机构名 </label>
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="机构名" name="name" class="col-xs-10" readonly value='<s:property value="name"/>'/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 机构代号 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="代号" name="code" class="col-xs-10" readonly value='<s:property value="code"/>'/>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 所属机构 </label>
								<div class="col-xs-9">
									<input type="text" id="orgName" placeholder="最高机构" class="col-xs-10" readonly readonly="readonly" value='<s:property value="parent.name"/>'>
									
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 机构描述  </label>
	
								<div class="col-xs-9">
									<textarea class="form-control limited istextarea" id="editor1" maxlength="600" rows="5" name="description" readonly style="width:250px;"><s:property value="description"/></textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 下级机构  </label>
	
								<div class="col-xs-9">
									<textarea class="form-control limited istextarea" id="editor1" maxlength="600" rows="5" name="description" readonly style="width:250px;"><s:property value="orgQueryName"/> 
									</textarea>
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
