/*
 * Create by fubo
 * project,system use only
 * 
 */
//文件上传支持 do by H.B
/*
function loadUploadFunction(){
	var type="";
	var filename="";
	var path=""; 
	try {
		var myDropzone = new Dropzone(
				"#dropzone",
				{
					paramName : "file", // 与input的name属性一致
					maxFilesize : 5, // MB
					maxFiles : 5,
					dictDefaultMessage :"",
					autoProcessQueue : true,
					init : function() {
						var submitButton = document.querySelector("#submit-all")
						myDropzone = this; // closure
						//回调
						this.on("success", function(file, responseText) {
							var d = eval("(" + responseText + ")");
							var getFilePath = $("input[name=filePath]").val();
							$("input[name=filePath]").val(getFilePath+","+d.FilePath);
							var Name = $("input[name=fileName]").val();
							$("input[name=fileName]").val(Name+","+d.Name);
							var getFileMIME = $("input[name=fileMIME]").val();
							$("input[name=fileMIME]").val(getFileMIME+","+d.DocumentType);
						});
					},
					acceptedFiles : ".jpg,.png,.gif,.bmp,.jpeg,.JPG,.PNG,.GIF,.BMP,.JPEG,.txt,.pdf,.doc,.xls,.mdb,.ppt",
					addRemoveLinks : true,
					dictResponseError : '文件上传失败',
					previewTemplate : "<li class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-details\">\n    <div class=\"dz-filename\"><span data-dz-name></span></div>\n    <div class=\"dz-size\" data-dz-size></div>\n    <img data-dz-thumbnail />\n  </div>\n  <div class=\"progress progress-small progress-striped active\"><div class=\"progress-bar progress-bar-success\" data-dz-uploadprogress></div></div>\n  <div class=\"dz-success-mark\"><span></span></div>\n  <div class=\"dz-error-mark\"><span></span></div>\n  <div class=\"dz-error-message\"><span data-dz-errormessage></span></div>\n</li>"
				});
		$(document).one('ajaxloadstart.page', function(e) {
			try {
				myDropzone.destroy();	
			} catch (e) {
			}
		});

	} catch (e) {
		alert('Dropzone.js does not support older browsers!');
	}
}
*/
function changeFile(obj){
	var allowSuffix = ["doc","docx","xls","xlsx","jpg","png","gif","zip","ppt","pptx","bmp",
	                   "pdf","txt","numbers","pages","key","rtf"];
	var getVal = $(obj).val();
	var getSuffix = (getVal.substring(getVal.lastIndexOf(".")+1,getVal.length)).toLowerCase();
	var allowUpload = false;
	for(var i = 0 ; i < allowSuffix.length ; i++){
		if(allowSuffix[i] == getSuffix){
			allowUpload = true;
			break;
		}
	}
	if(allowUpload){
		var getLeft;
		if(getVal.lastIndexOf("\\") >= 0){
			getLeft = getVal.lastIndexOf("\\");
		}else{
			getLeft = getVal.lastIndexOf("/");
		}
		var setName = getVal.substring(getLeft+1,getVal.length);
		$("input[name=docFiles]").val(setName);
	}else{
		$(obj).val("")
		$("input[name=docFiles]").val("")
		alert("这个文件不被支持上传");
	}

}
function ajaxSubmit(obj,url, data, callback) {
	return $(obj).ajaxSubmit({
		url : url,
		data : data,
		dataType : "json",
		success : callback
	});
}
function fixedSize(name,url,sizeX,sizeY){
	calcSizeX = 0;
	calcSizeY = 0;
	// 百分比支持
	if(sizeX.indexOf("%") >= 0){
		calcSizeX = sizeX.substring(0,sizeX.indexOf("%"));
		calcSizeX = parseFloat(calcSizeX)/100;
	}else{
		calcSizeX = parseInt(sizeX);
	}
	var scrollY = parent.window.scrollY;
	var bodyObj = $("body");
	var getScrollPosition = scrollY;
	var parentWidth = bodyObj.width();
	if(calcSizeX < 1){
		calcSizeX = parentWidth * calcSizeX;
	}
	if(sizeY.indexOf("%") >= 0){
		calcSizeY = sizeY.substring(0,sizeX.indexOf("%"));
		calcSizeY = parseFloat(calcSizeY) / 100 * parentWidth;
	}else{
		calcSizeY = parseInt(sizeY);
	}
	var realWidth = (parentWidth - calcSizeX) / 2;
	if(getScrollPosition < 10){
		getScrollPosition = 10;
	}else{
		getScrollPosition = getScrollPosition;
	}
	//alert(calcSizeX+","+calcSizeY);
	showLayerDialogXY(name,url,calcSizeX+"px",calcSizeY+"px",getScrollPosition,realWidth);
}
function fixedSizeDialog(url,obj,text,afterRemove){
	nowPosition = parent.window.scrollY;
	if(text == null || text == "undefined" || text == ""){
		text = "确定要删除吗？";
	}
	if(afterRemove == null || afterRemove == "undefined"){
		afterRemove = true;
	}
	ui_confirm(text,function(){
		sendAjax(url," ", function(json){
			if(json.ok){
				ui_info(json.info);
				//maincontent_datatable.fnReloadAjax();
				if(afterRemove){
					$(obj).parents("tr").hide(300,function(){
						$(this).remove();
						setTimeout("initHtmlButton()",300);
					});
				}
			}else{
				ui_error(json.info);
			}
		});
	});
	setTimeout("setPosition("+nowPosition+")",300);
}
function setPosition(nowPosition){
	if(nowPosition < 35){
		nowPosition = 35;
	}
	$(".modal-dialog").animate({"padding-top":nowPosition+"px"});
}
function closeWindow(){
	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	//parent.maincontent_datatable.fnReloadAjax();
	parent.layer.close(index); //再执行关闭  
}

