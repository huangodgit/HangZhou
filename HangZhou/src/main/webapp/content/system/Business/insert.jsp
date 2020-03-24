<%@ page language="java" contentType="text/html; charset=utf-8"
		 pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<title>业务新增</title>
	<s:include value="/common/include.jsp"></s:include>
	<link rel="stylesheet" type="text/css" href="css/validate-tip-bottom.css" />
</head>

<body>

<div class="page-content">

	<div class="row">
		<div class="col-xs-12">
			<!-- PAGE CONTENT BEGINS -->
			<div>
				<form id="businessInsertForm" class="form-horizontal"
					  role="form" method="post"
					  action="System/Business/save">
					<div id="img-area"></div>
					<div class="col-xs-12 no-padding" style="margin-top:40px;margin-bottom:40px">

						<%--业务--%>
						<div class="form-group">
							<div class="col-xs-1"></div>
							<label class="col-xs-2 control-label no-padding-right"
								   for="form-field-1"> 名称 </label>
							<div class="col-xs-6">
								<input type="text" id="form-field-1" placeholder="请输入名称"
									   name="name" class="col-xs-12" />
							</div>
						</div>
						<div class="form-group">
							<div class="col-xs-1"></div>
							<label class="col-xs-2 control-label no-padding-right"
								   for="company"> 公司 </label>
							<div class="col-xs-6">
								<input type="text" id="company" placeholder="请输入公司"
									   name="company" class="col-xs-12" />
							</div>
						</div>
						<div class="form-group">
							<div class="col-xs-1"></div>
							<label class="col-xs-2 control-label no-padding-right"
								   for="tel"> 电话 </label>
							<div class="col-xs-6">
								<input type="text" id="tel" placeholder="请输入电话"
									   name="tel" class="col-xs-12" />
							</div>
						</div>

						<%--特殊情况--%>
						<div class="form-group">
							<div class="col-xs-1"></div>
							<label class="col-xs-2 control-label no-padding-right">时间</label>
							<div class="col-xs-6">
								<div class="input-group">
									<input class="form-control date-picker" style="cursor:default"
										   id="time" type="text" readonly
										   name="specialCondition.time" />
									<span class="input-group-addon">
										<i class="icon icon-calendar bigger-110"></i>
									</span>
								</div>
							</div>
						</div>

						<div class="form-group">
							<div class="col-xs-1"></div>
							<label class="col-xs-2 control-label no-padding-right"> 状态 </label>
							<div class="col-xs-6">
								<input type="number" id="state" placeholder="请输入状态（1：有效；0：无效）" name="specialCondition.state" class="col-xs-12"/>
							</div>
							<%--<div class="col-xs-6" id="specialCondition.state">
								<div class="col-xs-6" style="margin-top:1px;font-size:14px">
									<label><input type="radio" value="1" id="stateT" name="flag">有效</label>
								</div>
								<div class="col-xs-6" style="margin-top:1px;font-size:14px">
									<label><input type="radio" value="0" id="stateF" name="flag">无效</label>
								</div>
							</div>--%>
						</div>

						<div class="form-group">
							<div class="col-xs-1"></div>
							<label class="col-xs-2 control-label no-padding-right"> 情况描述</label>
							<div class="col-xs-6">
								<input type="text" id="description" placeholder="请输入情况描述"
									   name="specialCondition.description" class="col-xs-12"/>
							</div>
						</div>
						<div class="form-group">
							<div class="col-xs-1"></div>
							<label class="col-xs-2 control-label no-padding-right"> 创建人</label>
							<div class="col-xs-6">
								<input type="text" id="founder" placeholder="请输入创建人" name="specialCondition.founder" class="col-xs-12"/>
							</div>
						</div>
					</div>
				</form>
				<!-- 文件上传 -->
				<div class="form-group col-xs-12">
					<div class="col-xs-2"></div>
					<div class="col-xs-5 no-padding" style="margin: 8px;">
						<div class="form-group">
							<label class="col-xs-2 control-label no-padding-right" style="text-align: right;padding-right:5px !important;">附件上传</label>
							<div class="col-xs-8 isfile">

								<form action="System/Business/uploadFiles"
									  style="border: 0; background-color:rgba(255,255,255,0);width: 100%" class="dropzone" id="dropzone">
									<div class="dz-message" data-dz-message></div>
									<label style="display:none;width: 140px;background-color: #ffffff;height: 35px;position: absolute;left: 260px;"></label>
									<div style="pointer-events: none;margin-left: 5px;margin-top: 10px;">
										<input class="dz-clickable dz-started" type="text" style="height: 35px;font-size:12px;"value="可拖文件上传"/>
									</div>
									<div id="fileSelector">选择</div>
									<div class="fallback">
										<input name="image" type="file" multiple="" />
									</div>
								</form>

							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-xs-12 no-padding">
				<div class="clearfix form-actions">
					<div class="col-md-offset-3 col-md-9 pull-right">
						<button class="btn btn-info" type="submit" form="businessInsertForm">
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
		<!-- /.col -->
	</div>
	<!-- /.row -->
