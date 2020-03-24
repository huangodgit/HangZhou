//镇
var townPoint;
//村
var villagePoint = [];
//统计图标
var chartPoint = [];
//网格
var netPoint = [];
//民宿
var minsuPoint = [];
//环保
var huanbaoPoint = [];
//安监
var anjianPoint = [];
//重点
var zhongdianPoint = [];
//屋主
var housePoint = [];
//企业
var enterprisePoint = [];

var warrningPoint = [];

//镇是否显示
var isshownTown =  false;
//村是否显示
var isshownVillage = false;
//统计图标是否显示
var isshownChart = false;
//网格是否显示
var isshownNet = false;
//民宿是否显示
var isshownMinsu = false;
//环保是否显示
var isshownHuanbao = false;
//安监是否显示
var isshownAnjian = false;
//屋主是否显示
var isshownHouse=false;
//企业是否显示
var isshownEnterprise=false;

var isshownWarrning=false;

var infoStartStr="<iframe src='";
var infoEndStr=".html' width='620' height='360' frameborder=0></iframe>";
var pageName="musu";

var villageDetailInfo=infoStartStr+"villagedetail"+infoEndStr;

var net = ["119.416266686725,29.9085795385987;119.410230008016,29.9120056696323;119.405630633761,29.9101991788664;119.401462450843,29.906586099038;119.400168876834,29.8998579460089","119.400168876834,29.8998579460089;119.405630633761,29.8973036207826;119.412242234252,29.8979266329728;119.41454192138,29.9054024754237;119.416266686725,29.9085795385987",
"119.478645700054,29.9528609802901;119.470740525554,29.949747599031;119.467290994863,29.9435205440794;119.464991307736,29.9359230090811;119.465997420854,29.929819650912;119.473902595354,29.9273283767353;119.482885748195,29.9300064939613","119.482885748195,29.9300064939613;119.487197661559,29.9344906219058;119.4882756399,29.9420882662916;119.485832222327,29.949623061753;119.478645700054,29.9528609802901"];

var netDetailInfo=infoStartStr+"newdetail"+infoEndStr;

var houseDeatal=infoStartStr+"housedetail"+infoEndStr;


var chart_data = [
    [119.422195, 29.947175, "hz-tabs"],
    [119.476704, 29.939758, "hm-tabs"],
    [119.410301, 29.902915, "hm-tabs"]
];

var houseInfo_data=[];

//镇
var town_data = [];
//村
var village_data = [];

var warrningDetail=infoStartStr+"warrningdetail"+infoEndStr;
var warrning_data=[[119.408106, 29.904121, warrningDetail]];

