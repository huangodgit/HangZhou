<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta />
<title>衢州“循环经济”智慧平台</title>
<s:include value="/common/include.jsp"></s:include>
</head>
<body>
<h2></h2>
</body>
<script>
$(function(){
var username = $(window.parent.document).find("#loginUser").attr("data-value");
document.querySelector("h2").innerHTML ="欢迎你，" +username;
});
</script>
</html>

