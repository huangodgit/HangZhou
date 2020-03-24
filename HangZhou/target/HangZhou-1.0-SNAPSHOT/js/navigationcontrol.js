//---------------------------------------------自定义控件---------------------------------------------
// 定义一个控件类,即function
function JDNavigationControl(){
	 // 默认停靠位置和偏移量
	this.defaultAnchor = BMAP_ANCHOR_TOP_RIGHT;
	this.defaultOffset = new BMap.Size(10, 40);
}

// 通过JavaScript的prototype属性继承于BMap.Control
JDNavigationControl.prototype = new BMap.Control();

// 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
// 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
JDNavigationControl.prototype.initialize = function(map){
	// 创建一个DOM元素
	var div = document.createElement("div");
	// 添加文字说明
	div.innerHTML=
		"<div class='nav_F'>"+
			"<div class='nav_F_a' id='allScale'>"+
				"<a><img id='img_all' src='images/nav_1_03.png' border='0' /></a>"+
			"</div>"+
			"<div class='nav_F_c' id='naviDiv'>"+
				"<a><img id='img_menu' src='images/nav_1_04.png' border='0' /></a>"+
			"</div>"+
			/*"<div class='nav_F_c' id='townDiv'>"+
				"<a><img id='img_town' src='images/nav_1_06.png' border='0' /></a>"+
			"</div>"+*/
			"<div class='nav_F_c' id='searchDiv'>"+
			"<a><img id='img_search' src='images/nav_05.png' border='0' /></a>"+
			"</div>"+
		"</div>";
	// 设置样式
	div.style.cursor = "pointer";
	div.style.border = "0px solid gray";
	
	// 绑定事件
	div.onclick = function(e){
		//点击一次放大两级
		//alert('JDNavigationControl clicked'+div.innerHTML);
	};

	// 添加DOM元素到地图中
	map.getContainer().appendChild(div);


	//全局
	var allScaleDiv=document.getElementById("allScale");
	allScaleDiv.onclick = function(e){
		//点击一次放大两级
		if($("#img_all").attr("src")=='images/nav_1_03.png'){
			$("#img_all").attr("src","images/nav_03.png");
		}else{
			$("#img_all").attr("src","images/nav_1_03.png");
			$("#img_menu").attr("src","images/nav_1_04.png");
			$("#img_town").attr("src","images/nav_1_06.png");
			$("#img_search").attr("src","images/nav_05.png");
			$('.all_F').hide();		
			$('.all_TOWN').hide();		
			$('.search_F').hide();
			viewGlobal();
		}
	};

	//区域
	var naviDiv=document.getElementById("naviDiv");
	naviDiv.onclick = function(e){
		//点击一次放大两级
		if($("#img_menu").attr("src")=='images/nav_04.png'){
			$("#img_menu").attr("src","images/nav_1_04.png");
			$('.all_F').hide();		
		}else{
			$("#img_all").attr("src","images/nav_03.png");
			$("#img_menu").attr("src","images/nav_04.png");
			$("#img_town").attr("src","images/nav_1_06.png");
			$("#img_search").attr("src","images/nav_05.png");
			$('.all_F').show();	
			$('.all_TOWN').hide();	
			$('.search_F').hide();
		}
	};
	
	//村镇
	/*var townDiv=document.getElementById("townDiv");
	townDiv.onclick = function(e){
		//点击一次放大两级
		if($("#img_town").attr("src")=='images/nav_06.png'){
			$("#img_town").attr("src","images/nav_1_06.png");
			$('.all_TOWN').hide();		
		}else{
			$("#img_all").attr("src","images/nav_03.png");
			$("#img_menu").attr("src","images/nav_1_04.png");
			$("#img_town").attr("src","images/nav_06.png");
			$("#img_search").attr("src","images/nav_05.png");
			$('.all_TOWN').show();		
			$('.all_F').hide();		
			$('.search_F').hide();
		}
	};
*/
	//搜索
	var searchDiv=document.getElementById("searchDiv");
	searchDiv.onclick = function(e){
		//点击一次放大两级
		if($("#img_search").attr("src")=='images/nav_1_05.png'){
			$("#img_search").attr("src","images/nav_05.png");
			$('.search_F').hide();
			localSearch.clearResults();
		}else{
			$("#img_all").attr("src","images/nav_03.png");
			$("#img_menu").attr("src","images/nav_1_04.png");
			$("#img_town").attr("src","images/nav_1_06.png");
			$("#img_search").attr("src","images/nav_1_05.png");
			$('.all_F').hide();
			$('.all_TOWN').hide();
			$('.search_F').show();
		}
	};
	
	// 将DOM元素返回
	return div;
};

// 定义一个控件类,即function
function JDSearchControl(){
	 // 默认停靠位置和偏移量
	this.defaultAnchor = BMAP_ANCHOR_TOP_RIGHT;
	this.defaultOffset = new BMap.Size(10, 10);
}

