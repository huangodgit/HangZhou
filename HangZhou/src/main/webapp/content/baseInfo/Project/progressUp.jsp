<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>镇新增</title>
<s:include value="/common/include.jsp"></s:include>
<link rel="stylesheet" href='<s:url value="/css/css-project.css"/>'>
<script type="text/javascript" src='<s:url value="/js/js-project.js"/>'></script>
</head>
<script type="text/javascript">
	$(function() {
		$('.date-picker').datepicker({
			format:'mm/dd/yyyy',
			autoclose:true,
			language:'zh-CN'
		}).next().on(ace.click_event,function(){
			$(this).prev().focus();
		});
	})
</script>
<body id="mybody">
	<div class="page-content">

		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>
					
						<div class="col-xs-12 no-padding">
							<%-- <div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"></label>

								<div class="col-xs-7">
									<input type="text" id="form-field-1" placeholder="项目名称"
										name="projectName" class="col-xs-10" readonly value="<s:property value="projectName"/>"/>
								</div>

							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"></label>

								<div class="col-xs-7">
									<input type="text" id="form-field-1" placeholder="当前状态（字典表）"
										name="tmpvillageProjectprogress.progressStatus" class="col-xs-10" />
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"></label>
								<!-- #section:plugins/date-time.datepicker -->
								<div class="col-xs-7">
									<div class="input-group">
										<input class="form-control date-picker" name="tmpvillageProjectprogress.progressDate" placeholder="时间"
											id="id-date-picker-1" type="text" /> <span
											class="input-group-addon"> <i
											class="icon icon-calendar bigger-110"></i>
										</span>
									</div>
								</div>

							</div>

							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"></label>

								<div class="col-xs-9">
									<textarea class="form-control limited" id="editor1"
										placeholder="说明" maxlength="600" rows="5" name="tmpvillageProjectprogress.progressContent"></textarea>
								</div>
							</div>

							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"></label>

								<div class="col-xs-6">
									<input type="text" id="form-field-1" placeholder="附件上传" name=""
										class="col-xs-12" />
								</div>
								<div class="col-xs-2">
									<!-- <button class="btn btn-info"
										style="margin-top: -10px; padding: 2px; height: 40px;">
										增加</button> -->
										<button class="mybtn mybtn_small mybtn_primary col-xs-2" style="height:28px;width:53px;margin-left:10px" type="button">增加</button>
								</div>
							</div>
							<div class="form-group" style="width:800px;">
								<label class="control-label no-padding-right"
									for="form-field-1"></label>

								<div class="col-xs-1" style="width:300px; margin-left: 108px;">
									<input type="text" id="form-field-1" placeholder="操作人" name="tmpvillageProjectprogress.operator"
										class="col-xs-10" />

								</div>
								<div class="col-xs-1" style="width:300px;margin-left: -50px;">
									<div class="input-group">
										<input class="form-control date-picker" name="tmpvillageProjectprogress.operateTime" placeholder="上报时间"
											id="id-date-picker-1" type="text" style="height: 29px;"/> <span
											class="input-group-addon"> <i
											class="icon icon-calendar bigger-110"></i>
										</span>
									</div>
								</div>
							</div> --%>
							<form id="townAddForm" class="form-horizontal" role="form"
						method="post">
						<input type="hidden" name="id" value="<s:property value="id"/>" />
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 项目名称 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="项目名称" readonly value='<s:property value="projectName"/>' class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 当前阶段 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="当前状态" name="tmpProjectProgress.progressStatus" class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1" style="margin-right:12px;"> 时间 </label>
								<div class="input-group isdatepicker" style="margin-left:20px;">
								<input class="form-control date-picker" name="tmpProjectProgress.progressDate" placeholder="点击选择开始时间" readonly id="form-field-DatePicker" type="text"> <span class="input-group-addon"> <i class="icon icon-calendar bigger-110"></i>
										</span>
									</div>
							</div>
 							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 说明  </label>
	
								<div class="col-xs-9">
									<textarea class="form-control limited istextarea" id="editor1" maxlength="600" rows="5" name="tmpProjectProgress.progressInfo" style="width:250px;"></textarea>
								</div>
							</div>
							
							<input type="hidden" name="filePath" value="">
							<input type="hidden" name="fileMIME" value="">
							<input type="hidden" name="fileName" value="">
							
					</form>
						<div class="form-group">
						<label class="col-xs-3 control-label" for="form-field-1" style="padding-right:5px;">附件上传</label>
						<div class="col-xs-6 isfile" style="padding-left: 15px;">
							
								<form action="BaseInfo/Project/uploadFiles"
									style="border: 0px; background-color:rgba(255,255,255,0);"class="dropzone" id="dropzone">
									<label style="display:none;width: 140px;background-color: #ffffff;height: 35px;position: absolute;left: 260px;"></label>
									<div style="pointer-events: none;margin-left: 5px;margin-top: 10px;">
									<input class="dz-clickable dz-started"type="text" style="height: 35px;font-size:12px;width:100%"value="可拖文件上传"/>
									</div>
									<div id="fileSelector">选择</div>
									<!-- <img alt="" src="images/anjian.JPG"> -->
									<div class="fallback">
										<input name="file" type="file" multiple="" />
									</div>
								</form>
								
								
						</div>
						<!-- <button type="submit" id="submit-all" disabled="disabled">上传</button> -->
						<script type="text/javascript">
							loadUploadFunction();
						</script>
					</div>
						</div>



						<div class="col-xs-12 no-padding">
						<div class="clearfix form-actions">
								<div class="col-mx-9 pull-right">
									<button class="btn btn-info" type="button" onclick="$('#townAddForm').submit();">
										<i class="icon-ok bigger-110"></i> 保存
									</button>
			
									&nbsp; &nbsp; &nbsp;
									<button class="btn" type="reset">
										<i class="icon-undo bigger-110"></i> 重置
									</button>
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
<input type="file" multiple="multiple" class="dz-hidden-input" accept=".jpg,.png,.gif,.bmp,.jpeg,.JPG,.PNG,.GIF,.BMP,.JPEG,.txt,.pdf,.doc,.xls,.mdb,.ppt" style="visibility: hidden; position: absolute; top: 0px; left: 0px; height: 0px; width: 0px;">
	<script type="text/javascript">
		var townAddValidator;
		
		jQuery(function($) {
			townAddValidator = $('#townAddForm')
					.validate(
							{
								focusInvalid : false,
								rules : {
									name : {
										required : true
									}
								},
								messages : {
									name : {
										required : "请输入名称"
									}
								},
								submitHandler : function(form) {
									/* if (isMark == true) {
									    	$("#lng").val(marker.getPosition().lng);
										$("#lat").val(marker.getPosition().lat);
									}else{
									$("#lat").val();
									$("#lng").val();
									} */
									sendAjax("BaseInfo/Project/save_Progress",
											$(form).serialize(),
											function(json) {
												if (json.status) {
													parent.ui_info(json.info);
													var index = parent.layer
															.getFrameIndex(window.name); //先得到当前iframe层的索引
													parent.maincontent_datatable
															.fnReloadAjax();
													parent.layer.close(index); //再执行关闭  
												} else {
													ui_error(json.info);
												}
											});
									return false;
								}
							});

		});

		
	</script>

</body>
</html>
