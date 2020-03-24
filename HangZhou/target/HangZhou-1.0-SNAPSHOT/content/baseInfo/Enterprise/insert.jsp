<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>企业新增</title>
<s:include value="/common/include.jsp"></s:include>
<s:include value="/common/include-ueditor.jsp" />
<link rel="stylesheet" type="text/css" href="css/validate-tip-bottom.css">
<style type="text/css"> 
div.datepicker.datepicker-dropdown.dropdown-menu{
z-index:999! important
}		
</style>
</head>

<body>
	<div class="page-content" id="enterpriseAdd">
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>
					<form id="enterpriseAddForm" class="form-horizontal" role="form"  method="post" action="BaseInfo/Enterprise/save">
						<div >
						<div class="col-xs-5 no-padding" style="width: 50%;">
						    <div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 编号 </label>
								<div class="col-xs-8">
									<input type="text" id="code" placeholder="输入编号" name="code" class="col-xs-10" /> 
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 企业名称 </label>
								<div class="col-xs-8">
									<input type="text" id="name" placeholder="输入企业名称" name="name" class="col-xs-10" /> 
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 经纬度 </label>
								<div class="col-xs-8">
									<input type="text" id="lng" placeholder="输入经度" name="longitude" class="col-xs-5" onchange="chanegePosition()"/>
									<input type="text" id="lat" placeholder="输入纬度" name="latitude" class="col-xs-5" onchange="chanegePosition()"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 法人 </label>
								<div class="col-xs-8">
									<input type="text" id="legalMember" placeholder="输入法人"  name="legalMember" class="col-xs-10" /> 
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 注册资金 </label>
								<div class="col-xs-8">
									<input type="text" id="fund" placeholder="输入注册资金" name="fund" class="col-xs-10 " />
									<label class="no-padding-left" style="padding-top:5px;">&nbsp;万</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 营业执照号 </label>
								<div class="col-xs-8">
									<input type="text" id="businessLicenseNum" placeholder="输入营业执照号"  name="businessLicenseNum" class="col-xs-10" /> 
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 纳税人识别号 </label>
								<div class="col-xs-8">
									<input type="text" id="taxpayerNumber" placeholder="输入纳税人识别号"  name="taxpayerNumber" class="col-xs-10" /> 
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right" for="form-field-1"> 注册地址 </label>
								<div class="col-xs-8">
									<input type="text" id="address" placeholder="输入注册地址" name="address" class="col-xs-10" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-4 control-label no-padding-right"
									for="form-field-1">成立时间</label>
								<div class="col-xs-7">
									<!-- #section:plugins/date-time.datepicker -->
									<div class="input-group">
										<input class="form-control date-picker" id="foundTime" readonly style="cursor:default"
											type="text" data-date-format="yyyy-mm-dd" name="foundTime" />
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

										</script>
											</div>
										</td>
									</tr>
								</table>
							</div>
						</div>
						<div class="col-xs-12 no-padding">
							<div class="clearfix form-actions">
								<div class="col-mx-offset-3 col-mx-9 pull-right">
									<button class="btn btn-info" type="submit">
										<i class="icon-ok bigger-110"></i> 保存
									</button>
									&nbsp;
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
		var enterpriseAddValidator;
		jQuery(function($) {
			sendAjax("BaseInfo/Town/getAreaData", "", function(json){
				$('#element_id').cxSelect({
					  url: json,
					  selects: ['town', 'village'],
					  firstValue: ''
				});
	    	 });
			
			/* $('#element_id').cxSelect({
				  url: 'common/areaData3.json',   // 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
				  selects: ['town', 'village'],
				  firstValue: ''
			}); */
			
			enterpriseAddValidator = $('#enterpriseAddForm').validate({
			     focusInvalid: false,
			     rules: {
			    	 code:{
			    		required:true 
			    	 },
			    	 name:{
						required:true		    	  
			    	  },
			    	  legalMember:{
						required:true		    	  
					  },
					  fund:{
						required:true
					  },
					  businessLicenseNum:{
							required:true
					  },
					  taxpayerNumber:{
							required:true
					  },
					  address:{
							required:true
					  },
					  foundTime:{
						  required:true
					  }
			    	  
			     },
			     messages: {
			    	 code:{
			    		required:'<div class="tip-box"><p>请输入编号</p></div>'
			    	 },
			    	 name: {
				       required: '<div class="tip-box"><p>请输入企业名称</p></div>'
					 },
			    	 legalMember:{
					   required:'<div class="tip-box"><p>请输入法人</p></div>'	    	  
					 },
					 fund:{
					   required:'<div class="tip-box"><p>请输入注册资金</p></div>'	
					 },
					 businessLicenseNum:{
					   required:'<div class="tip-box"><p>请输入营业执照号</p></div>'	
					 },
					 taxpayerNumber:{
					   required:'<div class="tip-box"><p>请输入纳税人识别号</p></div>'	
					 },
					 address:{
					   required:'<div class="tip-box"><p>请输入注册地址</p></div>'	
					 },
					 foundTime:{
					   required:'<div class="tip-box"><p>请输入成立时间</p></div>'
					 }
			     },
					errorPlacement: function(error, element) { 

				    	 if(element.next().is("span")){
				    	 element.parent().after(error);
				    	 }else{
				    	 error.appendTo(element.parent());
				    	 }
				    	 },
			     submitHandler: function (form) {
			    	sendAjax("BaseInfo/Enterprise/save", $(form).serialize(), function(json){
			    		 if(json.status){
			    			 parent.ui_info(json.info);
			    			 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			    			 parent.maincontent_datatable.fnReloadAjax();
			    			 parent.layer.close(index); //再执行关闭  
			    		 }else{
			    			 ui_error(json.info);
			    		 }
			    	 });
			    	 return false;
				 }
			    });
				$('[data-rel=tooltip]').tooltip();
			});
			
			// 百度地图API功能
			var marker;
			var isMark = false;
			var map = new BMap.Map("allmap", {mapType: BMAP_HYBRID_MAP});
			map.centerAndZoom(new BMap.Point(118.881124,28.943067), 14);
			map.addControl(new BMap.NavigationControl()); 
			map.setMinZoom(14);
			map.enableScrollWheelZoom();
			$('#map div.anchorBL').hide();//隐藏百度地图logo
			
			map.addEventListener("click", function(e){
				var point = new BMap.Point(e.point.lng, e.point.lat);
				marker = new BMap.Marker(point);// 创建标注
				if (!isMark) {
					this.addOverlay(marker);// 将标注添加到地图中
					isMark = true;
					$("#lng").val(marker.getPosition().lng);
					$("#lat").val(marker.getPosition().lat);
				}else{
					this.clearOverlays();
					this.addOverlay(marker);// 将标注添加到地图中
					$("#lng").val(marker.getPosition().lng);
					$("#lat").val(marker.getPosition().lat);
				}
			});
			
			function showPosition(type){
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
				}else if(type=='nVillage'){
					url="BaseInfo/Nvillage/getNvillage?id="+v;
				}
				if(v!=null && v!=''){
				    sendAjax(url, {}, function(json){
				    	if(json!=null
				    			&&json.longitude!=''&&json.longitude!=null&&typeof(json.longitude) != "undefined"
				    			&&json.latitude!=''&&json.latitude!=null&&typeof(json.latitude) != "undefined"){
				    		map.centerAndZoom(new BMap.Point(json.longitude, json.latitude), 20);				    		
				    	}
			    	 }); 
				}
			}

			$(function() {
				$('.date-picker').datepicker({
					autoclose : true,
					language : 'zh-CN'
				}).next().on(ace.click_event, function() {
					$(this).prev().focus();
				});
			})
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
		</script>
</body>
</html>