/////////////////////////////////////////////
var PointTools = {
    //码点信息
    minsu_data : [],
    huanbao_data :[],
    anjian_data : [],
    zhongdian_data : [],
    enterprise_data : [],

    //设置信息窗口
    opts : {
        width : 500,     // 信息窗口宽度
        height: 360,     // 信息窗口高度
        title : "信息窗口" , // 信息窗口标题
        enableMessage:false//设置允许信息窗发送短息
    },

    clearPoints:function(){
        if(isshownMinsu){
            //先清理
            for (var i = 0; i < PointTools.minsu_data.length; i++){
                map.removeOverlay(minsuPoint[i]);
            }
        }
        if(isshownHuanbao){
            for (var i = 0; i < PointTools.huanbao_data.length; i++){
                map.removeOverlay(huanbaoPoint[i]);
            }
        }
        if(isshownAnjian){
            for (var i = 0; i < PointTools.anjian_data.length; i++){
                map.removeOverlay(anjianPoint[i]);
            }

        }
        if(isshownHouse){
            for (var i = 0; i < houseInfo_data.length; i++){
                map.removeOverlay(housePoint[i]);
            }
        }
        if(isshownEnterprise){
        	 for (var i = 0; i < PointTools.enterprise_data.length; i++){
                 map.removeOverlay(enterprisePoint[i]);
             }
        }
        if(isshownWarrning){
            for (var i = 0; i < PointTools.warrning_data.length; i++){
                map.removeOverlay(warrningPoint[i]);
            }
        }
    },
    reloadPoints:function(type){
        if(type=="minsu" && isshownMinsu){
            //重画
            for (var i = 0; i < PointTools.minsu_data.length; i++) {        
                var myIcon = new BMap.Icon("images/minsu.png", new BMap.Size(32,32));
                var pt = new BMap.Point(PointTools.minsu_data[i][0], PointTools.minsu_data[i][1]);
                var content = PointTools.minsu_data[i][2];
                minsuPoint[i] = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
                map.addOverlay(minsuPoint[i]);      // 将标注添加到地图中
                addClickHandler(content,minsuPoint[i]);
            }
        }
        if(type=="huanbao" && isshownHuanbao){
            for (var i = 0; i < PointTools.huanbao_data.length; i++) {        
                var myIcon = new BMap.Icon("images/huanbao.png", new BMap.Size(32,32));
                var pt = new BMap.Point(PointTools.huanbao_data[i][0], PointTools.huanbao_data[i][1]);
                var content = PointTools.huanbao_data[i][2];
                huanbaoPoint[i] = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
                map.addOverlay(huanbaoPoint[i]);      // 将标注添加到地图中
                addClickHandler(content,huanbaoPoint[i]);
            }
        }
        if(type=="anjian" && isshownAnjian){
            for (var i = 0; i < PointTools.anjian_data.length; i++) {        
                var myIcon = new BMap.Icon("images/anjian.png", new BMap.Size(32,32));
                var pt = new BMap.Point(PointTools.anjian_data[i][0], PointTools.anjian_data[i][1]);
                var content = PointTools.anjian_data[i][2];
                anjianPoint[i] = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
                map.addOverlay(anjianPoint[i]);      // 将标注添加到地图中
                addClickHandler(content,anjianPoint[i]);
            }

        }
        if(type=="house" && isshownHouse){
            for (var i = 0; i < houseInfo_data.length; i++) {        
                var myIcon = new BMap.Icon("images/house.png", new BMap.Size(32,32));
                var pt = new BMap.Point(houseInfo_data[i][0], houseInfo_data[i][1]);
                var content = houseInfo_data[i][2];
                housePoint[i] = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
                map.addOverlay(housePoint[i]);      // 将标注添加到地图中
                addClickHandler(content,housePoint[i]);
            }
        }
        if(type=="warrning" && isshownWarrning){
            for (var i = 0; i < PointTools.warrning_data.length; i++) {        
                var myIcon = new BMap.Icon("images/warrning.gif", new BMap.Size(50,50));
                var pt = new BMap.Point(PointTools.warrning_data[i][0], PointTools.warrning_data[i][1]);
                var content = PointTools.warrning_data[i][2];
                warrningPoint[i] = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
                map.addOverlay(warrningPoint[i]);      // 将标注添加到地图中
                addClickHandler(content,warrningPoint[i]);
            }
        }
        if(type=="enterprise" && isshownEnterprise){
            for (var i = 0; i < PointTools.enterprise_data.length; i++) {        
                var myIcon = new BMap.Icon("images/enterprise.png", new BMap.Size(32,32));
                var pt = new BMap.Point(PointTools.enterprise_data[i][0], PointTools.enterprise_data[i][1]);
                var content = PointTools.enterprise_data[i][2];
                enterprisePoint[i] = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
                map.addOverlay(enterprisePoint[i]);      // 将标注添加到地图中
                addClickHandler(content,enterprisePoint[i]);
            }

        }
    },
    
    loadTownAndVillagePoints:function(type){
    	if(type=="town"){
            if(town_data[0] != null && town_data[1] != null){
            	var myIcon = new BMap.Icon("images/town.png", new BMap.Size(32,32));
	            var pt = new BMap.Point(town_data[0], town_data[1]);
	            var content = town_data[2];
	            townPoint = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
				map.centerAndZoom(pt, 13);
	            map.addOverlay(townPoint);      // 将标注添加到地图中
	            addClickHandler(content,townPoint);
            }
        }
        if(type=="village"){
            for (var i = 0; i < village_data.length; i++) {        
                if(village_data[i][0] != null && village_data[i][1] != null){
                	var myIcon = new BMap.Icon("images/village.png", new BMap.Size(32,32));
	                var pt = new BMap.Point(village_data[i][0], village_data[i][1]);
	                var content = village_data[i][2];
	                villagePoint[i] = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
	                map.addOverlay(villagePoint[i]);      // 将标注添加到地图中
	                addClickHandler(content,villagePoint[i]);
                }
            }
        }
    },
    
    //获取码点信息并添加到地图上
    showPoint : function(point_data, pointKind){
        switch(pointKind){
            case "minsu":
                if(isshownMinsu==false){
                    for (var i = 0; i < point_data.length; i++) {        
                        var myIcon = new BMap.Icon("images/"+pointKind+".png", new BMap.Size(32,32));
                        var pt = new BMap.Point(point_data[i][0], point_data[i][1]);
                        var content = point_data[i][2];
                        minsuPoint[i] = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
                        map.addOverlay(minsuPoint[i]);      // 将标注添加到地图中
                        addClickHandler(content,minsuPoint[i]);
                        
                    }
                    isshownMinsu = true;
                    break;
                }else{
                    for (var i = 0; i < point_data.length; i++){
                        map.removeOverlay(minsuPoint[i]);
                    }
                    isshownMinsu=false;
                    break;
                }
            case "huanbao":
                if(isshownHuanbao==false){
                    for (var i = 0; i < point_data.length; i++) {        
                        var myIcon = new BMap.Icon("images/"+pointKind+".png", new BMap.Size(32,32));
                        var pt = new BMap.Point(point_data[i][0], point_data[i][1]);
                        var content = point_data[i][2];
                        huanbaoPoint[i] = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
                        map.addOverlay(huanbaoPoint[i]);      // 将标注添加到地图中
                        addClickHandler(content,huanbaoPoint[i]);
                        
                    }
                    isshownHuanbao = true;
                    break;
                }else{
                    for (var i = 0; i < point_data.length; i++){
                        map.removeOverlay(huanbaoPoint[i]);
                    }
                    isshownHuanbao=false;
                    break;
                }
            case "anjian":
                if(isshownAnjian==false){
                    for (var i = 0; i < point_data.length; i++) {        
                        var myIcon = new BMap.Icon("images/"+pointKind+".png", new BMap.Size(32,32));
                        var pt = new BMap.Point(point_data[i][0], point_data[i][1]);
                        var content = point_data[i][2];
                        anjianPoint[i] = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
                        map.addOverlay(anjianPoint[i]);      // 将标注添加到地图中
                        addClickHandler(content,anjianPoint[i]);
                        
                    }
                    isshownAnjian = true;
                    break;
                }else{
                    for (var i = 0; i < point_data.length; i++){
                        map.removeOverlay(anjianPoint[i]);
                    }
                    isshownAnjian=false;
                    break;
                }
            case "house":
            	map.setMapType(BMAP_HYBRID_MAP);//切换到卫星图层
            	if(map.getZoom()!=18) {
            		map.centerAndZoom(map.getBounds().getCenter(),18);
            	}
                if(isshownHouse==false){
                    for (var i = 0; i < point_data.length; i++) {        
                        var myIcon = new BMap.Icon("images/"+pointKind+".png", new BMap.Size(32,32));
                        var pt = new BMap.Point(point_data[i][0], point_data[i][1]);
                        var content = point_data[i][2];
                        housePoint[i] = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
                        map.addOverlay(housePoint[i]);      // 将标注添加到地图中
                        addClickHandler(content,housePoint[i]);
                        
                    }
                    isshownHouse = true;
                    break;
                }else{
                    for (var i = 0; i < point_data.length; i++){
                        map.removeOverlay(housePoint[i]);
                    }
                    isshownHouse=false;
                    break;
                }
            case "warrning":
                if(isshownWarrning==false){
                    for (var i = 0; i < point_data.length; i++) {        
                        var myIcon = new BMap.Icon("images/"+pointKind+".gif", new BMap.Size(50,50));
                        var pt = new BMap.Point(point_data[i][0], point_data[i][1]);
                        var content = point_data[i][2];
                        warrningPoint[i] = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
                        map.addOverlay(warrningPoint[i]);      // 将标注添加到地图中
                        addClickHandler(content,warrningPoint[i]);
                        
                    }
                    isshownWarrning = true;
                    break;
                }else{
                    for (var i = 0; i < point_data.length; i++){
                        map.removeOverlay(warrningPoint[i]);
                    }
                    isshownWarrning=false;
                    break;
                }
            case "enterprise":
                if(isshownEnterprise==false){
                    for (var i = 0; i < point_data.length; i++) {        
                        var myIcon = new BMap.Icon("images/"+pointKind+".png", new BMap.Size(32,32));
                        var pt = new BMap.Point(point_data[i][0], point_data[i][1]);
                        var content = point_data[i][2];
                        enterprisePoint[i] = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
                        map.addOverlay(enterprisePoint[i]);      // 将标注添加到地图中
                        addClickHandler(content,enterprisePoint[i]);
                        
                    }
                    isshownEnterprise = true;
                    break;
                }else{
                    for (var i = 0; i < point_data.length; i++){
                        map.removeOverlay(enterprisePoint[i]);
                    }
                    isshownEnterprise=false;
                    break;
                }
        }
    },

};

