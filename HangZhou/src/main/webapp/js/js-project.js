/*
 * Create by fubo
 * project use only
 * 
 */
//文件上传支持 code resource by HZB
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
					addRemoveLinks : false,
					dictResponseError : '文件上传失败',
					//change the previewTemplate to use Bootstrap progress bars
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
function showingSavedFile(){
	/*文件的显示  */
	if($("#showName,#showPath").val() != ""){
		var showName = $("#showName").val();
		var showPath = $("#showPath").val();
		var showId = $("#showId").val();
		var showNames = new Array();
		var showPaths = new Array();
		var showIds = new Array();
		showNames = showName.split(",");
		showPaths = showPath.split(",");
		showIds = showId.split(",");
		for(var i=0;i<showNames.length;i++){
			
	$(".dz-default.dz-message").after("<li id='"+showIds[i]+"' class=\"dz-preview dz-file-preview\">\n "+ 
			"<div class=\"dz-details\">\n"+
			"<div class=\"dz-filename\"><span data-dz-name>"+showNames[i]+"</span></div>\n <img src='"+showPaths[i]+"'/>\n"+
			"</div>\n<a class=\"dz-remove\" href='javascript:fileDelete("+showIds[i]+")'; data-dz-remove>删除文件</a></li>");
		
		}
	}
}
function showImgInView(){
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
	
}
function fileDelete(fid){
	$.ajax({
		type:"post",
		url:"CivilizationPoints/FamilyCivilizationPointsDeductRecords/fileDelete",
		data:{
			fileId:fid
	 	     },
		dataType:"json",
		success:function(data){
			$(".dz-default.dz-message").nextAll("#"+fid).remove();
		},
		error:function(){
			ui_error("文件删除失败！");
		}
	})
}
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

function closeWindow(){
	var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	//parent.maincontent_datatable.fnReloadAjax();
	parent.layer.close(index); //再执行关闭  
}