<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>聚集区修改</title>
<s:include value="/common/include.jsp"></s:include>
<s:include value="/common/include-ueditor.jsp" />
<script type="text/javascript" src="js/DrawingManager_min.js"></script>
<link rel="stylesheet" type="text/css" href="css/validate-tip.css">

<link rel="stylesheet" href="css/DrawingManager_min.css" />
</head>
<body>
	<div class="page-content" id="enterpriseAdd">
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>

					<form id="enterpriseAddForm" class="form-horizontal" role="form"
						method="post" action="BaseInfo/Grid/save">

						<input type="hidden" id="pointSet" name="pointSet"
							value="<s:property value='pointSet'/>" />
						<!-- <input type="hidden" id="pointSet" name="pointSet" />  -->
						<input type="hidden" id="id" name="id"
							value="<s:property value='id'/>" />
						<div class="col-xs-12 no-padding">
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1"> 聚集区名称 </label>
								<div class="col-xs-7">
									<input type="text" id="form-field-1" placeholder="输入网格名称"
										name="name" class="col-xs-12"
										value="<s:property value="name"/>" />
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-3 control-label no-padding-right"
									for="form-field-1">设立时间</label>
								<div class="col-xs-7">
									<!-- #section:plugins/date-time.datepicker -->
									<div class="input-group">
										<input class="form-control date-picker" id="startDate"
											 style="cursor: default" type="text"
											data-date-format="yyyy-mm-dd" name="startDate"
											value="<s:property value="startDate"/>" /> <span
											class="input-group-addon"> <i
											class="icon icon-calendar bigger-110"></i>
										</span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<div class="col-xs-2"></div>
								<style type="text/css">