//加载boundary范围内所有的屋主-点信息
function loadFamilyPoints(boundary){
    $.ajax({
            type: "get",
            dataType: "json",
            url: "BaseInfo/Family/listLast",
            //data: "pageIndex=" + pageIndex,
            data:{minX:boundary.getSouthWest().lng,minY:boundary.getSouthWest().lat,maxX:boundary.getNorthEast().lng,maxY:boundary.getNorthEast().lat},
            crossDomain: true,  
            success: function(msg){//msg为返回的数据，在这里做数据绑定
				for(var i=0;i<msg.length;i++){
					var pointinfo=msg[i];
					houseInfo_data[i]=[pointinfo.longitude,pointinfo.latitude,pointinfo.content];
				}
                //加载后，描点 if needed
                PointTools.reloadPoints("house");
            }
        });
}

//加载boundary范围内所有的镇村-点信息
function loadTownAndVillagePoints(townName){
    $.ajax({
            type: "get",
            dataType: "json",
            url: "BaseInfo/Town/listLast",
            data:{townName:townName},
            crossDomain: true,  
            success: function(msg){//msg为返回的数据，在这里做数据绑定
				if(msg != null){
	            	var pointinfo = msg;
					town_data=[pointinfo.longitude,pointinfo.latitude,pointinfo.content];
					//加载后，描点 if needed
	                PointTools.loadTownAndVillagePoints("town");
                }
            },
        });
    $.ajax({
        type: "get",
        dataType: "json",
        url: "BaseInfo/Village/listLast",
        data:{townName:townName},
        crossDomain: true,  
        success: function(msg){//msg为返回的数据，在这里做数据绑定
        	if(msg !=null){
				for(var i=0;i<msg.length;i++){
					var pointinfo=msg[i];
					village_data[i]=[pointinfo.longitude,pointinfo.latitude,pointinfo.content];
				}
	            //加载后，描点 if needed
	            PointTools.loadTownAndVillagePoints("village");
        	}else{
        		alert("没有录入此镇或者还没有录入此镇的村数据！");
        	}
        }
    });
}

