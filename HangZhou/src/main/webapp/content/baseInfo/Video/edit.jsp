<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>修改</title>
<s:include value="/common/include.jsp"></s:include>
<s:include value="/common/include-ueditor.jsp" />
<link rel="stylesheet" type="text/css" href="css/validate-tip.css" />
</head>
<body>
	<div class="page-content">
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>
					<form id="villageLivelihoodNewsAddForm" class="form-horizontal"
						role="form" method="post"
						action="BaseInfo/Video/save">
						<input type="hidden" name="id" value="<s:property value='id'/>" />
						<div class="col-xs-12 no-padding-right">
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right" for="form-field-1"> 编号</label>
								<div class="col-xs-8">
									<input type="text" placeholder="输入编号" name="code" class="col-xs-10" value='<s:property value="code"/>'>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right" for="form-field-1"> 名称</label>
								<div class="col-xs-8">
									<input type="text" placeholder="输入名字" name="name" class="col-xs-10" value='<s:property value="name"/>' />
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right" for="form-field-1"> 用户</label>
								<div class="col-xs-8">
									<input type="text" placeholder="输入用户" name="user" class="col-xs-10" value='<s:property value="user"/>' />
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right" for="form-field-1"> 密码</label>
								<div class="col-xs-8">
									<input type="password" placeholder="输入密码" name="password" class="col-xs-10" value='<s:property value="password"/>' />
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right" for="form-field-1"> 访问地址</label>
								<div class="col-xs-8">
									<input id="videoUrl" type="text" placeholder="输入访问地址" name="url" class="col-xs-10" value='<s:property value="url"/>'/>
									<input type="button" value="确定" style="height: 28px;width: 50px;margin-left: 5px;" onclick="replaceSrc()">
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 信息内容 </label>
								<table width="100%" border="0" cellspacing="0"
									class="input_table">
									<tr>
										<td width="" height="64" class="input_titletext"></td>
										<td style="padding-bottom: 10px; padding-top: 10px;">
											<div class="text_daoruF">
												<script type="text/plain" id="editor"
													style="width:100%;height:450px;">
													<s:property value="intro" escape="false"/>
										</script>
											</div>
										</td>
									</tr>
								</table>
							</div>
							<div class="form-group" id="videoShow" style="display:none;">
								<label class="col-xs-2 control-label no-padding-right" for="form-field-1"> 视频预览区域 </label>
								<div class="col-xs-8">
									<video id="myVideo" src="<s:property value="url"/>"  controls="controls" autoplay="autoplay" loop="loop" class="col-xs-10 no-padding"></video>
									<div class="limit_box hidden" id="limit_box">
										<div>
											<div class="limit-msg drop-shadow">
												<p id="errorMsg"></p>
											</div>
											<i class="icon-remove"></i>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div class="col-xs-12 no-padding">
							<div class="clearfix form-actions">
								<div class="col-mx-9 pull-right">
									<button class="btn btn-info" type="submit">
										<i class="icon-ok bigger-110"></i> 保存
									</button>

									&nbsp; &nbsp; &nbsp;
									<button class="btn" type="reset">
										<i class="icon-undo bigger-110"></i> 重置
									</button>
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
		var ue = UE.getEditor('editor', {
			autoHeightEnabled : false,
			'textarea' : 'intro'
		});
		var nvillageAddValidator;
		jQuery(function($) {

			/* $('#element_id').cxSelect({
				  url: 'common/areaData3.json',   // 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
				  selects: ['town', 'village'],
				  firstValue: ''
			}); */

			nvillageAddValidator = $('#villageLivelihoodNewsAddForm')
					.validate(
							{
								focusInvalid : false,
								rules : {
									name : {
										required : true
									},
									url:{
										required : true
									}
								},

								messages : {
									title : {
										required : '<div class="tip-box"><p>请输入名称</p></div>'
									},
									operator : {
									    required : '<div class="tip-box"><p>请输入访问地址</p></div>'
								    }
								},
								errorPlacement: function (error, element) { //指定错误信息位置
									if (element.is(':checkbox')) { //如果是radio或checkbox
										$(".inline").parent().after(error);
									} else {
										error.appendTo(element.parent().parent());
									}
								},
								submitHandler : function(form) {
									sendAjax(
											"BaseInfo/Video/save",
											$(form).serialize(),
											function(json) {
												if (json.status) {
													parent.ui_info(json.info);
													var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
													parent.maincontent_datatable.fnReloadAjax();
													parent.layer.close(index); //再执行关闭  
												} else {
													ui_error(json.info);
												}
											});
									return false;
								}
							});
		});
		function replaceSrc(){
			$("#videoShow").show();
			var url = $("#videoUrl").val();
			document.getElementById("myVideo").src = url;
		}
		if(document.getElementById("myVideo").src == document.getElementById("myVideo").baseURI){
			$("#videoShow").hide();
		}else{
			$("#videoShow").show();
		}
	</script>

</body>

</html>
