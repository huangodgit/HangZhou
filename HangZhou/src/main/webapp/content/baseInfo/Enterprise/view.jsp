<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>企业详情</title>
<base href="<%=basePath%>"/>
<s:include value="/common/include.jsp"></s:include>
<s:include value="/common/include-ueditor.jsp" />
</head>

<body>
	<div class="page-content">
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>
					<form id="enterpriseEditForm" class="form-horizontal" role="form"  method="post" action="BaseInfo/Enterprise/save">
						<input type="hidden" id="id" name="id" value="<s:property value='id'/>"/>
						<input type="hidden" name="flag" id="flag" value="0"/>
						<div>
						<div class="col-xs-5 no-padding" style="width: 50%;">
						    <div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 编号</label>
								<div class="col-xs-8">
									<input type="text" id="form-field-1" placeholder="输入编号" name="code" readonly value="<s:property value='code'/>" class="col-xs-10" /> 
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 企业名称 </label>
								<div class="col-xs-8">
									<input type="text" id="form-field-1" placeholder="输入企业名称" name="name" readonly value="<s:property value='name'/>" class="col-xs-10" /> 
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 经纬度 </label>
								<div class="col-xs-8" id="element_id">
									<input type="text" id="lng" name="longitude" placeholder="输入经度" class="col-xs-5" readonly value="<s:property value='longitude'/>" onchange="chanegePosition()"/>
									<input type="text" id="lat" name="latitude" placeholder="输入纬度" class="col-xs-5" readonly value="<s:property value='latitude'/>" onchange="chanegePosition()"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 法人 </label>
								<div class="col-xs-8">
									<input type="text" id="form-field-1" placeholder="输入法人"  name="legalMember" readonly value="<s:property value='legalMember'/>" class="col-xs-10" /> 
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 营业执照号 </label>
								<div class="col-xs-8">
									<input type="text" id="form-field-1" placeholder="输入营业执照号"  name="businessLicenseNum" readonly value="<s:property value='businessLicenseNum'/>" class="col-xs-10" /> 
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 纳税人识别号 </label>
								<div class="col-xs-8">
									<input type="text" id="form-field-1" placeholder="输入纳税人识别号"  name="taxpayerNumber" readonly value="<s:property value='taxpayerNumber'/>" class="col-xs-10" /> 
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 注册资金 </label>
								<div class="col-xs-8">
									<input type="text" id="form-field-1" placeholder="输入注册资金" name="fund" readonly value="<s:property value='fund'/>" class="col-xs-10 no-padding-right" />
									<label class="no-padding-left" style="padding-top:5px;">&nbsp;万</label>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 注册地址 </label>
								<div class="col-xs-8">
									<input type="text" id="form-field-1" placeholder="输入注册地址" name="address" readonly value="<s:property value='address'/>" class="col-xs-10" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right"
									for="form-field-1">成立时间</label>
								<div class="col-xs-7">
									<!-- #section:plugins/date-time.datepicker -->
									<div class="input-group">
										<input class="form-control date-picker" id="foundTime" readonly style="cursor:default"
											type="text" data-date-format="yyyy-mm-dd" name="foundTime"  value="<s:property value='foundTime'/>"/>
										<span class="input-group-addon"> <i
											class="icon icon-calendar bigger-110"></i>
										</span>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xs-6 no-padding-right no-padding-left" >
							<style type="text/css"> 
								.anchorBL{ 
								display:none; 
								}
							</style>
							<div id="allmap" style="width:auto;height:500px;"></div>
						</div>
						</div>
						<div class="col-xs-12 no-padding">
						 <div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1">企业介绍 </label>
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
		var enterpriseEditValidator;
		function closeWindow() {
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.maincontent_datatable.fnReloadAjax();
			parent.layer.close(index); //再执行关闭  
		}
		jQuery(function($) {
			sendAjax("BaseInfo/Town/getAreaData", "", function(json){
				$('#element_id').cxSelect({
					  url: json,
					  selects: ['town', 'village'],
					  firstValue: ''
				});
	    	 });
			/* 
			$('#element_id').cxSelect({
				  url: 'common/areaData3.json',   // 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
				  selects: ['town', 'village'],
				  firstValue: ''
			}); */
		});
		// 百度地图API功能
		var marker;
		var isMark = false;
		var map = new BMap.Map("allmap", {mapType: BMAP_HYBRID_MAP});
		map.centerAndZoom(new BMap.Point(118.881124,28.943067), 14);
		map.addControl(new BMap.NavigationControl()); 
		map.setMinZoom(16);
		map.enableScrollWheelZoom();
		$('#map div.anchorBL').hide();//隐藏百度地图logo
		
		if($("#lng").val()!=''&&$("#lat").val()!=''){
			map.centerAndZoom(new BMap.Point($("#lng").val(),$("#lat").val()), 19);
			var point = new BMap.Point($("#lng").val(),$("#lat").val());
			marker = new BMap.Marker(point);// 创建标注
			map.addOverlay(marker);// 将标注添加到地图中
			isMark = true;
		}
		//else{

		function showPosition(type){
			if($("#lng").val()!=''&& $("#lat").val()!=''&&$("#flag").val()=='0'){
				return false;
			}
			var url="";
			var id='#'+type;
			var v=$(id).val();
			if(v==''||v==null){
				return false;
			}
			if(type=='town'){
				url="BaseInfo/Town/getTown?id="+v;
			}else if(type=='village'){
				url="BaseInfo/Village/getVillage?id="+v;
			}
			if(v!=null && v!=''){
			    sendAjax(url, {}, function(json){
			    	if(json!=null
			    			&&json.longitude!=''&&json.longitude!=null&&typeof(json.longitude) != "undefined"
			    			&&json.latitude!=''&&json.latitude!=null&&typeof(json.latitude) != "undefined"){
			    		map.centerAndZoom(new BMap.Point(json.longitude, json.latitude), 19);				    		
			    	}
		    	 }); 
			}
		}
		
		function chanegePosition(){
			map.removeOverlay(marker);
			var lat = $("#lat").val();
			var lng = $("#lng").val();
			if(lat!=null && lat!=''&&lng!=null && lng!=''){
				var point = new BMap.Point(lng,lat);
				marker = new BMap.Marker(point);// 创建标注
				marker.enableDragging();
				map.addOverlay(marker);// 将标注添加到地图中
				map.centerAndZoom(new BMap.Point(lng, lat), 19);//定位			    		
			}
		}
		
		function changeFlag(){
			$("#flag").val('1');
		}
		</script>
</body>
</html>