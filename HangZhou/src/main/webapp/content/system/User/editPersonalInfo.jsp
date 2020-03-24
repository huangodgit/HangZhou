<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title>系统管理</title>
<s:include value="/common/include.jsp"></s:include>
<%-- <script type="text/javascript" src="js/ajaxfileupload.js"></script> --%>
<link rel="stylesheet" href='<s:url value="/css/css-system.css"/>'>
<script type="text/javascript" src='<s:url value="/js/js-system.js"/>'></script>
<link rel="stylesheet" href="css/list.css">
<style>
	#hoverText{
		width:270px;
		height:30px;
		position:absolute;
		color:#fff;
		font-size:15px;
	}
	.okStyle{
		width: 30px;
		height: 30px;
		outline:none;
		position: absolute;
		bottom:10px;
		right:23px;
	}
</style>
</head>
<body id="mybody">

<div class="page-content" style="padding: 0px;">
		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div class="breadcrumbs" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="icon-home home-icon"></i> <a href="#">主页</a></li>

						<li><a href="#">系统管理</a></li>
						<li class="active">个人管理</li>
					</ul>

				</div>
				<div style="margin-top:10px;">
					 <form id="townAddForm" class="form-horizontal" role="form"  method="post">
						<input type="hidden" name="id" value='<s:property value="id"/>' />
							<div class="form-group">
								<label class="col-xs-1 control-label no-padding-right"
									for="form-field-1"> 登录名 </label>
								<div class="col-xs-9">
									<input type="text" id="form-field-1" readonly value='<s:property value="loginName"/>' class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-1 control-label no-padding-right"
									for="form-field-1"> 显示名称 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="显示名称" name="name" value='<s:property value="name"/>' class="col-xs-10"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-1 control-label no-padding-right"
									for="form-field-1"> 机构 </label>
								<div class="col-xs-9">
									<input type="text" id="orgName" class="col-xs-10" readonly="readonly" value='<s:property value="org.name"/>'>
									
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-1 control-label no-padding-right"
									for="form-field-1"> 成员 </label>
	
								<div class="col-xs-9">
									<input type="text" id="memberName" class="col-xs-10" readonly="readonly" value='<s:property value="member.name"/>'>
									
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-1 control-label no-padding-right"
									for="form-field-1"> 说明  </label>
	
								<div class="col-xs-9">
									<textarea class="form-control limited istextarea" id="editor1" maxlength="600" rows="5" name="remark" style="width:250px;"><s:property value="remark"/></textarea>
								</div>
							</div>
							
							
					</form>
					<div class="col-xs-12 no-padding">
							<div class="clearfix form-actions">
								<div class="col-mx-9 pull-right">
									<button class="btn btn-info" type="button" id="saveBtn" onclick="saveProfile()">
										<i class="icon-ok bigger-110"></i><span>保存</span>
									</button>
			
									<!-- &nbsp; &nbsp; &nbsp;
									<button class="btn" type="reset">
										<i class="icon-undo bigger-110"></i> 重置
									</button> -->
								</div>
							</div>
						</div>
								</div>
							</div>
						</div>
						
						
						
						
						<!-- 
						
						<-- 密码修改Start --
								<div id="profile5" class="tab-pane">
								 <div class="form-group">
									<div class="col-xs-12">
									<div class="col-xs-8">
										<div class="form-group">
											<label class="col-xs-3 control-label " for="form-field-1">旧密码</label>
											<div class="col-xs-8">
												<input type="password" id="form-field-1" placeholder="输入旧密码" name="oldPass" class="col-xs-10">
											</div>
									    </div>
										<div class="form-group">
											<label class="col-xs-3 control-label" for="form-field-1">新密码</label>
											<div class="col-xs-8">
												<input type="password" id="form-field-1" placeholder="输入身份证号码" name="pass" class="col-xs-10">
											</div>
										</div>
										<div class="form-group">
											<label class="col-xs-3 control-label" for="form-field-1">确认密码</label>
											<div class="col-xs-8">
												<input type="password" id="form-field-1" placeholder="输入确认密码" name="conPass" class="col-xs-10">
											</div>
										</div>
										
											</div>
										</div></div>
								</div>
								 密码修改End -->
				</div>
				<!-- PAGE CONTENT ENDS -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
	</div>
	<script type="text/javascript">
		var memberAddValidator;
		var changed = false;
		function changeButton(val){
			if(val == "0"){
				$("#saveBtn").prop("disabled",false);
				$("#saveBtn").children("span").html("保存");
				$("#saveBtn").attr("onclick","saveProfile()");
			}else if(val == "1"){
				if(changed){
					$("#saveBtn").prop("disabled",true);
				}
				$("#saveBtn").children("span").html("更新");
				$("#saveBtn").attr("onclick","submitPassword();");
			}
		}
		
		function submitPassword(){
			if(!changed){
				var getOldPass = $("input[name=oldPass]").val();
				var getNewPass = $("input[name=pass]").val();
				var getConPass = $("input[name=conPass]").val();
				if(getOldPass == ""){
					ui_error("旧密码未填写");
				}else if(getNewPass == "" || getNewPass != getConPass){
					ui_error("新密码未填写或两次密码输入不一致");
				}else{
					changed = true;
					sendAjax("System/User/savePassword", {password0:getOldPass,password1:getNewPass,password2:getConPass}, function(json){
						changed = false;
						if(json.ok){
							ui_info(json.info);
							$("input[name=oldPass]").prop("disabled",true);
							$("input[name=pass]").prop("disabled",true);
							$("input[name=conPass]").prop("disabled",true);
						}else{
							ui_error(json.info);
						}
			    	 });
				}
			}else{
				ui_error("上一个操作正在进行中....");
			}
		}
		jQuery(function($) {
			sendAjax("BaseInfo/Town/getAreaData?type=noid", "", function(json){
				$('#element_id').cxSelect({
					  url: json,
					  selects: ['town', 'village', 'nvillage'],
					  firstValue: ''
				});
	    	 });
		});
			/* $('#element_id').cxSelect({
				  url: 'common/areaData2.json',   // 提示：如果服务器不支持 .json 类型文件，请将文件改为 .js 文件 
				  selects: ['town', 'village','nvillage'],
				  firstValue: ''
			}); */
			
			/* memberAddValidator = $('#memberEditForm')
				.validate(
					{
						focusInvalid : false,
						rules : {
							name : {
								required : true
							}
						},
						messages : {
							name : {
								required : "请输入名称"
							}
						},
						submitHandler : function(form) {
							sendAjax(
									"BaseInfo/Member/save",
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

		}); */
		function saveProfile(){
			var getShowName = $("input[name=name]").val();
			var getDesc = $("#editor1").val();
			var getID = $("input[name=id]").val();
			if(!changed){
				changed = true;
				sendAjax("System/User/saveProfile",{id:getID,remarkText:getDesc,showName:getShowName},function(json) {
					changed = false;
					if (json.status) {
						ui_info("保存成功");
					} else {
						ui_info("保存失败");
					}
				});
			}else{
				ui_error("上一个操作正在进行中....");
			}
		}
		