//自适应区
 // 存储变量
var savedSize = 0;
var defScreenSize = 0;
var savedFrameSize = 0;
var defFrameScreenSize = 0;
var frameHeight = 0;

// 延时后自适应
function autoSizeDelay(time){
	if(isNaN(time)){
		time = 300;
	}
	setTimeout("autoSizeStart()",time);
}

// iframe延时自适应,适合在iframe里面的树形结构
function autoSizeInFrameDelay(time){
	if(isNaN(time)){
		time = 300;
	}
	setTimeout("autoSizeFrameStart()",time);
}

//frame内高度自适应,适合在载入时候使用
function autoSizeiFrameInnerInLoad(){
	frameHeight = parent.$("iframe").height();
	savedFrameSize = 0;
	defFrameScreenSize = 0;
	autoSizeFrameStart();
}
// 页面高度自动调整,适合在载入时候使用,同时控制1屏内不显示top按钮
function autoSizeInLoad(){
	savedSize = 0;
	defScreenSize = 0;
	defFrameScreenSize = 0;
	autoSizeStart();
}
// iFrame弹出里面高度自适应
function autoSizeIFrameHeight(withoutServerSide,noScrolling){
	// 自适应高度

		if(noScrolling){
			parent.$("iframe").attr("scrolling","no");
		}
		var getH = $(".page-content").height();
		var getFrameHeight = parent.$("iframe").height();
		if(withoutServerSide){
			getH = getH+33;
		}
		if(parseInt(getFrameHeight) > parseInt(getH)){
			parent.$("iframe").attr("style","height:"+(getH-7)+"px");
			parent.$("iframe").parent("div").parent("div").animate({"height":(getH+60)+"px"},"fast");
		}

		
 }

function autoSizeStart(giveSize){
	var t = $(".table-responsive").height();
	var defSize = window.screen.availHeight - 66;
	if(!isNaN(giveSize)){
		defSize = giveSize;
	}
	if(savedSize == 0){
		savedSize = defSize;
	}
	if(defScreenSize == 0){
		defScreenSize = defSize;
	}
	if(t <= defScreenSize){
		parent.$("#btn-scroll-up").hide();
	}else{
		parent.$("#btn-scroll-up").show();
	}
	if(t <= (savedSize-90)){
		parent.$("iframe").attr("height",defScreenSize+"px");
	}else{
		parent.$("iframe").attr("height",(t+200)+"px");
	}
}

function autoSizeFrameStart(){
	var t = $(".table-responsive").height();

	if(savedFrameSize == 0){
		savedFrameSize = frameHeight;
	}
	if(t <= savedFrameSize){
		$("body").attr("style","height:"+(savedFrameSize)+"px;overflow-x:hidden;");
		//parent.$("iframe").parent("div").parent("div").css("height",frameHeight+"px");
	}else{
		$("body").attr("style","height:"+(t+200)+"px;overflow-x:hidden;");
		//parent.$("iframe").parent("div").parent("div").css("height",(t+200)+"px");
	}
}

// 树结构多选,obj对象为a对象,a里面包含input onclick为a
var affectNum = new Array(); // 存储多选时受影响的所有元素
function checkMultiple(obj,objInputPosition,onlyCheckedListorAll){
	var getObjID = $(obj).parents("tr").attr("data-id");
	var getObjLevel = $(obj).parents("tr").attr("data-level");
	var getObjChecked = $(obj).children("input").prop("checked");
	affectNum = new Array(); // 每次点击,重初始化数组
	
	if(getObjChecked){
		affectNum.push(1); // 1=勾选
		affectNum.push(parseInt(getObjID)); // 添加勾选父级id
	}else{
		affectNum.push(0); // 0=不勾选
		affectNum.push(parseInt(getObjID));// 添加不勾选父级id
	}
	doCheckStart(obj,getObjID,getObjLevel,objInputPosition,onlyCheckedListorAll);
}
function doCheckStart(obj,id,level,objInputPosition,onlyCheckedListorAll){ // 递归完成遍历
	id = parseInt(id);
	level = parseInt(level);
	$("tbody>tr").each(function(x,e){
		var getTrPid = parseInt($(this).attr("data-pid"));
		var getTrId = parseInt($(this).attr("data-id"));
		var getLevel = parseInt($(this).attr("data-level"));
		var getPermission = $(this).attr("data-permission");
		var getObj = $(this).children("td:eq("+objInputPosition+")").children("div").children("a");
		if(getTrPid == id && getLevel >= level){
			affectNum.push(getTrId); // 如果子级符合条件,添加到受影响元素
			if($(obj).children("input").prop("checked")){
				if(onlyCheckedListorAll){
					if(getPermission != null && getPermission.indexOf(":") >= 0){
						var getPermissionName = getPermission.split(":")[1];
						if(getPermissionName == "list" || getPermissionName == "*"){
							checkedThis(getObj,"allCheck");
						}
					}else{
						checkedThis(getObj,"allCheck");
					}
				}else{
					checkedThis(getObj,"allCheck");
				}
				
			}else{
				checkedThis(getObj,"allClean");
			}
			doCheckStart(getObj,getTrId,getLevel,objInputPosition,onlyCheckedListorAll);
		}
	});
}
function checkSingle(obj){
	var getObjIfChecked = $(obj).children("input").prop("checked");
	if(getObjIfChecked){
		$(obj).children("input").prop("checked",false);
		$(obj).attr("data-original-title","选中");
	}else{
		$(obj).children("input").prop("checked",true);
		$(obj).attr("data-original-title","取消选中");
	}
}

