$(function(){
	var sel=".form-group label.control-label";
	/*var classStr = $(sel).attr('class').replace("col-xs-3","col-xs-2");*/
	/*$(sel).attr('class', classStr);*/
	$(sel).removeClass("col-xs-3");
	$(sel).addClass("col-xs-2");
	$(sel).css("text-align","right");
	
	//关闭弹窗
	$(".btn-close").click(function(){
		parent.layer.close(parent.layer.getFrameIndex(window.name));
	});
})