<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<title>新增项目</title>
<s:include value="/common/include.jsp"></s:include>
<link rel="stylesheet" href='<s:url value="/css/css-project.css"/>'>
<s:include value="/common/include-ueditor.jsp" />
<script type="text/javascript" src='<s:url value="/js/js-project.js"/>'></script>
<link rel="stylesheet" type="text/css" href="css/validate-tip-bottom.css"/>

<script>
$(function() {
	$('.date-picker').datepicker({
		format:'yyyy-mm-dd',
		autoclose:true,
		language:'zh-CN'
	}).next().on(ace.click_event,function(){
		$(this).prev().focus();
	});
})
</script>
<style type="text/css"> 
div.datepicker.datepicker-dropdown.dropdown-menu{
z-index:999! important
}		
</style>
</head>

<body id="mybody">
	<div class="page-content">

		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div>
					
						
						<form id="townAddForm" class="form-horizontal" role="form"  method="post" action="BaseInfo/Town/save">
							<div>
							<div class="col-xs-5 no-padding">
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1">选择企业</label>
								<div class="col-xs-8">
									<input type="text" id="enterpriseName" placeholder="选择企业" style="width:91% !important"
										name="enterpriseName" class="col-xs-10" readonly="readonly" value='<s:property value="enterprise.name"/>'/> <input
										type="hidden" id="enterpriseId" name="enterpriseId" class="col-xs-10" value='<s:property value="enterprise.id"/>'
										readonly="readonly" /> <a class="green tooltip-info col-xs-1 "
										data-rel="tooltip" data-placement="top"
										style="padding-top: 5px;" title="选择"
										onclick="showLayerDialogXY('企业列表','BaseInfo/Enterprise/listForSelect','94%','90%','3%','5%');">
										<i class="icon-plus-sign light-orange bigger-130"></i>
									</a>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 项目名称 </label>
								<input type="hidden" name="id" value='<s:property value="id"/>'>
								<input type="hidden" id="showPath" value='<s:property value="finalPath"/>'/>
								<input type="hidden" id="showId" value='<s:property value="fileId"/>'/>
								<input type="hidden" id="showName" value='<s:property value="fileFileName"/>'/>
								<div class="col-xs-9">
									<input type="text" id="projectName" placeholder="输入名称" name="projectName" class="col-xs-10" value='<s:property value="projectName"/>'/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 项目类型 </label>
	
								<div class="col-xs-9">
									<s:select name="projectType" listKey="name" listValue="name" list="getDictList('projectType')" headerKey="" headerValue="--请选择--"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right" for="form-field-1"> 经度 </label>
								<div class="col-xs-9">
									<input type="text" id="lng" placeholder="输入经度" name="longitude" value='<s:property value="longitude"/>' class="col-xs-5" onchange="chanegePosition()"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right" for="form-field-1"> 纬度 </label>
								<div class="col-xs-9">
									<input type="text" id="lat" placeholder="输入纬度" name="latitude" value='<s:property value="latitude"/>' class="col-xs-5" onchange="chanegePosition()"/>
								</div>
							</div>
							
							<%-- <div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 开始时间 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-DatePicker" name="startDate" class="col-xs-10" readonly value='<s:property value="startDate"/>'/>
								</div>
							</div> --%>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1" style="margin-right:12px;"> 开工日期 </label>
								<div class="input-group isdatepicker" style="margin-left:20px;">
								<input class="form-control date-picker" name="startDate" placeholder="点击选择开始时间" readonly id="form-field-DatePicker isdatepicker" type="text" value='<s:property value="startDate"/>'> <span class="input-group-addon"> <i class="icon icon-calendar bigger-110"></i>
										</span>
									</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 说明  </label>
	
								<div class="col-xs-9">
									<textarea class="form-control limited istextarea" id="editor1" maxlength="600" rows="5" name="explanation"><s:property value="explanation"/></textarea>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 投资金额 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="输入投资金额" name="investmentCapital" class="col-xs-10" value='<s:property value="investmentCapital"/>'/>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 投资类型 </label>
	
								<div class="col-xs-9">
									<s:select name="investmentType" listKey="name" listValue="name" list="getDictList('investType')" headerKey="" headerValue="--请选择--"/>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 建设单位 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-1" placeholder="输入建设单位" name="constructionUnit" class="col-xs-10" value='<s:property value="constructionUnit"/>'/>
								</div>
							</div>
							
							<%-- <div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 计划完成时间 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-DatePicker-finislPlan" placeholder="点击选择计划完成时间" name="planFinishedDate" class="col-xs-10" readonly value='<s:property value="planFinishedDate"/>'/>
								</div>
							</div> --%>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1" style="margin-right:12px;"> 计划完工日期 </label>
								<div class="input-group isdatepicker" style="margin-left:20px;">
								<input class="form-control date-picker" name="planFinishedDate" placeholder="选择计划完成时间" readonly id="form-field-DatePicker isdatepicker" type="text" value='<s:property value="planFinishedDate"/>'> <span class="input-group-addon"> <i class="icon icon-calendar bigger-110"></i>
										</span>
									</div>
							</div>
							<div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1" style="margin-right:12px;">完工日期 </label>
								<div class="input-group isdatepicker" style="margin-left:20px;">
								<input class="form-control date-picker" name="FinishedDate" placeholder="选择完工时间" readonly id="form-field-DatePicker isdatepicker" type="text" value='<s:property value="FinishedDate"/>'> <span class="input-group-addon"> <i class="icon icon-calendar bigger-110"></i>
										</span>
									</div>
							</div>
							<%-- <div class="form-group">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1"> 上报时间 </label>
	
								<div class="col-xs-9">
									<input type="text" id="form-field-DatePicker-report" placeholder="点击选择上报时间" name="opreateTime" class="col-xs-10" readonly value='<s:property value="opreateTime"/>'/>
								</div>
							</div> --%>
							
							</div>
					<input type="hidden" name="filePath" value="">
							<input type="hidden" name="fileMIME" value="">
							<input type="hidden" name="fileName" value="">
							<div class="col-xs-7 no-padding-right">
							<div id="allmap"style="width:630px"></div>
						    </div>
							</div>
							<div class="col-xs-12 no-padding">
						  <div class="form-group">
						    <div class="col-xs-5 no-padding">
								<label class="col-xs-2 control-label no-padding-right"
									for="form-field-1">项目介绍 </label>
									</div>
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
					</form>
					 <div class="col-xs-5 no-padding">
						<div class="form-group">
						<label class="col-xs-2 control-label no-padding-right" for="form-field-1" style="text-align: right;padding-right:5px !important;">附件上传</label>
						<div class="col-xs-6 isfile">
								<form action="BaseInfo/Project/uploadFiles"
									style="border: 0px; background-color:rgba(255,255,255,0);"class="dropzone" id="dropzone">
									<label style="display:none;width: 140px;background-color: #ffffff;height: 35px;position: absolute;left: 260px;"></label>
									<div style="pointer-events: none;margin-left: 5px;margin-top: 10px;">
									<input class="dz-clickable dz-started"type="text" style="height: 35px;font-size:12px;"value="可拖文件上传"/>
									</div>
									<div id="fileSelector">选择</div>
									<!-- <img alt="" src="images/anjian.JPG"> -->
									<div class="fallback">
										<input name="file" type="file" multiple="" />
									</div>
								</form>
								
								
						</div>
						<!-- <button type="submit" id="submit-all" disabled="disabled">上传</button> -->
					</div>
					</div>
						
					
						<%-- <div class="col-xs-6 no-padding-bottom" >
							<style type="text/css"> 
								.anchorBL{ 
								display:none; 
								}
							</style>
							
						</div> --%>

						<div class="col-xs-12 no-padding">
						<div class="clearfix form-actions">
								<div class="col-mx-9 pull-right">
									<button class="btn btn-info" type="button" onclick="$('#townAddForm').submit();">
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
				<!-- PAGE CONTENT ENDS -->
			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->
	</div>
	<!-- /.page-content -->

	<script type="text/javascript">
	var ue = UE.getEditor('editor', {
		autoHeightEnabled : false,
		'textarea' : 'intro'
	});
	var getValue = $("#projectType").attr("data");
	$("#projectType>option").each(function(index ,e){
		if($(this).attr("value") == getValue){
			$(this).prop("selected",true);
		}
	})
	getValue = $("#investmentType").attr("data");
	$("#investmentType>option").each(function(index ,e){
		if($(this).attr("value") == getValue){
			$(this).prop("selected",true);
		}
	})
	
		var townAddValidator;
		jQuery(function($) {
			townAddValidator = $('#townAddForm').validate({
			     focusInvalid: false,
			     rules: {
			    	 enterpriseName:{
			    		 required:true
			    	 },
			    	 projectName:{
							required:true		    	  
					      },
					      investmentCapital:{
					    	  required:true,
					    	  number:true
					      },
					      projectType:{
					    	  required:true	
					      }
			     },
			     messages: {
			    	 enterpriseName:{
				    		required:'<div class="tip-box"><p>请选择企业</p></div>' 
				    	 },
			    	 projectName: {
					       required: '<div class="tip-box"><p>名称不能为空</p></div>'
						  },
						  investmentCapital:{
							  required : '<div class="tip-box"><p>金额不能为空</p></div>',
							  number:'<div class="tip-box"><p>请输入正确的金额</p></div>'
					      },
					      projectType:{
					    	  required:'<div class="tip-box"><p>类型不能为空</p></div>'
					      }
			     },
			     errorPlacement: function(error, element) { 

			    	 if(element.next().is("span")){
			    	 element.parent().after(error);
			    	 }else{
			    	 error.appendTo(element.parent());
			    	 }
			    	 },
			     submitHandler: function (form) {
			    	 /* if (isMark == true) {
					     	$("#lng").val(marker.getPosition().lng);
							$("#lat").val(marker.getPosition().lat);
			    	}else{
			    		$("#lat").val();
						$("#lng").val();
			    	} */
			    	 sendAjax("BaseInfo/Project/save?fileContentType="+type+"&fileFileName="+filename+"&finalPath="+path, $(form).serialize(), function(json){
			    		 if(json.status){
			    			 parent.ui_info(json.info);
			    			 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			    			
			    			 //parent.maincontent_datatable.fnReloadAjax();
			    			 parent.window.location = parent.window.location.href;
			    			 parent.layer.close(index); //再执行关闭  
			    		 }else{
			    			 ui_error(json.info);
			    		 }
			    	 });
			    	 return false;
				 }
			    });
			
				
				
			});
			
			// 百度地图API功能
			var marker;
			var isMark = false;
			var map = new BMap.Map("allmap", {mapType: BMAP_HYBRID_MAP});
			map.centerAndZoom(new BMap.Point(118.881124,28.943067), 14);
			map.addControl(new BMap.NavigationControl()); 
			map.setMinZoom(14);
			map.enableScrollWheelZoom();
			$('#map div.anchorBL').hide();
			if($("#lng").val()!=''&&$("#lat").val()!=''){
				map.centerAndZoom(new BMap.Point($("#lng").val(),$("#lat").val()), 19);
				var point = new BMap.Point($("#lng").val(),$("#lat").val());
				marker = new BMap.Marker(point);// 创建标注
				map.addOverlay(marker);// 将标注添加到地图中
				isMark = true;
			}
			map.addEventListener("click", function(e){
				var point = new BMap.Point(e.point.lng, e.point.lat);
				marker = new BMap.Marker(point);// 创建标注
				if (!isMark) {
					this.addOverlay(marker);// 将标注添加到地图中
					isMark = true;
					$("#lng").val(marker.getPosition().lng);
					$("#lat").val(marker.getPosition().lat);
				}else{
					this.clearOverlays();
					this.addOverlay(marker);// 将标注添加到地图中
					$("#lng").val(marker.getPosition().lng);
					$("#lat").val(marker.getPosition().lat);
				}
			});
			
			function chanegePosition(){
				map.clearOverlays();
				//isMark = false;
				var lat = $("#lat").val();
				var lng = $("#lng").val();
				if(lat!=null && lat!=''&&lng!=null && lng!=''){
					var point = new BMap.Point(lng,lat);
					marker = new BMap.Marker(point);// 创建标注
					map.addOverlay(marker);// 将标注添加到地图中
					map.centerAndZoom(new BMap.Point(lng, lat), 19);//定位
					isMark = true;
				}
			}
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
								var submitButton = document
										.querySelector("#submit-all")
								myDropzone = this; // closure

								/* //为上传按钮添加点击事件
								submitButton.addEventListener("click", function() {
									//手动上传所有图片
									myDropzone.processQueue();
								}); */
								 //回调
								this.on("success", function(file, responseText) {
									var d = eval("(" + responseText + ")");
									if(type!="")type +=",";
									type +=d.DocumentType;
									if(filename!="")filename +=",";
									filename += d.Name;
									if(path!="")path +=",";
									path += d.FilePath;
								});

								/* //当添加图片后的事件，上传按钮恢复可用
								this.on("addedfile", function() {
									$("#submit-all").removeAttr("disabled");
								});

								//删除图片的事件，当上传的图片为空时，使上传按钮不可用状态
								this.on("removedfile", function() {
									if (this.getAcceptedFiles().length == 0) {
										$("#submit-all").attr("disabled", true);
									}
								}); */
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
			function fileDelete(fid){
				$.ajax({
					type:"post",
					url:"BaseInfo/Project/fileDelete",
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
			
		</script>

</body>
</html>