//加载boundary范围内 除 屋主外的点信息
function loadOther15LevelPoints(boundary){
	$.ajax({
		type: "get",
		dataType: "json",
		url: "Geography/EnvironmentMonitor/listLast",
		//data: "pageIndex=" + pageIndex,
		data:{minX:boundary.getSouthWest().lng,minY:boundary.getSouthWest().lat,maxX:boundary.getNorthEast().lng,maxY:boundary.getNorthEast().lat},
		crossDomain: true,  
		success: function(msg){//msg为返回的数据，在这里做数据绑定
			for(var i=0;i<msg.length;i++){
				var pointinfo=msg[i];
				PointTools.huanbao_data[i]=[pointinfo.longitude,pointinfo.latitude,pointinfo.content];
			}
            PointTools.reloadPoints("huanbao");
		}
	});
	$.ajax({
		type: "get",
		dataType: "json",
		url: "Geography/Homestay/listLast",
		//data: "pageIndex=" + pageIndex,
		data:{minX:boundary.getSouthWest().lng,minY:boundary.getSouthWest().lat,maxX:boundary.getNorthEast().lng,maxY:boundary.getNorthEast().lat},
		crossDomain: true,  
		success: function(msg){//msg为返回的数据，在这里做数据绑定
			for(var i=0;i<msg.length;i++){
				var pointinfo=msg[i];
				PointTools.minsu_data[i]=[pointinfo.longitude,pointinfo.latitude,pointinfo.content];
			}
            PointTools.reloadPoints("minsu");
		}
	});
	$.ajax({
		type: "get",
		dataType: "json",
		url: "Geography/SafetyMonitor/listLast",
		//data: "pageIndex=" + pageIndex,
		data:{minX:boundary.getSouthWest().lng,minY:boundary.getSouthWest().lat,maxX:boundary.getNorthEast().lng,maxY:boundary.getNorthEast().lat},
		crossDomain: true,  
		success: function(msg){//msg为返回的数据，在这里做数据绑定
//                var data = msg.villageName;
			for(var i=0;i<msg.length;i++){
				var pointinfo=msg[i];
				PointTools.anjian_data[i]=[pointinfo.longitude,pointinfo.latitude,pointinfo.content];
			}
            PointTools.reloadPoints("anjian");
		}
	});
	$.ajax({
		type: "get",
		dataType: "json",
		url: "BaseInfo/Enterprise/listLast",
		//data: "pageIndex=" + pageIndex,
		data:{minX:boundary.getSouthWest().lng,minY:boundary.getSouthWest().lat,maxX:boundary.getNorthEast().lng,maxY:boundary.getNorthEast().lat},
		crossDomain: true,  
		success: function(msg){//msg为返回的数据，在这里做数据绑定
			for(var i=0;i<msg.length;i++){
				var pointinfo=msg[i];
				PointTools.enterprise_data[i]=[pointinfo.longitude,pointinfo.latitude,pointinfo.content];
			}
			PointTools.reloadPoints("enterprise");
		}
	});
}
//清理屋主信息点
function clearFamilyPonts(){
	houseInfo_data=[];
}
//清理除family外的所有点
function clearOther15LevelPoints(){
	minsu_data=[];
    huanbao_data=[];
    anjian_data=[];
//    zhongdian_data= [];
}