/* var result = document.getElementById("result"); 
		  var input = document.getElementById("file_input");
		  
		result.innerHTML = '<img src="<s:property value="imgUrl"/>" name="imgUrl"style="width:170px;height:270px;" alt=""/>'
		 
		 
		  if(typeof FileReader==='undefined'){ 
		      result.innerHTML = "抱歉，你的浏览器不支持 FileReader"; 
		      input.setAttribute('disabled','disabled'); 
		  }else{ 
		      input.addEventListener('change',readFile,false); 
		  } 
		  
		  
		
	
		  function readFile(){ 
			  
			    var file = this.files[0]; 
			    if(!/image\/\w+/.test(file.type)){ 
			        alert("文件必须为图片！"); 
			        return false; 
			    } 
			    var reader = new FileReader(); 
			    reader.readAsDataURL(file); 
			   
			   
			  reader.onload = function(e){ 
				 $("#img").hide();
				  $("#result").show(); 
				  
				  result.innerHTML = '<img src="'+this.result+'" name="imgUrl"style="width:170px;height:270px;" alt=""/>'
				 $("#button").attr("disabled", false);
				  $("#button").css("display","");
			    } 
			}  
		
		  function clicke(){
			  $.ajaxFileUpload			    	 
            (
              {
                   url:'BaseInfo/Member/uploadSave', //你处理上传文件的服务端
                   secureuri:false,
                   fileElementId:'file_input',
                   dataType: 'json',
                   success: function (file)
                         {
                   	var f=file.file;
                   	$("#imgUrl").val(f);
                   	result.innerHTML = '<img src="<s:property value="imgUrl"/>" name="imgUrl"style="width:170px;height:270px;" alt=""/>'
                   	
                           //alert(data.file_infor);
                   		var input = document.getElementById("file_input"); 
              		 
            		  if(typeof FileReader==='undefined'){ 
            		      result.innerHTML = "抱歉，你的浏览器不支持 FileReader"; 
            		      input.setAttribute('disabled','disabled'); 
            		  }else{ 
            		      input.addEventListener('change',readFile,false); 
            		  }
                         }
                      }
                );
			  $("#button").css("display","none");
			  $("#button").attr("disabled", true);
		     }
		  $("#result").click(function(){
			  $("#file_input").click();
			 
		  }); */
		  
		  /* var result = document.getElementById("result"); 
		  var input = document.getElementById("file_input"); 
		  
		  result.innerHTML = '<img src="<s:property value="imgUrl"/>" name="imgUrl"style="width:270px;height:270px;" alt=""/>'
		  
		  if(typeof FileReader==='undefined'){ 
		      result.innerHTML = "抱歉，你的浏览器不支持 FileReader"; 
		      input.setAttribute('disabled','disabled'); 
		  }else{ 
		      input.addEventListener('change',readFile,false); 
		  } */
		  /* function readFile(){ 
			 
			    var file = this.files[0]; 
			    if(!/image\/\w+/.test(file.type)){ 
			        alert("文件必须为图片！"); 
			        return false; 
			    } 
			    var reader = new FileReader(); 
			    reader.readAsDataURL(file); 
			   
			   
			  reader.onload = function(e){ 
				  
				  result.innerHTML = '<img src="'+this.result+'" name="imgUrl"style="width:270px;height:270px;" alt=""/>'
				  $("#button").prop("disabled", false);
				  $("#button").css("display",""); 
			    } 
			  
			} */
		  /* function clicke(){
			  $.ajaxFileUpload({
                     url:'System/User/saveImage', //你处理上传文件的服务端
                     secureuri:false,
                     fileElementId:'file_input',
                     dataType: 'json',
                     success: function (data){
	                     if(data.success){
	                    	 ui_info(data.info);
	                     }else{
	                    	 ui_error(data.info);
	                     }
                     }
                });
			  
			  $("#button").attr("display","none");
			  $("#button").prop("disabled", true);
		     } */
		  /* $(document).ready(function(e){
			 var getImgSrc = $("img[name=imgUrl]").attr("src");
			 if(getImgSrc == ""){
				 $("img[name=imgUrl]").attr("src",'<s:url value="vendor/assets/avatars/profile-pic.jpg"/>');
			 }
			 $("#hoverText").attr("style","left:"+$("#result").positon().left+"px;top:"+("#result").positon().top+"px");
		  });
		  $("#result").click(function(){
			  $("#file_input").click();
		  }); */
	</script>
</body>

</html>