function returnAffectNum(){
	return affectNum; // 返回受影响元素
}
function checkedThis(obj,checkMode){		
	//var getObjClass = $(obj).children("i").attr("class");
	var getObjIfChecked = $(obj).children("input").prop("checked");
	var children = $(obj).children("input");
	children[0].indeterminate = false;
	if(checkMode == "allCheck"){
			// 未选时点击
			$(obj).children("input").prop("checked",true);
			$(obj).attr("data-original-title","取消选中");
			
	}else if(checkMode == "allClean"){
		 // 未选时点击
			$(obj).children("input").prop("checked",false);
			$(obj).attr("data-original-title","选中");
	}else{
		if(getObjIfChecked){ // 未选时点击
			$(obj).children("input").prop("checked",true);
			$(obj).attr("data-original-title","取消选中");
		}else{
			$(obj).children("input").prop("checked",false);
			$(obj).attr("data-original-title","选中");
		}
	}
	
}
// 选中已经选过的,参数为input checkbox的表格位置
function selectIfSelected(position){
	var getSelectedVal = $("#selected").attr("data-value");
	var dataArr = new Array();
	if(getSelectedVal.length > 0){
		if(getSelectedVal.indexOf(",") >= 0){
			dataArr = getSelectedVal.split(",");
		}else{
			dataArr[0] = getSelectedVal;
		}
	}
	$("table>tbody>tr").each(function(x,i){
		for(var i = 0 ; i < dataArr.length ; i++){
			if(parseInt($(this).attr("data-id")) == parseInt(dataArr[i])){
				checkSingle($(this).children("td:eq("+position+")").children("div").children("a"));
				break;
			}
		}
	});
}

// 将任意JS数组转为json字符串 参数:源数组,json数组元素名,是否全部转为string
function toJsonArray(array,dataName,isAllStrong){
	var ArrayJSON;
	if(dataName != null && dataName != ""){
		ArrayJSON = "{"+dataName+":[";
	}else{
		ArrayJSON = "{[";
	}
	
	for(var i = 0 ; i < array.length ; i++){
		if(isAllStrong){
			if(i != array.length -1){
				ArrayJSON += "\""+array[i]+"\"" + ",";
			}else{
				ArrayJSON += "\""+array[i]+"\"";
			}
		}else{
			var getObjType = typeof(array[i]);
			
			switch(getObjType){
			case "string":
				if(i != array.length -1){
					ArrayJSON += "\""+array[i]+"\"" + ",";
				}else{
					ArrayJSON += "\""+array[i]+"\"";
				}
				break;
			case "number":
			case "boolean":
				if(i != array.length -1){
					ArrayJSON += array[i] + ",";
				}else{
					ArrayJSON += array[i];
				}
				break;
			default:
				if(i != array.length -1){
					ArrayJSON += "\""+array[i]+"\"" + ",";
				}else{
					ArrayJSON += "\""+array[i]+"\"";
				}
				break;
			}
		}
	}
	ArrayJSON = ArrayJSON +"]}";
	return ArrayJSON;
}
function getAllExpandRow(){
	var Arr = new Array();
	var t = document.getElementsByTagName("tbody")[0].childNodes;
	for(var i = 0 ; i < t.length ; i++){
		if(!(t.item(i).style.display == "none" || t.item(i).getAttribute("data-level") == "0")){
			Arr.push(parseInt(t.item(i).getAttribute("data-id")));
		}
		
	}
	return Arr;
}
function getAllExpandList(){
	var Arr = new Array();
	var t = document.getElementsByTagName("tbody")[0].childNodes;
	for(var i = 0 ; i < t.length ; i++){
		if(t.item(i).getAttribute("expand") == "1"){
			Arr.push(parseInt(t.item(i).getAttribute("data-id")));
		}
		
	}
	return Arr;
}