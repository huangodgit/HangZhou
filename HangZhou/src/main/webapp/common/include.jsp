<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<base href="<%=basePath%>"/>
<meta charset="utf-8" />

<!-- basic styles -->
<link href="vendor/assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="vendor/assets/css/font-awesome.min.css" rel="stylesheet" />

<!--[if IE 7]>
  <link rel="stylesheet" href="assets/css/font-awesome-ie7.min.css" />
<![endif]-->

<!-- dropzone -->
<%-- <script type="text/javascript" src="vendor/ace-1.3.3/assets/js/jquery-1.7.1.js"></script> --%>
<script src="vendor/ace-1.3.3/assets/js/dropzone.js"></script>
<link rel="stylesheet" type="text/css" href="vendor/ace-1.3.3/assets/css/dropzone.css"/>

<!-- page specific plugin styles -->
<link rel="stylesheet" href="vendor/assets/css/jquery-ui-1.10.3.custom.min.css" />
<link rel="stylesheet" href="vendor/assets/css/jquery.gritter.css" />
<link rel="stylesheet" href="vendor/assets/css/select2.css" />
<link rel="stylesheet" href="vendor/assets/css/bootstrap-editable.css" />

<!-- map items -->  
<link rel="stylesheet" type="text/css" href="css/bmap.css"/>
<link rel="stylesheet" type="text/css" href="css/index.css"/>
<!-- fonts -->

<!-- ace styles -->
<link rel="stylesheet" href="vendor/assets/css/ace.min.css" />
<link rel="stylesheet" href="vendor/assets/css/ace-rtl.min.css" />
<link rel="stylesheet" href="vendor/assets/css/ace-skins.min.css" />
<link rel="stylesheet" href="vendor/assets/css/chosen.css" />
<!--[if lte IE 8]>
  <link rel="stylesheet" href="assets/css/ace-ie.min.css" />
<![endif]-->

<!-- inline styles related to this page -->

<!-- ace settings handler -->

<script src="vendor/assets/js/ace-extra.min.js"></script>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--[if lt IE 9]>
<script src="assets/js/html5shiv.js"></script>
<script src="assets/js/respond.min.js"></script>
<![endif]-->
<script src="vendor/assets/js/jquery-2.0.3.min.js"></script>
<script src="vendor/assets/js/jquery.validate.min.js"></script>

<!--[if !IE]> -->

<script type="text/javascript">
	window.jQuery || document.write("<script src='vendor/assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
</script>

<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->

<script type="text/javascript">
	if("ontouchend" in document) document.write("<script src='vendor/assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="vendor/assets/js/bootstrap.min.js"></script>
<script src="vendor/assets/js/typeahead-bs2.min.js"></script>

<!-- page specific plugin scripts -->
<script src="vendor/assets/js/jquery.dataTables.min.js"></script>
<script src="vendor/assets/js/jquery.dataTables.bootstrap.js"></script>
<script src="vendor/assets/js/jquery-ui-1.10.3.custom.min.js"></script>
<script src="vendor/assets/js/jquery.ui.touch-punch.min.js"></script>
<script src="vendor/assets/js/jquery.gritter.min.js"></script>
<script src="vendor/assets/js/chosen.jquery.min.js"></script>
<script src="vendor/assets/js/fuelux/fuelux.spinner.min.js"></script>
<script src="vendor/assets/js/date-time/bootstrap-datetimepicker.js"></script>
<script src="vendor/assets/js/date-time/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="vendor/assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="vendor/assets/js/date-time/bootstrap-timepicker.min.js"></script>
<script src="vendor/assets/js/date-time/moment.min.js"></script>
<script src="vendor/assets/js/date-time/daterangepicker.min.js"></script>
<script src="vendor/assets/js/bootstrap-colorpicker.min.js"></script>
<script src="vendor/assets/js/jquery.knob.min.js"></script>
<script src="vendor/assets/js/jquery.autosize.min.js"></script>
<script src="vendor/assets/js/jquery.inputlimiter.1.3.1.min.js"></script>
<script src="vendor/assets/js/jquery.maskedinput.min.js"></script>
<script src="vendor/assets/js/bootstrap-tag.min.js"></script>

<script src="vendor/assets/js/bootbox.min.js"></script>
<script src="vendor/assets/js/jquery.slimscroll.min.js"></script>
<script src="vendor/assets/js/jquery.easy-pie-chart.min.js"></script>
<script src="vendor/assets/js/jquery.hotkeys.min.js"></script>
<script src="vendor/assets/js/bootstrap-wysiwyg.min.js"></script>
<script src="vendor/assets/js/select2.min.js"></script>
<script src="vendor/assets/js/x-editable/bootstrap-editable.min.js"></script>
<script src="vendor/assets/js/x-editable/ace-editable.min.js"></script>

<!-- ace scripts -->
<script src="vendor/assets/js/ace-elements.min.js"></script>
<script src="vendor/assets/js/ace.min.js"></script>

<!-- layer -->
<script src="vendor/layer/layer.js"></script>

<!-- BMap -->
<script type="text/javascript" src="js/apiv1.3v4.min.js"></script>
<script type="text/javascript" src="js/tools.js"></script>
<script type="text/javascript" src="js/navigationcontrol.js"></script>
<script type="text/javascript" src="js/baiduTilesInfo.js"></script>

<!-- select -->
<script type="text/javascript" src="js/jquery.cxselect.js"></script>

<script src="js/common.js"></script>


 <!-- pageJump -->
<script src="js/pageJump.js"></script>

<!-- echarts -->
<script src="vendor/echarts-2.2.7/doc/asset/js/esl/esl.js"></script>
<script src="vendor/echarts-2.2.7/build/dist/echarts.js"></script>

<!-- common -->
<link href="css/list.css" rel="stylesheet" />
<link href="css/css-common.css" rel="stylesheet" />
<script src="js/js-common.js"></script>
<link rel="stylesheet" type="text/css" href="css/list.css">
<link rel="stylesheet" href='<s:url value="/css/css-project.css"/>'>
<link href="vendor/assets/css/datepicker.css" rel="stylesheet"/>
<link href="vendor/assets/css/bootstrap-datetimepicker.css" rel="stylesheet"/>

<!-- wechat --> 
<script type="text/javascript" src="js/diymen.js"></script>

<!-- datetables -->
<script src=<s:url value="/js/jquery.dataTables.js"/>></script>
<link rel="stylesheet" type="text/css" href='<s:url value="/css/jquery.dataTables.css"/>'>