//add by surya 20150627
//all points objects load funcs called here
function loadAllPoints(){
	//重新加载前，清理
	PointTools.clearPoints();
	
	var boundary=map.getBounds();
	if(mapLevel>=12){
		loadOther15LevelPoints(boundary);
	}
	else{
		clearOther15LevelPoints();
	}
	if(mapLevel>=18){
		loadFamilyPoints(boundary);
	}
	else{
		clearFamilyPonts();
	}
}
//zoom event handler
function zoomHandler(){
	var currentLevel=map.getZoom();
	if(mapLevel!=currentLevel){
		mapLevel=currentLevel;
		//loadAllPoints();
	}

}
function moveendHandler(){
	//loadAllPoints();
}
//function dragendHandler(){
//	alert("dragendHandler");
//	loadAllPoints();
//}
//点击事件
function addClickHandler(content,marker){

    marker.addEventListener("click",function(e){
        
        openWindow(content,e);
    });
}

//打开信息窗口
function openWindow(content,e){
    // var p = e.target;
    // var point = new BMap.Point(p.getPosition().lng, p.getPosition().lat);
    var point=e.point;
    var infoWindow = new BMap.InfoWindow(content,this.opts);  // 创建信息窗口对象
    //var infoWindow = new BMap.InfoWindow(content);  // 创建信息窗口对象 
    map.openInfoWindow(infoWindow,point); //开启信息窗口
}

