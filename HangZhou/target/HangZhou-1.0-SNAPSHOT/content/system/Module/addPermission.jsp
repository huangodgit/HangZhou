<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>修改</title>
<s:include value="/common/include.jsp"></s:include>
<link rel="stylesheet" href="css/css-system.css">
<script type="text/javascript"src="js/js-system.js"></script>
<style>
body{
	overflow:hidden;
}
	.input-group{
		width:273px;
		height:34px;
		float:left;
		margin-left:20px;
	}
	#control{
		width:120px;
	}
	label{
		margin:0 10px 0 10px;
		padding-top:5px;
	}
	input{
		font-size:16px;
	}
	#parentPermission{
		position:absolute;
		left:50px;
		top:5px;
		font-size:16px;
		color:gray;
		float:left;
	}
	#comboBox{
		width:154px;
		float:left;
	}
	#floatLeft{
		float:left;
	}
</style>
</head>

<body>
	<div class="page-content" style="margin-top:20px;">

		<div class="row">
			<div class="col-lg-6">
			
			 <div class="input-group" style="width:220px;">
			<label class="control-label no-padding-right"> 模块名 </label>
			<input type="text" class="form-control" name="funcName" id="control" >
			 </div><!-- /input-group -->
			    <div class="input-group">
			    <label class="control-label no-padding-right" id="floatLeft"> 权限 </label>
			      <input type="text" id="comboBox" name="permission" class="form-control">
			      <span id="parentPermission"></span>
			      <div class="input-group-btn">
			        <button type="button" id="floatLeft" style="height:34px;width:71px;" class="mybtn mybtn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">选择 <span class="caret"></span></button>
			        <ul class="dropdown-menu dropdown-menu-center" id="permissionList" style="left:-320px;width:400px;height:128px;overflow-y:auto">
			          
			        </ul>
			      </div><!-- /btn-group -->
			    </div><!-- /input-group -->
			  </div><!-- /.col-lg-6 -->
			  <div class="col-xs-12 no-padding">
							<div class="clearfix form-actions" style="margin-top:40px;">
								<div class="col-mx-9 pull-right">
									<button class="btn btn-info" type="button" onclick="addPermission();">
										<i class="icon-ok bigger-110"></i> 保存
									</button>
			
									&nbsp; &nbsp; &nbsp;
									<button class="btn" type="reset">
										<i class="icon-undo bigger-110"></i> 重置
									</button>
								</div>
							</div>
						</div>
		</div>
		<!-- /.row -->
	</div>
	<!-- /.page-content -->

	<script type="text/javascript">
	var defaultPermissionVal = ["list","insert","delete","edit"];
	var defaultPermissionName = ["菜单","添加","删除","编辑"];
	
	var isDoing = false;
		function addPermission(){
			var id = parent.clickedID;
			var name = $("input[name=funcName]").val();
			var perm = parent.permName+":"+$("input[name=permission]").val();
			if(name == "" || perm == ""){
				ui_error("信息未填写完整");
			}else{
				if(!isDoing){
					isDoing = true;
					sendAjax("System/Module/addPermission?actionOperation=save", {id:id,funcName:name,permissionName:perm}, function(json){
						isDoing = false;
						if(json.ok){
			    			 parent.ui_info(json.info);
			    			 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			    			 //parent.maincontent_datatable.fnReloadAjax();
			    			 parent.reloadAjax();
			    			 parent.reOpen = true;
			    			 parent.layer.close(index); //再执行关闭  
			    		 }else{
			    			 ui_error(json.info);
			    		 }
			    	 });
				}else{
					ui_error("上一个操作正在进行中....");
				}
			}
			
		}
		// 为已知的CRUD权限默认填充名字,上下一一对应
		function inputUp(val,name){
			/* if(val.indexOf(":") >0){
				val = val.split(":")[1];
			}
			var defName = "";
			for(var i = 0 ; i < detaultPermissionVal.length ; i++){
				if(val == detaultPermissionVal[i]){
					defName = defaultPermissionName[i];
					break;
				}
			} */
			$("input[name=funcName]").val(name);
			$("input[name=permission]").val(val);
		}
			$(function(){
				var permArr = parent.permissionArr;
				var name = parent.permName;
				if(name.length > 7){
					name = name.substring(0,11)+".. ";
				}
				$("#parentPermission").html(name+":");
				var w = $("#parentPermission").width();
				w = w+5;
				$("input[name=permission]").attr("style","padding-left:"+w+"px;");
				/* sendAjax("System/Module/addPermission?operation=list", "", function(json){
		    		for(var i = 0 ; i < json.length ; i++){
		    			 $("#permissionList").append("<li><a href=\"javascript:void(0)\" onclick=\"inputUp('"+json[i]+"')\">"+json[i]+"</a></li>");
		    		}
		    	 }); */
		    	 var addSum = 0;
		    	 for(var i = 0 ; i < defaultPermissionVal.length ; i++){
		    		 if(!isUsed(permArr,defaultPermissionVal[i])){
		    			 addSum ++;
		    			 $("#permissionList").append("<li><a href=\"javascript:void(0)\" onclick=\"inputUp('"+defaultPermissionVal[i]+"','"+defaultPermissionName[i]+"')\">"+defaultPermissionVal[i]+" "+defaultPermissionName[i]+"</a></li>");
		    		 }
		    	 }
				if(addSum == 0){
					$("#permissionList").append("<li><a href=\"javascript:void(0)\">没有建议添加选项</a></li>");
				}
			})
			function isUsed(permArr,moduleName){
				for(var i = 0 ; i < permArr.length ; i++){
					if(permArr[i] == moduleName){
						return true;
					}
				}
				return false;
			}
		</script>

</body>
</html>
