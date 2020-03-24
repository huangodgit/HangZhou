<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta/>
		<title>华数桐庐-智慧农村-</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		
		<s:include value="/common/include1.jsp"></s:include>
		

		<style>
			/* some elements used in demo only */
			.spinner-preview {
				width: 100px;
				height: 100px;
				text-align: center;
				margin-top: 60px;
			}
			
			.dropdown-preview {
				margin: 0 5px;
				display: inline-block;
			}
			.dropdown-preview  > .dropdown-menu {
				display: block;
				position: static;
				margin-bottom: 5px;
			}
		</style>
	</head>

	<body >
					
					<div class="breadcrumbs" id="breadcrumbs">
						<ul class="breadcrumb">
							<%
							    String mapUrl = request.getParameter("mapUrl");
							    String menuTitle = request.getParameter("menuTitle");
							    if(mapUrl != null){ %>
			<li><i class="icon-home home-icon"></i> <a
				onclick="changeLeftPage('<%= mapUrl %>')"><%= menuTitle %></a></li>
			<% }else{ %>
			<li><i class="icon-home home-icon"></i> <a href="mainmap.jsp">主页</a>
			</li>
			<% } %>
							<li class="active">地图</li>
						</ul>				
					</div>
					
					<div class="page-content" style="padding:0px 15px;">
						<div class="row" >
							<div class="col-xs-12"  >
								<!-- PAGE CONTENT BEGINS -->

								<div class="row"  >
									
											<div id="allmap" style="height: 700px;position: relative;">
											</div>
											<div class='MoreInfoTool'>
												<div class="all_F" style="display:none;">
												<!-- <div class="map_F"><img src="images/map_10.png" usemap="#Map" border="1"/> -->
													<map name="Map">
														<area shape="poly" coords="51,22,60,26,64,34,65,49,60,56,62,62,54,68,54,75,49,80,39,68,31,71,27,67,35,59,30,52,19,44,27,44,33,42,48,44,47,30" href="javascript:void(0);" onclick="getTownAndVillage('分水镇')">
														<area shape="poly" coords="64,38,70,38,72,47,85,52,88,58,83,61,83,68,76,68,77,76,70,73,65,84,58,82,53,93,48,87,48,79,56,74,55,67,59,62,60,55,65,47,64,36" href="javascript:void(0);" onclick="getTownAndVillage('瑶琳镇')">
														<area shape="poly" coords="111,73,115,70,120,66,123,67,128,70,131,74,135,76,138,76,137,81,135,85,128,85,120,82,113,79" href="javascript:void(0);" onclick="getTownAndVillage('江南镇')"/>
      													<area shape="poly" coords="78,98,81,96,86,95,92,91,92,101,94,108,100,102,112,104,113,112,118,117,117,127,108,127,101,132,95,118,85,117" href="javascript:void(0);" onclick="getTownAndVillage('富春江镇')"/>
      													<area shape="poly" coords="19,41,22,46,25,51,30,54,34,57,31,65,18,71,2,74,12,64,5,61,2,53,16,54,14,44" href="javascript:void(0);" onclick="getTownAndVillage('合村乡')"/>
      													<area shape="poly" coords="2,75,28,68,38,68,49,79,35,105,22,103,24,92,18,89,19,80,10,81,4,80" href="javascript:void(0);" onclick="getTownAndVillage('百江镇')" />
      													<area shape="poly" coords="47,85,53,91,60,82,67,87,75,95,62,104,52,100,45,100,41,94" href="javascript:void(0);" onclick="getTownAndVillage('钟山乡')" />
      													<area shape="poly" coords="66,83,73,83,80,87,75,92,70,87,70,86" onclick="getTownAndVillage('莪山畲族乡')" /> 
      													<area shape="poly" coords="64,82,71,73,77,75,76,69,82,67,83,62,92,56,97,60,95,71,89,82,84,81,81,87,75,83,70,82" href="javascript:void(0);" onclick="getTownAndVillage('横村镇')" />
      													<area shape="poly" coords="76,90,80,90,83,85,84,81,88,81,99,67,103,72,114,70,107,78,113,85,113,93,111,103,101,101,94,108,93,90,76,96" href="javascript:void(0);" onclick="getTownAndVillage('桐君街道')"/>
      													<area shape="poly" coords="107,77,113,85,113,94,112,104,115,113,120,118,129,113,130,101,139,97,133,90,120,83" href="javascript:void(0);" onclick="getTownAndVillage('凤川街道')" />
      													<area shape="poly" coords="128,112,130,104,139,95,144,107,148,104,155,109,147,114,139,115" href="javascript:void(0);" onclick="getTownAndVillage('新合乡')" />
													</map></div>
												</div>
												
											<!-- 	<div class="all_TOWN" style="display:none;">
													<div class="dropdown dropdown-preview">
														<ul class="dropdown-menu dropdown-purple" id="towndatas">
														</ul>
													</div>
												</div> -->

												<div class="search_F" style="display:none;">
													<div class="searchcontent_F">
														<div class="search_frame">
															<div class="search_frame_left">
															<input type="text" name="searchtext" id="searchtext" class="search_input"/></div>
															<div class="search_frame_right">
															<a href="#" onclick="searchByStationName();"><img src="images/nav_12.png" border="0" /></a>
															</div>
														</div>
														<div class="dw_F" id="dw_F_id">
														</div>
														<div class="dw_F2">
														<div class="page_no">1</div>
															<div class="page_F" ><a href="#" class="cblue">2</a></div>
															<div class="page_F" ><a href="#" class="cblue">3</a></div>
															<div class="page_F" ><a href="#" class="cblue">4</a></div>
															<div class="page_next" ><a href="#" class="cblue">下一页></a></div>
														</div>
													</div> 
												<!--  search_F-->
											</div>
									</div>

								</div><!-- /row -->

								<!-- PAGE CONTENT ENDS -->
							</div><!-- /.col -->
						</div><!-- /.row -->
					</div><!-- /.page-content -->
				</div><!-- /.main-content -->

		</div><!-- /.main-container -->

		<!-- basic scripts -->

		<script>
				var isOffline=0;
				var sateLayerAdded=0;
				//var levelNumber=12;
				var tileLayer = new BMap.TileLayer();
				var satelliteLayer = new BMap.TileLayer();
				var pointTools=Object.create(PointTools); 
				//default level 11
				var mapLevel=11;
				var locationPoints;

				tileLayer.getTilesUrl = function(tileCoord, zoom) {
				    var x = tileCoord.x;
				    var y = tileCoord.y;
				    var url = outputPath + zoom + '/' + x + '/' + y + format;

				    return url;
				}
				var MyMap = new BMap.MapType('MyMap', tileLayer, {minZoom: minLevel, maxZoom: maxLevel});

				
				satelliteLayer.getTilesUrl = function(tileCoord, zoom) {
				    var x = tileCoord.x;
				    var y = tileCoord.y;
				    var url = outputPath+ 'sate/' + zoom + '/' + x + '/' + y + '.jpeg';
				    return url;
				}
				var map;
				if(isOffline){
					map = new BMap.Map('allmap', {mapType: MyMap});
				}
				else{
					map = new BMap.Map('allmap', {mapType: BMAP_NORMAL_MAP});//BMAP_SATELLITE_MAP
				}				
				var localSearch = new BMap.LocalSearch(map, {renderOptions:{map: map, autoViewport: true} });
				// map.addTileLayer(satelliteLayer);
				// sateLayerAdded=1;

				var searchResultOverlay=new Array();

	    		function initBDMap(){
		    		// 定位到地图中心点
					map.centerAndZoom(new BMap.Point(centX, centY), minLevel);
					// 添加导航控件
					map.addControl(new BMap.NavigationControl()); 
					// 添加比例尺控件
					//map.addControl(new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT}));

					//添加地图类型控件
					//map.addControl(new BMap.MapTypeControl({anchor: BMAP_ANCHOR_TOP_RIGHT}));   
                    map.addControl(new BMap.MapTypeControl({anchor: BMAP_ANCHOR_TOP_RIGHT,mapTypes: [BMAP_NORMAL_MAP,BMAP_HYBRID_MAP]}));   
					
                    var oveCtrl = new BMap.OverviewMapControl({anchor:BMAP_ANCHOR_BOTTOM_LEFT,isOpen:1});
					map.addControl(oveCtrl);
                    
                    // 创建控件
					var myJDNavigationCtl = new JDNavigationControl();
					// 添加到地图当中
					map.addControl(myJDNavigationCtl);   

					var myJDSearchCtl = new JDSearchControl();
					map.addControl(myJDSearchCtl);    

				/* 	var myJDLayerCtl = new JDLayerControl();
					map.addControl(myJDLayerCtl);    */   
					// 启用滚轮放大缩小
					map.enableScrollWheelZoom();
					// 启用键盘操作
					map.enableKeyboard();

					//map.addEventListener('click',sateHandler);
					map.addEventListener('zoomend',zoomHandler);  
					map.addEventListener('moveend',moveendHandler);  
					//map.addEventListener('dragend',dragendHandler);  

		    		localSearch.enableAutoViewport(); //允许自动调节窗体大小
		    		getBoundary();//定位中心点到衢州市
	    		}
	    		function sateHandler(e){
					var content="<br/><br/>经度：" + e.point.lng + "<br/>纬度：" + e.point.lat;
					infoWinOpts = {width:200, height:100}
        			infoWin = new BMap.InfoWindow("<div id='zn' name='zn' style='text-align:left;margin-top:3px;font-size:15;color:#1A6DAF'>"+content+"</div>",infoWinOpts);
        			map.openInfoWindow(infoWin,e.point);
	    		}

	    		function clearArrayOverlays(overlayArray){
	    			while(overlayArray.length>1){
	    				var overLay=overlayArray.pop();
	    				map.removeOverlay(overLay);
	    			}
	    		}

				function searchByStationName() {
				    // map.clearOverlays();
				    localSearch.clearResults();
				    var keyword = document.getElementById("searchtext").value;
				    //alert(keyword);
				    localSearch.setSearchCompleteCallback(function (searchResult) {
				     //    var poi = searchResult.getPoi(0);
				     //    document.getElementById("result_").value = poi.point.lng + "," + poi.point.lat;
				     //    map.centerAndZoom(poi.point, 13);
				     //    var marker = new BMap.Marker(new BMap.Point(poi.point.lng, poi.point.lat));  // 创建标注，为要查询的地方对应的经纬度
				     //    map.addOverlay(marker);
				     //    var content = document.getElementById("text_").value + "<br/><br/>经度：" + poi.point.lng + "<br/>纬度：" + poi.point.lat;
				     //    var infoWindow = new BMap.InfoWindow("<p style='font-size:14px;'>" + content + "</p>");
				     //    marker.addEventListener("click", function () { this.openInfoWindow(infoWindow); });
				     //    // marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画


				          //可以得到搜索结果且搜索结果不为空 
				        var html="";
				        //遍历结果第一页的点，自定义结果面板
				        for (var i = 0; i < searchResult.getCurrentNumPois(); i++){  
				            var poi = searchResult.getPoi(i);
			                // title[i] = poi.title;
			                // if(poi.address)
			                //     address[i] = poi.address;
			                // if(poi.phoneNumber)
			                //     telephone[i] = poi.phoneNumber;
			                html="<div class='dw_arrow' id='dw_arrow_"+i+"'><a href='#'><img src='images/nav_16.png' border='0' /></a></div><div class='dw_text'>";
			                html+="<a href='#'>"+poi.title+"</a></div>";

			                var div = document.createElement("div");
							div.innerHTML=html;
							div.onclick = function(e){
								var marker = new BMap.Marker(new BMap.Point(poi.point.lng, poi.point.lat)); 
								//searchResultOverlay.push(marker);
								map.addOverlay(marker);
								var content = poi.title;
								var infoWindow = new BMap.InfoWindow("<p style='font-size:14px;'>" + content + "</p>");
								map.openInfoWindow(infoWindow,poi.point);
							}

							var dw_F=document.getElementById("dw_F_id");
							dw_F.appendChild(div);

							if(i>2){
								break;
							}
			            }        
				    });

				    localSearch.search(keyword);
				}

				function getvalue(name){
					var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)","i");
					var r = window.location.search.substr(1).match(reg);
					if (r!=null) return (r[2]); return null;
				}
				function lacationPoint(){
					//经纬
					var longitude=getvalue("longitude");
					var latitude=getvalue("latitude");
					//操作类型
					var operation=getvalue("operation");
					//数据类型
					var type=getvalue("pointtype");
					var id=getvalue("id");
					if(operation!=null && operation!=""){
						if(operation=="locationpoint"){
							var pt=new BMap.Point(longitude,latitude);
							map.centerAndZoom(pt,18);
							map.setMapType(BMAP_HYBRID_MAP);
							var myIcon = new BMap.Icon("images/"+type+".png", new BMap.Size(32,32));
							var url="";
							if(type=='house'){
								url="BaseInfo/Family/pointView";
							}else if (type=='town'){
								url="BaseInfo/Town/pointView";
							}else if (type=='village'){
								var url="";
								if(id=="1"){url="newPage_xlc.html";}
								if(id=="2"){url="newPage_hcc.html";}
								if(id=="4"){url="newPage_hxc.html";}
								if(id=="5"){url="newPage_rqc.html";}
								if(id=="6"){url="newPage_dpc.html";}
								if(id=="7"){url="newPage_ysfc.html";}
								//url="BaseInfo/Village/pointView";
							}else if (type=='nVillage'){
								url="BaseInfo/Nvillage/view";
							} else if (type=='enterprise'){
								url="BaseInfo/Enterprise/pointView";
							}/*else if (type=='minsu'){
								url="Geography/Homestay/pointView";
							}else if(type=='anjian') {
								url="Geography/SafetyMonitor/pointView";
							}else if(type=='huanbao') {
								url="Geography/EnvironmentMonitor/pointView";
							}else if(type=='led') {
								url="Geography/Led/pointView";
							} */
	                        var content ="<iframe src='"+url+"?id="+id+"' width='600' height='400' frameborder=0></iframe>";
	                        var mker = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
	                        map.addOverlay(mker);      // 将标注添加到地图中
	                        addClickHandler(content,mker);
	                        mker.disableMassClear();

	                        locationPoints=mker;
						}

					}
					else{
						if(locationPoints != null){
							locationPoints.enableMassClear();
							map.removeOverlay(locationPoints);
						}
					}
					
				}
		</script>

		<script type="text/javascript">
			jQuery(function($) {
				//地图高度设定，使首页小地图显示完全
				var h=parent.window.innerHeight;
		    	h=h-115;
		    	$("#allmap").height(h);
				//initTownVillage();
				initBDMap();
				//loadAllPoints();
				lacationPoint();
				$("#navi_grid_1,#navi_grid_2,#navi_grid_3,#navi_grid_4,#navi_grid_5,#navi_grid_6,#navi_grid_7,#navi_grid_8,#navi_grid_9").on("click",function(){ 
					var img=$(this).find("img");
					if(img.attr("src").indexOf('nav')>0)
						img.attr("src",img.attr("src").replace("nav","hover"));	
					else
						img.attr("src",img.attr("src").replace("hover","nav"));	
				})
			});
			function viewMsg(id,name,url){
				 layer.open({
					type: 2,
					//skin: 'layui-layer-lan',
					title: name,
					fix: false,
					shadeClose: true,
					maxmin: false,
					area: ['1000px', '500px'],
					content: url
				});
			}
			
		/* 	function initTownVillage(){
			 	sendAjax("BaseInfo/Town/getMapAreaData", {}, function(json){
			 		document.getElementById("towndatas").innerHTML=json;
		    	 }); 
			}
			 */
			function showPosition(id,type){
				if(type=='town'){
					url="BaseInfo/Town/getTown?id="+id;
				}else if(type=='village'){
					url="BaseInfo/Village/getVillage?id="+id;
				}else if(type=='nVillage'){
					url="BaseInfo/Nvillage/getNvillage?id="+id;
				}
			    sendAjax(url, {}, function(json){
			    	if(json!=null
			    			&&json.longitude!=''&&json.longitude!=null&&typeof(json.longitude) != "undefined"
			    			&&json.latitude!=''&&json.latitude!=null&&typeof(json.latitude) != "undefined"){
			    		map.centerAndZoom(new BMap.Point(json.longitude, json.latitude), 20);				    		
			    	}
		    	 }); 
			}
			
		 function sendAjax(url, data, callback) {
			 	return $.ajax({
			 		type : "POST",
			 		url : url,
			 		data : data,
			 		dataType : "json",
			 		success : callback
			 	});
			 }

		 function changeLeftPage(url) {
				//var temp = window.parent.document.getElementById("main");
				if (url == "h-rkztfx.html" || url == "h-qyztfx.html") {
					window.parent.document.getElementById("main").setAttribute("height", "1220px");
			      } else {
			    	  window.parent.document.getElementById("main").setAttribute("height", "650px");
			      }
				window.parent.document.getElementById("main").setAttribute("src",url);
			}
		</script>
</body>
</html>

