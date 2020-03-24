
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title>系统管理</title>
<s:include value="/common/include.jsp"></s:include>
<link rel="stylesheet" href="css/list.css">
<style>
	.blank{
		margin-left:20px;
	}
	.blanklimit{
		margin-left:5px;
	}
</style>
</head>

<body>

	<div class="page-content" style="padding: 0px;background:#e4e6e9">

		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div class="breadcrumbs" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="icon-home home-icon"></i> <a href="#">主页</a></li>
						<li class="active">访问受限</li>
					</ul>

				</div>
				<h1 id="text" style="text-align:center;font-size:44px;">您没有权限访问该页面</h1>
	<script>
			var getH = document.body.offsetHeight;
			getH = getH/2-55;
			document.getElementById("text").style.padding = "120px 0 0 0 ";
			parent.$("iframe").attr("scrolling","no");
	</script>


			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->

	</div>
	<!-- /.page-content -->

		

</body>
</html>