// 通过JavaScript的prototype属性继承于BMap.Control
JDSearchControl.prototype = new BMap.Control();

// 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
// 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
JDSearchControl.prototype.initialize = function(map){
	// 创建一个DOM元素
	var div = document.createElement("div");
	// 添加文字说明
	//div.appendChild(document.createTextNode("放大2级"));
	div.innerHTML="";
	 // 设置样式
	div.style.cursor = "pointer";
	div.style.border = "0px solid gray";

	// 绑定事件
	div.onclick = function(e){
		//点击一次放大两级
		alert('JDSearchControl clicked');
	};
	// 添加DOM元素到地图中
	map.getContainer().appendChild(div);
	// 将DOM元素返回
	return div;
};


	// 定义一个控件类,即function
function JDLayerControl(){
	 // 默认停靠位置和偏移量
	this.defaultAnchor = BMAP_ANCHOR_TOP_RIGHT;
	this.defaultOffset = new BMap.Size(40, 290);
}

// 通过JavaScript的prototype属性继承于BMap.Control
JDLayerControl.prototype = new BMap.Control();

// 自定义控件必须实现自己的initialize方法,并且将控件的DOM元素返回
// 在本方法中创建个div元素作为控件的容器,并将其添加到地图容器中
JDLayerControl.prototype.initialize = function(map){
	// 创建一个DOM元素
	var div = document.createElement("div");
	// 添加文字说明
	div.innerHTML=
	 	"<div class='text_navF'>"+
	 		"<div class='text_navtop'></div>"+
	 		"<div class='text_nav_1' id='navi_grid_1'>"+
	 			"<a href='javascript:void(0)'><img src='images/text_nav_15.png' name='picture2' width='125' height='29' border='0' align='middle'  class='pic_down'></a>"+
	 		"</div>"+
	 		"<div class='text_nav_1' id='navi_grid_2'>"+
	 			"<a href='javascript:void(0)' onclick='pointTools.showPoint(pointTools.minsu_data,\"minsu\");'><img src='images/text_nav_16.png' name='picture2' width='125' height='29' border='0' align='middle'  class='pic_down'></a>"+
	 		"</div>"+
	 		"<div class='text_nav_1' id='navi_grid_3'>"+
	 			"<a href='javascript:void(0)' onclick='pointTools.showPoint(pointTools.huanbao_data,\"huanbao\");'><img src='images/text_nav_17.png' name='picture2' width='125' height='29' border='0' align='middle'  class='pic_down'></a>"+
	 		"</div>"+
	 		/*"<div class='text_nav_1' id='navi_grid_5'>"+
	 			"<a href='javascript:void(0)'><img src='images/text_nav_19.png' name='picture2' width='125' height='29' border='0' align='middle'  class='pic_down'></a>"+
	 		"</div>"+*/
	 		/*"<div class='text_nav_1' id='navi_grid_6'>"+
	 			"<a href='javascript:void(0)'><img src='images/text_nav_22.png' name='picture2' width='125' height='29' border='0' align='middle'  class='pic_down' /></a>"+
	 		"</div>"+*/
	 		"<div class='text_nav_1' id='navi_grid_4'>"+
	 			"<a href='javascript:void(0)' onclick='pointTools.showPoint(pointTools.anjian_data,\"anjian\");'><img src='images/text_nav_18.png' name='picture2' width='125' height='29' border='0' align='middle'  class='pic_down'></a>"+
	 		"</div>"+
	 		"<div class='text_nav_1' id='navi_grid_7'>"+
 				"<a href='javascript:void(0)' onclick='pointTools.showPoint(houseInfo_data,\"house\");'><img src='images/text_nav_20.png' name='picture2' width='123' height='29' border='0' align='middle'  class='pic_down'></a>"+
 			"</div>"+
	 		/*"<div class='text_nav_1' id='navi_grid_8'>"+
	 			"<a href='javascript:void(0)' onclick='pointTools.showPoint(warrning_data,\"warrning\");'><img src='images/text_nav_21.png' name='picture2' width='123' height='29' border='0' align='middle'  class='pic_down'></a>"+
	 		"</div>"+*/
 			"<div class='text_nav_1' id='navi_grid_9'>"+
				"<a href='javascript:void(0)' onclick='pointTools.showPoint(pointTools.enterprise_data,\"enterprise\");'><img src='images/text_nav_23.png' name='picture2' width='123' height='29' border='0' align='middle'  class='pic_down'></a>"+
			"</div>"+
	 		"<div class='text_navbottom'></div></div>";	 
	//设置样式
	div.style.cursor = "pointer";
	div.style.border = "0px solid gray";
	
	// 绑定事件
	div.onclick = function(e){
		//点击一次放大两级
		//alert('JDLayerControl clicked');
	};
	// 添加DOM元素到地图中
	map.getContainer().appendChild(div);

	// 将DOM元素返回
	return div;
};