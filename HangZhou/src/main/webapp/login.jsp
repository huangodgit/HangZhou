<!-- CAS login page -->
<%-- <%response.sendRedirect("login"); %> --%>

<!-- general login page -->
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title> 杭州“绿色经济”智慧平台</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<s:include value="/common/include.jsp"></s:include>

<style type="text/css">
.login-layout {
	background: url(./images/hz1.jpg) center top no-repeat;
}
</style>

</head>
<body class="login-layout">
	<div class="main-container">
		<div class="main-content">
			<div class="row">
				<div class="col-sm-10 col-sm-offset-1">
					<div class="login-container">
						<div class="center">
							<br> <br> <br>
							<h1>
								<i class="icon-leaf green"></i> 
								<span class="black">杭州</span>
								<span class="red">“绿色经济”</span>
								<span class="black">智慧平台</span>
							</h1>
							<h4 class="blue"></h4>
						</div>
						<br> <br>
						<div class="space-6"></div>
						<div class="position-relative">
							<div id="login-box" class="login-box visible widget-box no-border">
								<div class="widget-body">
									<div class="widget-main">
										<h4 class="header blue lighter bigger">
											<i class="icon-coffee green"></i> 请输入您的登录信息
										</h4>
										<div class="space-6"></div>
										<!-- <form action="login" id="logonForm" method="post" onsubmit="return validateCallback(this, login_myAjaxDone, loginError);"> -->
										<form action="login" id="logonForm" method="post">
											<fieldset>
												<label class="block clearfix"> 
													<span class="block input-icon input-icon-right"> 
														<input type="text" class="form-control" name="loginName" placeholder="请输入用户名" /> 
														<i class="icon-user"></i>
													</span>
												</label> 
												<label class="block clearfix"> 
													<span class="block input-icon input-icon-right"> 
														<input type="password" class="form-control" name="password" placeholder="请输入密码" /> 
														<i class="icon-lock"></i>
													</span>
												</label>
												<div class="space"></div>
												<div class="clearfix">
													<button type="submit" class="width-35 pull-right btn btn-sm btn-primary">
														<i class="icon-key"></i> 登录
													</button>
												</div>
												<div class="space-4"></div>
											</fieldset>
										</form>
									</div>
									<!-- /widget-main -->
									<div class="toolbar clearfix">
										<div></div>
									</div>
								</div>
								<!-- /widget-body -->
							</div>
							<!-- /login-box -->
						</div>
						<!-- /position-relative -->
					</div>
				</div>
				<!-- /.col -->
			</div>
			<!-- /.row -->
		</div>
	</div>
	<!-- /.main-container -->
	
	<!-- inline scripts related to this page -->
	<script>
		function login_myAjaxDone(json) {
			if (json.statusCode == "200") {
				window.open("./index.action", "_self");
			} else {
				alert(json.message);
			}
		}
		function loginError(e) {
			alert("error");
		}
		function validateCallback(form, callback, errorback) {
			var $form = $(form);
			$.ajax({
				type : form.method || 'POST',
				url : $form.attr("action"),
				data : $form.serializeArray(),
				dataType : "json",
				cache : false,
				success : callback,
				error : errorback
			});
			return false;
		}
	</script>
	<div style="display: none"></div>
</body>
</html>
