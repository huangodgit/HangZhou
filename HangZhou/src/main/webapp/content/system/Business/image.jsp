<%--
  Created by IntelliJ IDEA.
  User: 陆金超
  Date: 2019/6/28
  Time: 11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>图像预览</title>
    <s:include value="/common/include.jsp"></s:include>
    <link rel="stylesheet" type="text/css" href="css/validate-tip-bottom.css"/>
</head>
<body>
<div>
    <a href="#" id="prev">上一张</a>
    <a href="#" id="next">下一张</a>
</div>
<div>
    <input type="hidden" id="id" name="id" value="<s:property value='id'/>" />
    <img src="" alt="" id="prv-img" >
</div>


<script type="text/javascript">
    var baseUrl = "./upload/";
    var imgs;
    var idx = 0;
    jQuery(function ($) {
        $(function() {
            sendAjax("System/Business/listAllForBusinessImages", {"id":$("*[name='id']").val()}, function(json){
                imgs = json;
                if(json.length > 0){
                    $('#prv-img').attr("src",baseUrl+imgs[idx].imageName);
                }
            });
        })
    })

    $('#prev').click(function () {
        if(idx > 0){
            idx--;
            $('#prv-img').attr("src",baseUrl+imgs[idx].imageName);
        }else{
            ui_info('已经是第1张图片')
        }
        return false;
    })

    $('#next').click(function () {
        if(idx < imgs.length-1){
            idx++;
            $('#prv-img').attr("src",baseUrl+imgs[idx].imageName);
        }else{
            ui_info('已经是最后一张图片')
        }
        return false;
    })
</script>
</body>
</html>
