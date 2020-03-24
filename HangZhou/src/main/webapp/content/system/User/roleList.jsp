<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title>系统管理</title>
<s:include value="/common/include.jsp"></s:include>
<link rel="stylesheet" href="css/list.css">
<link rel="stylesheet" href='<s:url value="/css/css-system.css"/>'>
<script type="text/javascript" src='<s:url value="/js/js-system.js"/>'></script>
<style>
	.blank{
		margin-left:20px;
	}
	.blanklimit{
		margin-left:5px;
	}
</style>
</head>

<body id="framebody">

	<div class="page-content" style="padding: 0px;">

		<div class="row">
			<div class="col-xs-12">
				
				<div class="row" style="padding:0px 12px;">
					<div class="col-xs-12">
					<input type="hidden" id="selectedRole" data-value='<s:property value="inputName"/>' />
						<div class="table-responsive">
						<form id="roleForms">
							<input type="hidden" name="id" value='<s:property value="id"/>' />
							<table id="sample-table-2"
								class="table table-striped table-bordered table-hover font">
								<thead>
									<tr>
										<th>序号</th>
										<th>角色名</th>
										<th>角色描述</th>
 									    <th>操作</th>
									</tr>
								</thead>

								<tbody id="insertData">

								</tbody>
							</table>
							
							</form>
						</div>
					</div>
				</div>

				<div id="modal-table" class="modal fade" tabindex="-1">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header no-padding">
								<div class="table-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">
										<span class="white">&times;</span>
									</button>
									Results for "Latest Registered Domains
								</div>
							</div>

							<div class="modal-footer no-margin-top">
								<button class="btn btn-sm btn-danger pull-left"
									data-dismiss="modal">
									<i class="icon-remove"></i> Close
								</button>

								<ul class="pagination pull-right no-margin">
									<li class="prev disabled"><a href="#"> <i
											class="icon-double-angle-left"></i>
									</a></li>

									<li class="active"><a href="#">1</a></li>

									<li><a href="#">2</a></li>

									<li><a href="#">3</a></li>

									<li class="next"><a href="#"> <i
											class="icon-double-angle-right"></i>
									</a></li>
								</ul>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- PAGE CONTENT ENDS -->
				<div class="col-xs-12 no-padding">
						<div class="clearfix form-actions">
								<div class="col-mx-9 pull-right">
									<button class="btn btn-info" type="button" onclick="submitForm()">
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
			<!-- /.col -->
		</div>
		<!-- /.row -->

	</div>
	<!-- /.page-content -->

		<script type="text/javascript">
			var maincontent_datatable = null;
			var getSelectedVal = $("#selectedRole").attr("data-value");
			var dataArr = new Array();
			if(getSelectedVal.length > 0){
				if(getSelectedVal.indexOf(",") >= 0){
					dataArr = getSelectedVal.split(",");
				}else{
					dataArr[0] = getSelectedVal;
				}
			}
				jQuery(function($) {
					$('[data-rel=tooltip]').tooltip();
						//加载扩展模块
						layer.config({
							extend: 'extend/layer.ext.js'
						});
					
						$(".chosen-select").chosen(); 
						
						maincontent_datatable = $('#sample-table-2').dataTable(
								{
									"oLanguage" : { // 汉化
										"sProcessing" : "正在加载数据...",
										"sLengthMenu" : "显示_MENU_条 ",
										"sZeroRecords" : "没有您要搜索的内容",
										"sInfo" : "从_START_ 到 _END_ 条记录[总记录数为 _TOTAL_ 条]",
										"sInfoEmpty" : "记录数为0",
										"sInfoFiltered" : "(全部记录数 _MAX_  条)",
										"sInfoPostFix" : "",
										"sSearch" : "搜索",
										"sUrl" : "",
										"oPaginate" : {
											"sFirst" : "第一页",
											"sPrevious" : " 上一页 ",
											"sNext" : " 下一页 ",
											"sLast" : " 最后一页 "
										}
									},
									"aoColumns" : [
											{
												"mData" : "id", 
												"mRender" : function(data, type, full) {
													
													return data;
												} 
											},
											{
												 "mData" : "name",
												"mRender" : function(data, type, full) {
													return data;
												} 
											},
											{
											 	   "mData" : "description",
												"mRender" : function(data, type, full) {
													return data;
												}    
											},
											
		/*								    {
												   "mData" : "Fzz",
												"mRender" : function(data, type, full) {
													return data;
												}   
											},
											{
												"mData" : "Longitude",
												"bVisible": false,
												"mRender" : function(data, type, full) {
													return data;
												}
											},
											{
												"mData" : "Latitude",
												"bVisible": false,
												"mRender" : function(data, type, full) {
													return data;
												}
											},
		*/
											{
												"mData" : "id",
												"bSortable" : false,
												"mRender":function (data, type, full) {
													var checkLabel = "";
													for(var i = 0 ; i < dataArr.length ; i++){
														if(parseInt(dataArr[i]) == parseInt(data)){
															checkLabel = "checked";
															break;
														}
													}
													var data = "<div>"+
													"<a data-rel=\"tooltip\" data-placement=\"top\" title=\"\" data-original-title=\"选中\" class=\"blue tooltip-info\" href=\"javascript:void(0);\">"+
													"<i class=\"icon-ok-circle bigger-130\" style=\"display:none;\"></i>"+
													"<input type=\"checkbox\" "+checkLabel+" name=\"selected\" value=\"" + data + "\"/></a></div>";
													
													return data;
												}
											}

									],
									"aoColumnDefs": [{sDefaultContent: '', aTargets: [ '_all' ]}], 
									//"bJQueryUI" : true,
									"bPaginate" : true,// 分页按钮
									"bFilter" : false,// 搜索栏
									"bLengthChange" : false,// 每行显示记录数
									"iDisplayLength" : 10,// 每页显示行数
									"bSort": true,// 排序
									//"aLengthMenu": [[50,100,500,1000,10000], [50,100,500,1000,10000]],//定义每页显示数据数量
									//"iScrollLoadGap":400,//用于指定当DataTable设置为滚动时，最多可以一屏显示多少条数据
									"bInfo" : true,// Showing 1 to 10 of 23 entries 总记录数没也显示多少等信息
									"bWidth" : true, 
									//"sScrollY": "62%",
									//"sScrollX": "210%",
									"bScrollCollapse" : true,
									//"sPaginationType" : "two_button", // 分页，一共两种样式 另一种为two_button // 是datatables默认
									"bProcessing" : true,
									"bServerSide" : true,
									"aaSorting": [[ 0, "desc" ]],
									"bDestroy" : true,
									"bSortCellsTop" : true,
									"sAjaxSource" : 'System/Role/listAllForJQueryDataTable',
									"fnServerData" : function(sSource, aoData,
											fnCallback) {
										var aa = $("#maincontent_dataserchform").serializeArray();
										
									    aa.push({'name':'aoData','value':JSON.stringify(aoData)});
										$.ajax({
											"type" : 'post',
											"url" : sSource,
											"dataType" : "json",
											"data" : aa ,
											"success" : function(resp) {
												fnCallback(resp);
												autoSizeIFrameHeight();
											}
										});
									}
								});
						
						$('table th input:checkbox').on('click' , function(){
							var that = this;
							$(this).closest('table').find('tr > td:first-child input:checkbox')
							.each(function(){
								this.checked = that.checked;
								$(this).closest('tr').toggleClass('selected');
							});
								
						});
					
						$('[data-rel="tooltip"]').tooltip({placement: tooltip_placement});
						function tooltip_placement(context, source) {
							var $source = $(source);
							var $parent = $source.closest('table')
							var off1 = $parent.offset();
							var w1 = $parent.width();
					
							var off2 = $source.offset();
							var w2 = $source.width();
					
							if( parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2) ) return 'right';
							return 'left';
						}
					});
			/* function initData(){
				$.ajax({
					url:"System/Role/treeHTML",
					type:"POST",
					dataType:"html",
					success:function(html){
						if (maincontent_datatable) {
							maincontent_datatable.fnClearTable(0);
							maincontent_datatable.fnDraw();
						}
						$("#insertData").html(html);
						initHtmlButton();
						//showCursor();
						openDataTable();

						alert("fdsa");
						
						alert("fdsa");
					}
				});
			}

			var time = 0;
			function initHtmlButton(){
				$("tbody>tr").each(function(x,i){
					var getClass = $(this).children("td:eq(0)").children("a").children("i").attr("class");
					var getNoneAClass = $(this).children("td:eq(0)").children("i").attr("class");
					var getID = $(this).attr("data-id");
					var getParentID = $(this).attr("data-pid");
					$(this).children("td:eq(2)").html(buttonActionText(getID));
					var b = looop2(getID);
					var html = $(this).children("td:eq(0)").html().replace(/<\/?[^>]*>/g,'');
					//alert(getClass+" "+getNoneAClass);
					if((getClass == null || getClass == "undefined") && (getNoneAClass == null || getNoneAClass == "undefined")){
						if(b){
							if(getParentID == "0"){
								getClass = "icon-double-angle-right bigger-130";
							}else{
								getClass = "icon-angle-right bigger-130";
							}
						}else{
							getClass = "blank";
						}
					}else{
						if(getClass == null || getClass == "undefined"){
							getClass = getNoneAClass;
						}
					}
					if(b){
						$(this).children("td:eq(0)").html("<a class=\"blue\" href=\"javascript:void(0)\"><i class=\"" + getClass + "\" style=\"padding:0 8px 0 4px;\"></i>" + html + "</a>");
					}else{
						$(this).children("td:eq(0)").html("<i class=\"" + getClass + "\"></i>" + html);
					}
				});
			}
			function looop2(id){
				var t = document.getElementsByTagName("tr");
				var i = 0;
				var tlength = t.length;
				for(i = 0 ; i < tlength ; i++){
					var getID = t[i].getAttribute("data-pid");
					if(parseInt(getID) == parseInt(id)){
						var html = t[i].children[0].innerHTML;
						///alert(html);
						return true;
						//t[i].children[0].innerHTML = "<a class=\"blue\" href=\"javascript:void(0)\"><i class=\"icon-circle bigger-130\" style=\"padding:0 8px 0 4px;\"></i>"+html+"</a>";
						//$(this).children("td:eq(0)").html();
					}
				}
					
					/* time ++;
					if(parseInt(getID) == parseInt(id)){
						alert($(this).children("td:eq(0)").html());
						var html = $(this).children("td:eq(0)").html();
						$(this).children("td:eq(0)").html("<a class=\"blue\" href=\"javascript:void(0)\"><i class=\"icon-circle bigger-130\" style=\"padding:0 8px 0 4px;\"></i>"+html+"</a>");
					}
				});
			}
			 *
			function toggleChildNode(obj){
				obj =$(obj).children("a");
				var getid = $(obj).parents("tr").attr("data-id");
				if($(obj).children("i").attr("class") == "icon-double-angle-right bigger-130" || $(obj).children("i").attr("class") == "icon-angle-right bigger-130"){
					if($(obj).children("i").attr("class") == "icon-angle-right bigger-130"){
						$(obj).children("i").attr("class","icon-angle-down bigger-130");
						$("tbody>tr").each(function(x,e){
							if($(this).attr("data-pid") == getid){
								$(this).show(300);
							}
						});
					}else{
						$(obj).children("i").attr("class","icon-double-angle-down bigger-130");
						$("tbody>tr").each(function(x,e){
							if($(this).attr("data-pid") == getid){
								$(this).show(300);
							}
						});
					}
				}else{
					if($(obj).children("i").attr("class") == "icon-angle-down bigger-130"){
						$(obj).children("i").attr("class","icon-angle-right bigger-130");
					}else{
						$(obj).children("i").attr("class","icon-double-angle-right bigger-130");
					}
					hideByRecursion($(obj).parents("tr").attr("data-id"),$(obj).parents("tr").attr("data-level"));
				}
				setTimeout("autoSizePageHeight()",300);
			}
			var maxRound = 0;
			// 递归来实现点击缩回
			function hideByRecursion(id,level){
				id = parseInt(id);
				level = parseInt(level);
				var getAllTr = document.getElementById("insertData").children;
				for(var i = 0 ; i < getAllTr.length ; i++){
					maxRound++;
					var getTrPid = parseInt(getAllTr[i].getAttribute("data-pid"));
					var getTrId = parseInt(getAllTr[i].getAttribute("data-id"));
					var getLevel = parseInt(getAllTr[i].getAttribute("data-level"));
					if(getTrPid == id && getLevel > level){
						$("tbody>tr:eq("+i+")>td:eq(0)>a>i").attr("class","icon-angle-right bigger-130");
						$("tbody>tr:eq("+i+")").hide(300);
						hideByRecursion(getTrId,getLevel);
					}
				}
				
			}
			function searchMaincontentDatatable() {
				if (maincontent_datatable) {
					maincontent_datatable.fnReloadAjax();
				}
			}
			function reloadAjax(){
				$("#insertData").html(""); 
				initData();
			}
			function buttonActionText(data){
				var select = "<div class=\"visible-md visible-lg hidden-sm hidden-xs action-buttons\">"+
				"<a data-rel=\"tooltip\" data-placement=\"top\" title=\"\" data-original-title=\"选中\" class=\"blue tooltip-info\" href=\"javascript:void(0);\" onclick=\"doCheck(this)\">"+
				"<i class=\"icon-ok-circle bigger-130\"></i>"+
				"<input type=\"checkbox\" name=\"selected\" value=\"" + data + "\" style=\"display:none;\"/></a></div>";
				
				return select;
			}
			/* $(document).ready(function(e){
				initData();
				// 设置父级框架滚动条
				parent.$("iframe[id=main]").attr("scrolling","auto");
			}); *
			
			function doCheck(obj){
				var getObjID = $(obj).parents("tr").attr("data-id");
				var getObjLevel = $(obj).parents("tr").attr("data-level");
				checkedThis(obj,"checked");
				//doCheckStart(obj,getObjID,getObjLevel)
			}
			function doCheckStart(obj,id,level){
				id = parseInt(id);
				level = parseInt(level);
				$("tbody>tr").each(function(x,e){
					var getTrPid = parseInt($(this).attr("data-pid"));
					var getTrId = parseInt($(this).attr("data-id"));
					var getLevel = parseInt($(this).attr("data-level"));
					var getObj = $(this).children("td:eq(2)").children("div").children("a");
					if(getTrPid == id && getLevel >= level){
						if($(obj).children("input[name=selected]").prop("checked")){
							checkedThis(getObj,"allCheck");
						}else{
							checkedThis(getObj,"allClean");
						}
						
						doCheckStart(getObj,getTrId,getLevel);
					}
				});
			}
			 */
			
			function submitForm(){
				$.ajax({
					url:"System/User/saveUserRoles",
					data:$("#roleForms").serializeArray(),
					dataType:"JSON",
					type:"POST",
					success:function(json){
						if(json.ok){
			    			 parent.ui_info(json.info);
			    			 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			    			 parent.maincontent_datatable.fnReloadAjax();
			    			 parent.layer.close(index); //再执行关闭  
			    		 }else{
			    			 ui_error(json.info);
			    		 }
					}
				});
			}
			 
			$(function(){
				parent.$("iframe").attr("scrolling","no");
				
			})
		</script>

</body>
</html>