//添加村的边界（自定义边界）
/*function getVillage(){
    map.centerAndZoom(new BMap.Point(119.452949, 29.93292), minLevel+2);
    if(isshownVillage==false){
    	getTown();
        for(var i=0;i<fenshui.length;i++){
            villagePoint[i] = new BMap.Polygon(fenshui[i], {strokeWeight:2, strokeColor:"#ff0000", fillColor:""}); //建立多边形覆盖物
            addClickHandler(villageDetailInfo,villagePoint[i]);
            map.addOverlay(villagePoint[i]);  //添加覆盖物
        }
        isshownVillage = true;
        getChart(chart_data, "tongji");
    }else{
    	getTown();
        for (var i = 0; i < villagePoint.length; i++) {
            map.removeOverlay(villagePoint[i]);
        }
        isshownVillage=false;
        getChart(chart_data, "tongji");
    }
}*/

//添加网格（自定义边界）
function getNet(){
    map.centerAndZoom(new BMap.Point(119.452949, 29.93292), minLevel+3);
    if(isshownNet==false){
        for(var i=0;i<net.length;i++){
            netPoint[i] = new BMap.Polygon(net[i], {strokeWeight:2, strokeColor:"#0075C7", fillColor:"#FFFFFF", fillOpacity:0.5}); //建立多边形覆盖物
            addClickHandler(netDetailInfo,netPoint[i]);
            map.addOverlay(netPoint[i]);  //添加覆盖物
        }
        isshownNet = true;
    }else{
        for (var i = 0; i < netPoint.length; i++) {
            map.removeOverlay(netPoint[i]);
        }
        isshownNet=false;
    }
}

//移除所有覆盖物
function clearAllOverlays(){
    map.clearOverlays();
}

//全局
function viewGlobal(){
    // 定位到地图中心点
    map.centerAndZoom(new BMap.Point(centX, centY), minLevel);
    //显示行政区域
    getBoundary();

}

//添加行政区划（请自行修改城市名称）
//"桐庐县"固定死就能获取桐庐边界，最小只能到县
function getBoundary(){
    var bdary = new BMap.Boundary();
    bdary.get("衢州市", function(rs){   //获取行政区域
        map.clearOverlays();        //清除地图覆盖物
        var count = rs.boundaries.length; //行政区域的点有多少个
        for(var i = 0; i < count; i++){
            var ply = new BMap.Polygon(rs.boundaries[i], {strokeWeight:3, strokeColor:"#ff0000", fillColor:""}); //建立多边形覆盖物
            ply.disableMassClear();  //禁止覆盖物在map.clearOverlays方法中被清除
            map.addOverlay(ply);  //添加覆盖物
            //map.setViewport(ply.getPath());    //调整视野
        }
    });
    
}

//添加镇界
/*function getTown(){
	if(isshownTown==false){
	    for(var i=0;i<fenshuiTown.length;i++){
	        townPoint[i] = new BMap.Polygon(fenshuiTown[i], {strokeWeight:2, strokeColor:"#00ff00", fillColor:""}); //建立多边形覆盖物
	        map.addOverlay(townPoint[i]);  //添加覆盖物
	    }
	    isshownTown = true;
	}else{
		for (var i = 0; i < townPoint.length; i++) {
            map.removeOverlay(townPoint[i]);
        }
        isshownTown=false;
	}
}*/

//添加统计图标
function getChart(point_data, pointKind){
    if(isshownChart==false){
        for (var i = 0; i < point_data.length; i++) {        
            var myIcon = new BMap.Icon("images/"+pointKind+".png", new BMap.Size(32,32));
            var pt = new BMap.Point(point_data[i][0], point_data[i][1]);
            var content = point_data[i][2];
            chartPoint[i] = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
            map.addOverlay(chartPoint[i]);      // 将标注添加到地图中

            addClickHandler2(content,chartPoint[i]);
        }
        isshownChart = true;
    }else{
        for (var i = 0; i < chartPoint.length; i++) {
            map.removeOverlay(chartPoint[i]);
        }
        isshownChart = false;
    }
}

//点击事件
function addClickHandler2(content,marker){
    marker.addEventListener("click",function(e){
        viewMsg('id','统计信息',content+'.html');
		
    });
}

function getTownAndVillage(townName){
	map.clearOverlays();
	loadTownAndVillagePoints(townName);
}