<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>企业外部循环产业链详情</title>
<s:include value="/common/include.jsp"></s:include>
<s:include value="/common/include-ueditor.jsp" />
<link rel="stylesheet" type="text/css" href="css/validate-tip.css">
</head>
<body>
	<div class="page-content">
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>
					<form id="enterpriseOuterCycleAddForm" class="form-horizontal"
						role="form" method="post"
						action="BaseInfo/EnterpriseOuterCycle/save">
						<input type="hidden" id="id" name="id" value="<s:property value='id'/>"/>
						<div class="col-xs-12 no-padding-right">
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1">选择企业</label>
								<div class="col-xs-8">
									<input type="text" id="enterpriseName" placeholder="选择企业"
										name="enterpriseName" class="col-xs-10" readonly="readonly" value="<s:property value='enterprise.name'/>"/> <input
										type="hidden" id="enterpriseId" name="enterpriseId" class="col-xs-10" value="<s:property value='enterprise.id'/>"/>
								</div>
							</div>
							<div class="form-group">
							   <label class="col-xs-2 control-label no-padding-right"
									for="form-field-1">外部循环企业链名称 </label>
								<div class="col-xs-8">
									<input type="text"  placeholder="输入外部循环企业链名称 "
										name="name" class="col-xs-10" readonly value="<s:property value='name'/>" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1">企业外部循环介绍 </label>
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
						</div>

						<div class="col-xs-12 no-padding">
							<div class="clearfix form-actions">
								<div class="col-mx-9 pull-right">
									<a href="javascript:void(0)" class="btn btn-info"
										onclick="closeWindow()"> <i class="icon-ok bigger-110"></i>
										确定
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
		var ue = UE.getEditor('editor', {
			autoHeightEnabled : false,
			'textarea' : 'intro',
				readonly:true,
				toolbars:[]
		});
		function closeWindow() {
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.maincontent_datatable.fnReloadAjax();
			parent.layer.close(index); //再执行关闭  
		}
		
		var nvillageAddValidator;
		jQuery(function($) {

			/* $('#element_id').cxSelect({
				  url: 'common/areaData3.json',   // 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
				  selects: ['town', 'village'],
				  firstValue: ''
			}); */

			
		});
	</script>

</body>

</html>
