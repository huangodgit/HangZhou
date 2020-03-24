(function($) {
	$.fn.dataTableExt.oApi.fnReloadAjax = function(oSettings, sNewSource, fnCallback, bStandingRedraw) {
		if (sNewSource !== undefined && sNewSource !== null) {
			oSettings.sAjaxSource = sNewSource;
		}
		// Server-side processing should just call fnDraw
		if (oSettings.oFeatures.bServerSide) {
			this.fnDraw();
			return;
		}
		this.oApi._fnProcessingDisplay(oSettings, true);
		var that = this;
		var iStart = oSettings._iDisplayStart;
		var aData = [];
		this.oApi._fnServerParams(oSettings, aData);
		oSettings.fnServerData
		.call(
				oSettings.oInstance,
				oSettings.sAjaxSource,
				aData,
				function(json) {
					/* Clear the old information from the table */
					that.oApi._fnClearTable(oSettings);
					/* Got the data - add it to the table */
					var aData = (oSettings.sAjaxDataProp !== "") ? that.oApi
							._fnGetObjectDataFn(
									oSettings.sAjaxDataProp)(json)
									: json;
									for (var i = 0; i < aData.length; i++) {
										that.oApi._fnAddData(oSettings, aData[i]);
									}
									oSettings.aiDisplay = oSettings.aiDisplayMaster
									.slice();
									that.fnDraw();
									if (bStandingRedraw === true) {
										oSettings._iDisplayStart = iStart;
										that.oApi._fnCalculateEnd(oSettings);
										that.fnDraw(false);
									}
									that.oApi
									._fnProcessingDisplay(oSettings, false);
									/* Callback user function - for event handlers etc */
									if (typeof fnCallback == 'function'
										&& fnCallback !== null) {
										fnCallback(oSettings);
									}
				}, oSettings);
	}})(jQuery);


/**
 * ajax提交
 * 
 */
function sendAjax(url, data, callback) {
	return $.ajax({
		type : "POST",
		url : url,
		data : data,
		dataType : "json",
		success : callback
	});
}

/**
 * 成功提示
 * @param msg
 */
function ui_info(msg) {
	$.gritter.add({
		position : 'bottom-right',
		text : '<h5>' + msg + '</h5>',
		sticky : false,
		time : 3000,
		class_name : 'gritter-light gritter-info'
	});
}

/**
 * 错误提示
 * @param msg
 */
function ui_error(msg) {
	$.gritter.add({
		text : '<h5>' + msg + '</h5>',
		sticky : false,
		time : 2000,
		class_name : 'gritter-light gritter-error gritter-center'
	});
}

/**
 * 二次确定
 * @param msg
 * @param callback
 */
function ui_confirm(msg, callback) {
	bootbox.dialog({
		message : "<h5>" + msg + "<h5>",
		buttons : {
			main : {
				label : "取消",
				className : "btn-default",
				callback : function() {
					//
				}
			},
			danger : {
				label : "确定",
				className : "btn-primary",
				callback : function() {
					callback();
				}
			}
		}
	});
}

/**
 * layer弹出框
 * @param name
 * @param url
 * @param width
 * @param height
 */
function showLayerDialog(name,url,width,height){
	layer.open({
		type: 2,
		skin: 'layui-layer-rim', //加上边框
		title: name,
		fix: false,
		shadeClose: true,
		maxmin: true,
		area: [width, height],
		content: url
	});
}
function showLayerDialogXY(name,url,width,height,x,y){
	layer.open({
		type: 2,
		offset: [x, y],
		skin: 'layui-layer-rim', //加上边框
		title: name,
		fix: false,
		shadeClose: true,
		maxmin: true,
		area: [width, height],
		content: url
	});
}

/**
 * 地图定位
 * @param x
 * @param y
 * @param type
 * @param idtown
 */
function position(x,y,type,id){
	var url = "mainmap.jsp?longitude="+x+"&latitude="+y+"&operation=locationpoint&pointtype="+type+"&id="+id; 
	parent.changeMain(url);
}

function positionBack(x,y,type,id,menuUrl,menuTitle){
	var url = "mainmap.jsp?longitude="+x+"&latitude="+y+"&operation=locationpoint&pointtype="+type+"&id="+id+"&mapUrl="+menuUrl+"&menuTitle="+menuTitle; 
	parent.changeMain(url);
}