.anchorBL {
	display: none;
}
</style>
								<div class="col-xs-7">
									<div id="allmap" style="height: 465px;"></div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1">聚集区介绍 </label>
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
								<div class="col-mx-offset-3 col-mx-9 pull-right">
									<button class="btn btn-info" type="submit">
										<i class="icon-ok bigger-110"></i> 保存
									</button>
									&nbsp;
									<button class="btn" type="reset">
										<i class="icon-undo bigger-110"></i> 重置
									</button>
									&nbsp; <input type="button" class="btn "
										onclick="remove_overlay();" style="background-color: red;"
										value="地图重置"></input>
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
			sendAjax("BaseInfo/Town/getAreaData", "", function(json) {
				$('#element_id').cxSelect({
					url : json,
					selects : [ 'town', 'village' ],
					firstValue : ''
				});
			});

			/* $('#element_id').cxSelect({
				  url: 'common/areaData3.json',   // 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
				  selects: ['town', 'village'],
				  firstValue: ''
			}); */

			enterpriseAddValidator = $('#enterpriseAddForm')
					.validate(
							{
								focusInvalid : false,
								rules : {
									name:{
										required:true
									}
								},
								messages : {
									name:{
										required:'<div class="tip-box"><p>请输入名称</p></div>'
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
											"BaseInfo/Grid/save",
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

		/* // 百度地图API功能
		var s = 0;
		var marker;
		var netPoint;
		var isMark = false;
		var map = new BMap.Map("allmap", {
			mapType : BMAP_HYBRID_MAP
		});
		var pointFirst=119.698747;
		var pointSecond=29.798682;
		
		var pointArray=document.getElementById("pointSet").value;
		//转换坐标格式////////////////////
		
		if(pointArray!=""&&pointArray!="0"){
			
			var first=pointArray.indexOf("[");
			var last=pointArray.lastIndexOf("]");
			var point =pointArray.substring(first+1, last);
			point=point.replace( /],/g,";");
			point=point.replace( /\[/g,"");
					netPoint = new BMap.Polygon(point, {
						strokeWeight : 2,
						strokeColor : "red",
						fillColor : "red",
						fillOpacity : 0.5
					}); //建立多边形覆盖物
					
					var bounds = netPoint.getBounds();
					 var p=[bounds.getSouthWest(),bounds.getNorthEast()]
					 map.setViewport(p);
						
		
		
					

		}else{
			map.centerAndZoom(new BMap.Point(119.698747, 29.798682), 11);
		}
			
		
		

		 		
		
		 map.addControl(new BMap.NavigationControl());
		map.setMinZoom(8);
		map.setMaxZoom(30);
		map.enableScrollWheelZoom(); 

		
		

		
		$('#map div.anchorBL').hide();//隐藏百度地图logo
		
		
		map.addOverlay(netPoint); //添加覆盖物
		 */
		var marker;
		var netPoint;
		var isMark = false;
		var map = new BMap.Map("allmap", {
			mapType : BMAP_HYBRID_MAP
		});
		var pointFirst = 119.698747;
		var pointSecond = 29.798682;
		var pointArray = document.getElementById("pointSet").value;
		//转换坐标格式////////////////////
		if (pointArray != "" && pointArray != "0") {
			var first = pointArray.indexOf("[");
			var last = pointArray.lastIndexOf("]");
			var point = pointArray.substring(first + 1, last);
			point = point.replace(/],/g, ";");
			point = point.replace(/\[/g, "");
			netPoint = new BMap.Polygon(point, {
				strokeWeight : 2,
				strokeColor : "red",
				fillColor : "red",
				fillOpacity : 0.5
			}); //建立多边形覆盖物
			var bounds = netPoint.getBounds();
			var p = [ bounds.getSouthWest(), bounds.getNorthEast() ]
			map.setViewport(p);
		} else {
			map.centerAndZoom(new BMap.Point(118.881124,28.943067), 11);
		}
		map.addControl(new BMap.NavigationControl());
		map.setMinZoom(8);
		map.setMaxZoom(30);
		map.enableScrollWheelZoom();

		$('#map div.anchorBL').hide();//隐藏百度地图logo

		map.addOverlay(netPoint); //添加覆盖物

		var overlays = [];

		var overlaycomplete = function(e) {
			//对获取的网格坐标点进行截取
			overlays.push(e.overlay);
			var s = "";
			for (var i = 0; i < overlays[0]._userPoints.length; i++) {
				s += ",[" + overlays[0]._userPoints[i].lng + ","
						+ overlays[0]._userPoints[i].lat + "]";
			}
			s = s.substring(1);
			//将获得的坐标点放入文本框
			document.getElementById("pointSet").value = s;
		};
		var styleOptions = {
			strokeColor : "red", //边线颜色。
			fillColor : "red", //填充颜色。当参数为空时，圆形将没有填充效果。
			strokeWeight : 3, //边线的宽度，以像素为单位。
			strokeOpacity : 0.8, //边线透明度，取值范围0 - 1。
			fillOpacity : 0.6, //填充的透明度，取值范围0 - 1。
			strokeStyle : 'solid' //边线的样式，solid或dashed。
		}
		//实例化鼠标绘制工具
		var drawingManager = new BMapLib.DrawingManager(map, {
			isOpen : false, //是否开启绘制模式
			enableDrawingTool : true, //是否显示工具栏
			drawingToolOptions : {
				anchor : BMAP_ANCHOR_TOP_RIGHT, //位置
				offset : new BMap.Size(5, 5), //偏离值
				drawingModes : [ BMAP_DRAWING_POLYGON ]
			},
			circleOptions : styleOptions, //圆的样式
			polylineOptions : styleOptions, //线的样式
			polygonOptions : styleOptions, //多边形的样式
			rectangleOptions : styleOptions
		//矩形的样式
		});
		//添加鼠标绘制工具监听事件，用于获取绘制结果
		drawingManager.addEventListener('overlaycomplete', overlaycomplete);

		function showPosition(type) {
			var url = "";
			var id = '#' + type;
			var v = $(id).val();
			if (v == '' || v == null) {
				return false;
			}
			if (type == 'town') {
				url = "BaseInfo/Town/getTown?id=" + v;
			} else if (type == 'village') {
				url = "BaseInfo/Village/getVillage?id=" + v;
			} else if (type == 'nVillage') {
				url = "BaseInfo/Nvillage/getNvillage?id=" + v;
			}
			if (v != null && v != '') {
				sendAjax(url, {}, function(json) {
					if (json != null && json.longitude != ''
							&& json.longitude != null
							&& typeof (json.longitude) != "undefined"
							&& json.latitude != '' && json.latitude != null
							&& typeof (json.latitude) != "undefined") {

						map.centerAndZoom(new BMap.Point(json.longitude,
								json.latitude), 16);
					}
				});
			}
		}
		function remove_overlay() {
			map.clearOverlays();
			s = "";
			overlays = [];
			document.getElementById("pointSet").value = s;

		}

		function chanegePosition() {
			map.removeOverlay(marker);
			var lat = $("#lat").val();
			var lng = $("#lng").val();
			if (lat != null && lat != '' && lng != null && lng != '') {
				var point = new BMap.Point(lng, lat);
				marker = new BMap.Marker(point);// 创建标注
				marker.enableDragging();
				map.addOverlay(marker);// 将标注添加到地图中
				map.centerAndZoom(new BMap.Point(lng, lat), 19);//定位			    		
			}
		}
		$(function() {
			$('a[drawingtype="hander"]').removeClass("BMapLib_hander")
					.addClass("BMapLib_hander_hover");
		})
	</script>
</body>
</html>