</div>
<!-- PAGE CONTENT ENDS -->

<script type="text/javascript">
	/*function getRadioVal(){
		var temp = document.getElementsByName("flag");
		for(var i=0;i<temp.length;i++)
		{
			if(temp[i].checked){
				flag = temp[i].value;
				return flag;
				break;
			}
		}};*/
	/*Dropzone.js*/
	var files = [];
	Dropzone.options.dropzone = {
		paramName:"image",
		addRemoveLinks: true,
		removeFile:"删除图像",
		init: function() {
			this.on("success", function(file,rsp) {
				var json = JSON.parse(rsp);
				console.log(json);
				if(json.status){
					file.imageId= json.imageId;
					files = this.files;
				}else{
					ui_error('上传失败');
				}
			});
			this.on("removedfile", function(file) {
				sendAjax("System/Business/deleteFile", {"imageId":file.imageId}, function(json){
					if(!json.status){
						ui_error('删除失败');
					}else{
						files = (this.files !== undefined) ? this.files : [];
					}
				});
			});
		}
	};

	var familyAddValidator;
	jQuery(function($) {
		$(function() {
			$('.date-picker').datepicker({
				autoclose: true,
				language: 'zh-CN'
			}).next().on(ace.click_event, function () {
				$(this).prev().focus();
			});
		});

		familyAddValidator = $('#businessInsertForm')
				.validate(
						{
							focusInvalid : false,
							rules : {
								name : {
									required : true
								},
								company : {
									required : true
								},
								tel : {
									required : true,
								},
								time : {
									required : false,
								},
								state : {
									required : true,
								},
								description : {
									required : true,
								},
								founder : {
									required : true,
								}
							},
							messages : {
								name : {
									required : '<div class="tip-box"><p>请输入名称</p></div>'
								},
								company : {
									required : '<div class="tip-box"><p>请输入公司</p></div>'
								},
								tel : {
									required : '<div class="tip-box"><p>请输入电话</p></div>'
								},
								time : {
									required : '<div class="tip-box"><p>请输入时间</p></div>'
								},
								description : {
									required : '<div class="tip-box"><p>请输入情况描述</p></div>'
								},
								founder : {
									required : '<div class="tip-box"><p>请输入创建人</p></div>'
								}
							},
							errorPlacement : function(error, element) {
								if (element.next().is("span")) {
									element.parent().after(error);
								} else {
									error.appendTo(element.parent());
								}
							},
							submitHandler : function(form) {
								// 遍历增加隐藏参数 imageIds
								$.each(files,function (index, file) {
									$('#img-area').append('<input type="hidden" name="imageIds" value="'+file.imageId+'" />')
								});
								sendAjax(
										"System/Business/save",
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
		$('[data-rel=tooltip]').tooltip();
	});

</script>

</body>
</html>
