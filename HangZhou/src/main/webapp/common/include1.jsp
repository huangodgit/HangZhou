<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<base href="<%=basePath%>"/>
<meta charset="utf-8" />
<!-- basic styles -->
<link href="vendor/ace-1.3.3/assets/css/bootstrap.css" rel="stylesheet" />
<link href="vendor/ace-1.3.3/assets/css/font-awesome.css" rel="stylesheet" />

<!--[if IE 7]>
  <link rel="stylesheet" href="vendor/ace-1.3.3/assets/css/font-awesome-ie7.min.css" />
<![endif]-->

<!-- page specific plugin styles -->
<link rel="stylesheet" href="vendor/ace-1.3.3/assets/css/jquery-ui.custom.css" />
<link rel="stylesheet" href="vendor/ace-1.3.3/assets/css/jquery.gritter.css" />
<link rel="stylesheet" href="vendor/ace-1.3.3/assets/css/select2.css" />
<link rel="stylesheet" href="vendor/ace-1.3.3/assets/css/bootstrap-editable.css" />

<!-- map items -->  
<link rel="stylesheet" type="text/css" href="css/bmap.css"/>
<link rel="stylesheet" type="text/css" href="css/index.css"/>
<!-- fonts -->

<!-- ace styles -->
<link rel="stylesheet" href="vendor/ace-1.3.3/assets/css/ace.css" />
<link rel="stylesheet" href="vendor/ace-1.3.3/assets/css/ace-rtl.css" />
<link rel="stylesheet" href="vendor/ace-1.3.3/assets/css/ace-skins.css" />
<link rel="stylesheet" href="vendor/ace-1.3.3/assets/css/chosen.css" />
<!--[if lte IE 8]>
  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
<![endif]-->

<!-- inline styles related to this page -->

<!-- ace settings handler -->

<script src="vendor/ace-1.3.3/assets/js/ace-extra.js"></script>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--[if lt IE 9]>
<script src="vendor/ace-1.3.3/assets/js/html5shiv.js"></script>
<script src="vendor/ace-1.3.3/assets/js/respond.min.js"></script>
<![endif]-->
<script src="vendor/ace-1.3.3/assets/js/jquery.js"></script>
<script src="vendor/ace-1.3.3/assets/js/jquery.validate.js"></script>
<script src="vendor/layer/layer.js"></script>

<!--[if !IE]> -->

<script type="text/javascript">
	window.jQuery || document.write("<script src='vendor/ace-1.3.3/assets/js/jquery.js'>"+"<"+"/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='vendor/ace-1.3.3/assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->

<script type="text/javascript">
	if("ontouchend" in document) document.write("<script src='vendor/ace-1.3.3/assets/js/jquery.mobile.custom.js'>"+"<"+"/script>");
</script>
<script src="vendor/ace-1.3.3/assets/js/bootstrap.js"></script>
<script src="vendor/ace-1.3.3/assets/js/typeahead.jquery.js"></script>

<!-- page specific plugin scripts -->
<script src="vendor/dataTables-1.10.7/media/js/jquery.dataTables.js"></script>
<%-- <script src="vendor/ace-1.3.3/assets/js/jquery.dataTables.bootstrap.js"></script> --%>
<script src="vendor/ace-1.3.3/assets/js/jquery-ui.custom.js"></script>
<script src="vendor/ace-1.3.3/assets/js/jquery.ui.touch-punch.js"></script>
<script src="vendor/ace-1.3.3/assets/js/jquery.gritter.js"></script>
<script src="vendor/ace-1.3.3/assets/js/chosen.jquery.js"></script>
<script src="vendor/ace-1.3.3/assets/js/fuelux/fuelux.spinner.js"></script>
<script src="vendor/ace-1.3.3/assets/js/date-time/bootstrap-datepicker.js"></script>
<script src="vendor/ace-1.3.3/assets/js/date-time/bootstrap-timepicker.js"></script>
<script src="vendor/ace-1.3.3/assets/js/date-time/moment.js"></script>
<script src="vendor/ace-1.3.3/assets/js/date-time/daterangepicker.js"></script>
<script src="vendor/ace-1.3.3/assets/js/bootstrap-colorpicker.js"></script>
<script src="vendor/ace-1.3.3/assets/js/jquery.knob.js"></script>
<script src="vendor/ace-1.3.3/assets/js/jquery.autosize.js"></script>
<script src="vendor/ace-1.3.3/assets/js/jquery.inputlimiter.1.3.1.js"></script>
<script src="vendor/ace-1.3.3/assets/js/jquery.maskedinput.js"></script>
<script src="vendor/ace-1.3.3/assets/js/bootstrap-tag.js"></script>

<script src="vendor/ace-1.3.3/assets/js/bootbox.js"></script>
<script src="vendor/ace-1.3.3/assets/js/jquery.slimscroll.js"></script>
<script src="vendor/ace-1.3.3/assets/js/jquery.easypiechart.js"></script>
<script src="vendor/ace-1.3.3/assets/js/jquery.hotkeys.js"></script>
<script src="vendor/ace-1.3.3/assets/js/bootstrap-wysiwyg.js"></script>
<script src="vendor/ace-1.3.3/assets/js/select2.js"></script>
<script src="vendor/ace-1.3.3/assets/js/x-editable/bootstrap-editable.js"></script>
<script src="vendor/ace-1.3.3/assets/js/x-editable/ace-editable.js"></script>

<!-- ace scripts -->
<script src="vendor/ace-1.3.3/assets/js/ace-elements.js"></script>
<script src="vendor/ace-1.3.3/assets/js/ace.js"></script>

<!-- BMap -->
<script type="text/javascript" src="js/apiv1.3v4.min.js"></script>
<script type="text/javascript" src="js/tools.js"></script>
<script type="text/javascript" src="js/navigationcontrol.js"></script>
<script type="text/javascript" src="js/baiduTilesInfo.js"></script>

<!-- select -->
<script type="text/javascript" src="js/jquery.cxselect.js"></script>

<script src="js/common.js"></script>

<!-- common functions -->
<script type="text/javascript">
/**
 * layer弹出框
 * @param name
 * @param url
 * @param width
 * @param height
 */
function showLayerDialog(name,url,width,height){
	 layer.open({
		type: 2,
		skin: 'layui-layer-rim', //加上边框
		title: name,
		fix: false,
		shadeClose: true,
		maxmin: false,
		area: [width, height],
		content: url
	});
}
</script>