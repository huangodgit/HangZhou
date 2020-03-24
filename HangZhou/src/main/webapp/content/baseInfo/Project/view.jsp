<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>新增项目</title>
<s:include value="/common/include.jsp"></s:include>
<link rel="stylesheet" href='<s:url value="/css/css-project.css"/>'>
<s:include value="/common/include-ueditor.jsp" />
<script type="text/javascript" src='<s:url value="/js/js-project.js"/>'></script>
<link rel="stylesheet" type="text/css" href="css/validate-tip-bottom.css"/>

</head>

<body id="mybody">
	<div class="page-content">

		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>
						<form id="townAddForm" class="form-horizontal" role="form"  method="post" action="BaseInfo/Town/save">
						<div>
						<div class="col-xs-5 no-padding">
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1">选择企业</label>
								<div class="col-xs-8">
									<input type="text" id="enterpriseName" placeholder="选择企业" style="width:91% !important"
										name="enterpriseName" class="col-xs-10" readonly="readonly" value='<s:property value="enterprise.name"/>'/> <input
										type="hidden" id="enterpriseId" name="enterpriseId" class="col-xs-10"
										readonly="readonly" /> <a class="green tooltip-info col-xs-1 "
										data-rel="tooltip" data-placement="top"
										style="padding-top: 5px;" title="选择"
										onclick="showLayerDialogXY('企业列表','BaseInfo/Enterprise/listForSelect','94%','90%','3%','5%');">
										<i class="icon-plus-sign light-orange bigger-130"></i>
									</a>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 项目名称 </label>
								<input type="hidden" name="id" value='<s:property value="id"/>'>
								<input type="hidden" id="showPath" value='<s:property value="finalPath"/>'/>
								<input type="hidden" id="showId" value='<s:property value="fileId"/>'/>
								<input type="hidden" id="showName" value='<s:property value="fileFileName"/>'/>
								<input type="hidden" id="showType" value='<s:property value="fileContentType"/>' />
								<div class="col-xs-9">
									<input type="text" id="projectName" placeholder="输入名称" name="projectName" readonly class="col-xs-10" value='<s:property value="projectName"/>'/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 项目类型 </label>
	
								<div class="col-xs-9">
									<select id="projectType" name="projectType" class="col-xs-10"data="<s:property value='projectType'/>" disabled="true">
										<option value="0">请选择</option>
										<option value="类型一">类型一</option>
										<option value="类型二">类型二</option>
										
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right" for="form-field-1"> 经度 </label>
								<div class="col-xs-9">
									<input type="text" id="lng" placeholder="输入经度" name="longitude" readonly value='<s:property value="longitude"/>' class="col-xs-5" onchange="chanegePosition()"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right" for="form-field-1"> 纬度 </label>
								<div class="col-xs-9">
									<input type="text" id="lat" placeholder="输入纬度" name="latitude" readonly value='<s:property value="latitude"/>' class="col-xs-5" onchange="chanegePosition()"/>
								</div>
							</div>
							
							<%-- <div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 开始时间 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-DatePicker" name="startDate" class="col-xs-10" readonly value='<s:property value="startDate"/>'/>
								</div>
							</div> --%>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1" style="margin-right:12px;"> 开工日期 </label>
								<div class="input-group isdatepicker" style="margin-left:20px;">
								<input class="form-control date-picker" name="startDate" placeholder="点击选择开始时间" readonly id="form-field-DatePicker isdatepicker" type="text" value='<s:property value="startDate"/>'> <span class="input-group-addon"> <i class="icon icon-calendar bigger-110"></i>
										</span>
									</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 说明  </label>
	
								<div class="col-xs-9">
									<textarea class="form-control limited istextarea" readonly id="editor1" maxlength="600" rows="5" name="explanation"><s:property value="explanation"/></textarea>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 投资金额 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="输入投资金额"  readonly name="investmentCapital" class="col-xs-10" value='<s:property value="investmentCapital"/>'/>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 投资类型 </label>
	
								<div class="col-xs-9">
								<select id="investmentType" name="investmentType" class="col-xs-10"data="<s:property value='investmentType'/>" disabled="true">
										<option value="0">请选择</option>
										<option value="投资类型一">投资类型一</option>
										<option value="投资类型二">投资类型二</option>
										
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 建设单位 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="输入建设单位" readonly name="constructionUnit" class="col-xs-10" value='<s:property value="constructionUnit"/>'/>
								</div>
							</div>
							
							<%-- <div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 计划完成时间 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-DatePicker-finislPlan" placeholder="点击选择计划完成时间" name="planFinishedDate" class="col-xs-10" readonly value='<s:property value="planFinishedDate"/>'/>
								</div>
							</div> --%>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1" style="margin-right:12px;"> 计划完工日期 </label>
								<div class="input-group isdatepicker" style="margin-left:20px;">
								<input class="form-control date-picker" name="planFinishedDate" placeholder="选择计划完成时间" readonly id="form-field-DatePicker isdatepicker" type="text" value='<s:property value="planFinishedDate"/>'> <span class="input-group-addon"> <i class="icon icon-calendar bigger-110"></i>
										</span>
									</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1" style="margin-right:12px;">完工日期 </label>
								<div class="input-group isdatepicker" style="margin-left:20px;">
								<input class="form-control date-picker" name="FinishedDate" placeholder="选择完工时间" readonly id="form-field-DatePicker isdatepicker" type="text" value='<s:property value="FinishedDate"/>'> <span class="input-group-addon"> <i class="icon icon-calendar bigger-110"></i>
										</span>
									</div>
							</div>
							<%-- <div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 上报时间 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-DatePicker-report" placeholder="点击选择上报时间" name="opreateTime" class="col-xs-10" readonly value='<s:property value="opreateTime"/>'/>
								</div>
							</div> --%>
							 </div>
							 <div class="col-xs-7 no-padding-right">
							<div id="allmap"style="width:630px"></div>
						     </div>
							  </div> 
							   
							 
					<input type="hidden" name="filePath" value="">
							<input type="hidden" name="fileMIME" value="">
							<input type="hidden" name="fileName" value="">
							<div class="col-xs-12 no-padding">
						  <div class="form-group">
						   <div class="col-xs-5 no-padding">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1">项目介绍 </label>
									</div>
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
							<div class="row" style="margin:0;padding:0;clear:both">
							<div class="col-xs-12 no-padding">
								<div class="layui-layer-title">进度情况</div>
								<div class="table-responsive">
									<table id="sample-table-2" class="table table-striped table-bordered table-hover font">
										<thead>
											<tr>
												<th>序号</th>
												<th>当前状态</th>
												<th>时间</th>
												<th>说明</th>
												<th>操作人</th>
												<th>上报时间</th>
												<th>操作</th>
											</tr>
										</thead>

										<tbody>
										<s:if test="ProjectProgress.size==0">
											<tr class="odd"><td valign="top" colspan="8" class="dataTables_empty">无进度上报</td></tr>
										</s:if>
										<s:else>
											<s:iterator value="projectProgress" status="st">
												<tr class="odd">
													<td class=" sorting_1"><s:property value="#st.index+1"/></td>
													<td class=""><s:property value="progressStatus"/></td>
													<td class=""><s:property value="progressDate"/></td>
													<td class=""><s:property value="progressInfo"/></td>
													<%-- <td class=""><s:property value="docFiles"/></td> --%>
													<td class=""><s:property value="operator"/></td>
													<td class=""><s:property value="operateTime"/></td>
													<td>
													<div class="visible-md visible-lg hidden-sm hidden-xs action-buttons"><a class="blue tooltip-info action-buttons" data-rel="tooltip" data-placement="top" title="详细信息" onclick="showLayerDialog('详情','BaseInfo/Project/viewProgress?id=<s:property value="id"/>','100%','100%');"> <i class=" icon-book bigger-130"></i> </a></td></div>
													
												</tr>
											</s:iterator>
										</s:else>
										</tbody>
									</table>
								</div>
							</div>
					</form>
						
						<%-- <div class="col-xs-6 no-padding-bottom" >
							<style type="text/css"> 
								.anchorBL{ 
								display:none; 
								}
							</style>
							
						</div> --%>
						 <div class="col-xs-5 no-padding">
						  <div class="form-group">
								<div  id="fileFinished"></div>
								<div class="col-xs-8">
									<!-- #section:plugins/date-time.datepicker -->
									<div id="fileDisplay"></div>
								</div>
							</div>
							</div>
						<div class="col-xs-12 no-padding">
						<div class="clearfix form-actions">
								<div class="clearfix form-actions">
								<div class="col-mx-9 pull-right">
									<a href="javascript:void(0)" class="btn btn-info"
										onclick="closeWindow()"> <i class="icon-ok bigger-110"></i>
										确定
									</a>
								</div>
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

	<script type="text/javascript">
	var ue = UE.getEditor('editor', {
		autoHeightEnabled : false,
		'textarea' : 'intro',
			readonly:true,
			toolbars:[]
	});
	
	var getValue = $("#projectType").attr("data");
	$("#projectType>option").each(function(index ,e){
		if($(this).attr("value") == getValue){
			$(this).prop("selected",true);
		}
	})
	getValue = $("#investmentType").attr("data");
	$("#investmentType>option").each(function(index ,e){
		if($(this).attr("value") == getValue){
			$(this).prop("selected",true);
		}
	})
	
		var townAddValidator;
		function closeWindow() {
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.maincontent_datatable.fnReloadAjax();
			parent.layer.close(index); //再执行关闭  
		}
		
			// 百度地图API功能
			var marker;
			var isMark = false;
			var map = new BMap.Map("allmap", {mapType: BMAP_HYBRID_MAP});
			map.centerAndZoom(new BMap.Point(118.881124,28.943067), 14);
			map.addControl(new BMap.NavigationControl()); 
			map.setMinZoom(14);
			map.enableScrollWheelZoom();
			$('#map div.anchorBL').hide();
			if($("#lng").val()!=''&&$("#lat").val()!=''){
				map.centerAndZoom(new BMap.Point($("#lng").val(),$("#lat").val()), 19);
				var point = new BMap.Point($("#lng").val(),$("#lat").val());
				marker = new BMap.Marker(point);// 创建标注
				map.addOverlay(marker);// 将标注添加到地图中
				isMark = true;
			}
			
			
			/* 已上传文件表单显示 */
			if ($("#showName,#showPath").val() != "") {
				$("#fileFinished").after
				("<label class=\"col-xs-2 control-label no-padding-right\"for=\"form-field-1\">已上传文件</label>");
				var showName = $("#showName").val();
				var showPath = $("#showPath").val();
				var showId = $("#showId").val();
				var showType = $("#showType").val();
				var showNames = new Array();
				var showPaths = new Array();
				var showIds = new Array();
				var showTypes = new Array();
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
												+ "<div class=\"filename\"><a href='CivilizationPoints/FamilyCivilizationPointsDeductRecords/fileDown?fileId="
												+ showIds[i]
												+ "'>"
												+ showNames[i]
												+ "</a></div>\n" + "</li>");
					}

				}

			};
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
			//图片预览
			!function() {
				layer.config({
					extend : 'extend/layer.ext.js'
				});
				layer.ready(function() {
					//使用相册
					layer.photos({
						photos : '#complaintFileDisplay',
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
