<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">
<head>
<title>决策详情</title>

<s:include value="/common/include.jsp"></s:include>
</head>

<body style="background-color:white;">
	<div class="page-content" id="enterpriseAdd">
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>
					<form id="enterpriseAddForm" class="form-horizontal" role="form" >
					<input type="hidden" id="showPath" value='<s:property value="filePath"/>'/>
						<input type="hidden" id="showId" value='<s:property value="fileId"/>'/>
						<input type="hidden" id="showName" value='<s:property value="fileName"/>'/>
						<input type="hidden" id="showType" value='<s:property value="fileMIME"/>' />
						<div class="col-xs-5 no-padding" style="width:90%">
							
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"style="text-align:right;"> 当前状态</label>
								<div class="col-xs-8">
									<input type="text" id="form-field-1"  readonly="readonly" value="<s:property value="tmpProjectProgress.progressStatus" />" name="progressStatus" class="col-xs-10"  style="width:270px;"/> 
								</div>
							</div>
					<div class="form-group">
					
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"style="text-align:right;"> 时间 </label>
								<div class="col-xs-8">
									<div class="row"style="width:0px">
								<div class="col-xs-8 col-sm-11">
									
									<div class="input-group">
										<input class="form-control date-picker" id="id-date-picker-1"
											type="text" data-date-format="yyyy-mm-dd" 
											name="progressDate"  style="width:230px;" readonly="readonly"value="<s:property value="tmpProjectProgress.progressDate" />"
											/> <span
											class="input-group-addon" > <i
											class="icon icon-calendar bigger-110"></i>
										</span>
									</div>
								</div>
								
							</div> 
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"style="text-align:right;"> 操作人 </label>
								<div class="col-xs-8">
									<input type="text" id="form-field-1" readonly="readonly" value="<s:property value="tmpProjectProgress.operator" />"name="operator" class="col-xs-10"   style="width:270px;"/> 
								</div>
							</div>
							
							
							
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"style="text-align:right;"> 操作时间 </label>
								<div class="col-xs-8">
									<div class="row"style="width:0px">
								<div class="col-xs-8 col-sm-11">
									
									<div class="input-group">
										<input class="form-control date-picker" id="id-date-picker-1"  style="width:230px;"
											type="text" data-date-format="yyyy-mm-dd" readonly="readonly" value="<s:property value="tmpProjectProgress.operateTime" />"
											name="operateTime"
											/> <span
											class="input-group-addon"> <i
											class="icon icon-calendar bigger-110"></i>
										</span>
									</div>
								</div>
								
							</div> 
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1" style="line-height:25px;  margin-top:34px; 
  overflow:hidden;text-align:right;">说明 </label>
								<div class="col-xs-7">
									<textarea class="form-control limited" id="editor1" readonly="readonly"maxlength="600" rows="5" name="progressInfo"  placeholder=""style="width:270px;"><s:property value="tmpProjectProgress.progressInfo" /></textarea>
								</div>
							</div>
							<div class="form-group" id="app">
						</div>
						<div class="col-xs-6 no-padding-right no-padding-left" >
							<style type="text/css"> 
								.anchorBL{ 
								display:none; 
								}
							</style>
							
						</div>
					<div class="col-xs-12 no-padding">
							<div class="clearfix form-actions">
								<div class="col-mx-offset-3 col-mx-9 pull-right">
									<a href="javascript:void(0)" class="btn btn-info" onclick="closeWindow()">
										<i class="icon-ok bigger-110"></i> 确定
									</a>
									
								</div>
							</div>
						</div>
					</form>
				</div>
				<!-- PAGE CONTENT ENDS -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /.page-content -->

	<!-- inline scripts related to this page -->

	<script type="text/javascript">
	function closeWindow(){
		var index = parent.layer
		.getFrameIndex(window.name); //先得到当前iframe层的索引
		parent.layer.close(index); //再执行关闭  
	}
	/* 已上传文件表单显示 */
	if ($("#showName,#showPath").val() != "") {
		$("#app").append('<label class="col-xs-4 control-label no-padding-right" for="form-field-1">已上传文件</label><div class="col-xs-7"><div id="fileDisplay"></div></div>');
		var showName = $("#showName").val();
		var showPath = $("#showPath").val();
		var showId = $("#showId").val();
		var showType = $("#showType").val();
		var showNames = new Array();
		var showPaths = new Array();
		var showIds = new Array();
		showNames = showName.split(",");
		showPaths = showPath.split(",");
		showIds = showId.split(",");
		showTypes = showType.split(",");
		for (var i = 0; i < showNames.length; i++) {
			if (showTypes[i] == "image") {
				$("#fileDisplay")
						.append(
								"<li style=\"float:left;margin-right:5px;margin-bottom:10px;\"id='"+showIds[i]+"'>\n "
										+ "<img layer-src='"+showPaths[i]+"' alt='"+showNames[i]+"' src='"+showPaths[i]+"' style=\"cursor:pointer;width:100px;height:100px;\"/>\n"
										+ "<div class=\"filename\">"
										+ showNames[i]
										+ "</div>\n"
										+ "</li>"
						);
			} else if (showTypes[i] == "file") {
				$("#fileDisplay")
						.append(
								"<li style=\"float:left;margin-right:5px;margin-bottom:10px;\"id='"+showIds[i]+"'>\n "
										+ "<img src='"+showPaths[i]+"' style=\"width:100px;height:100px;\"/>\n"
										+ "<div class=\"filename\"><a href='BaseInfo/Project/fileDown?fileId="
										+ showIds[i]
										+ "'>"
										+ showNames[i]
										+ "</a></div>\n" + "</li>");
			}

		}
	}
	//图片预览
	!function() {
		layer.config({
			extend : 'extend/layer.ext.js'
		});
		layer.ready(function() {
			//使用相册
			layer.photos({
				photos : '#fileDisplay',
				area : [ '500px' ],
				shift : 0,
				closeBtn : 1,
				offset : '100px',
				move:false,
				shadeClose : true
			});
		});
	}();
	</script>
</body>
</html>