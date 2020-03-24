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
	body{
		background: #fff;
	}
</style>
</head>

<body>

	<div class="page-content" style="padding: 0px;">

		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div class="breadcrumbs" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="icon-home home-icon"></i> <a href="#">主页</a></li>

						<li><a href="#">系统管理</a></li>
						<li class="active">机构管理</li>
					</ul>

				</div>
				<div class="well" style="margin:0 0 10px 0; height: 55px; padding: 3px 0 0 12px;">
						<div class="col-xs-4" style="padding: 8px 0px;">
							<div class="col-xs-4" style="padding:0px;">
								<button onclick="fixedSize('新增','System/Org/insert','959','490');" type="button" class="btn btn-info btn-sm radius-4 font" style="width: 100px; padding: 1px;">
									<i class="icon-plus-sign align-top bigger-125"></i> 新增
								</button>
							</div>
						</div>
						<div style="clear:both"></div>
					
				</div>
				<div class="row" style="padding:0px 12px;">
					<div class="col-xs-12">

						<div class="table-responsive">
							<table id="sample-table-2"
								class="table table-striped table-bordered table-hover font">
								<thead>
									<tr>
										<th>机构名</th>
										<th>机构代号</th>
										<th>描述</th>
 									    <th>操作</th>
									</tr>
								</thead>

								<tbody id="insertData">

								</tbody>
							</table>
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


			</div>
			<!-- /.col -->
		</div>
		<!-- /.row -->

	</div>
	<!-- /.page-content -->

		<script type="text/javascript">
			var maincontent_datatable = null;
			var reOpen = false;
			var expandData = "";
			var selectedID = null;
			function del(url,obj){
				ui_confirm("确定要删除吗？",function(){
					 sendAjax(url," ", function(json){
			    		 if(json.ok){
			    			 ui_info(json.info);
			    			 //maincontent_datatable.fnReloadAjax();
			    			 $(obj).parents("tr").hide(300,function(){
			    				 $(this).remove();
			    				 initHtmlButton();
			    			 });
			    		 }else{
			    			 ui_error(json.info);
			    		 }
			    	 });
				  });
			}

			$(document).ready(function(e){
				initData();
				// 设置父级框架滚动条
				//parent.$("iframe[id=main]").attr("scrolling","auto");
			});
			function openDataTable(){
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
									"aoColumnDefs": [{sDefaultContent: '', aTargets: [ '_all' ]}], 
									//"bJQueryUI" : true,
									"bPaginate" : false,// 分页按钮
									"bFilter" : false,// 搜索栏
									"bLengthChange" : false,// 每行显示记录数
									"iDisplayLength" : 100000000,// 每页显示行数
									"bSort": false,// 排序
									//"aLengthMenu": [[50,100,500,1000,10000], [50,100,500,1000,10000]],//定义每页显示数据数量
									//"iScrollLoadGap":400,//用于指定当DataTable设置为滚动时，最多可以一屏显示多少条数据
									"bInfo" : true,// Showing 1 to 10 of 23 entries 总记录数没也显示多少等信息
									"bWidth" : true, 
									//"sScrollY": "62%",
									//"sScrollX": "210%",
									"bScrollCollapse" : true,
									//"sPaginationType" : "two_button", // 分页，一共两种样式 另一种为two_button // 是datatables默认
									"bProcessing" : true,
									"bServerSide" : false,
									"bDestroy" : true,
									"bSortCellsTop" : true,
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
			}
			function initData(expadData,expandList){
				$.ajax({
					url:"System/Org/treeHTML",
					type:"POST",
					data:{expandStr:expandData,expandList:expandList},
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
						autoSizeInLoad();
						if(reOpen){
							reOpen = false;
							objChanger(selectedID);
						}
					}
				});
			}
			function objChanger(id){
				if(id == null){
					return false;
				}
				$("tbody>tr").each(function(x,i){
					var getID = $(this).attr("data-id");
					if(getID == id){
						var getExpand = $(this).attr("expand");
						if(getExpand == "1"){
							// 一关一开
							toggleChildNode($(this).children("td:eq(0)"));
							toggleChildNode($(this).children("td:eq(0)"));
						}
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
					$(this).children("td:eq(3)").html(buttonActionText(getID,$(this).attr("data-pid")));
					var b = looop2(getID);
					var getExpand = $(this).attr("expand");
					var html = $(this).children("td:eq(0)").html();
					try{
						html = html.replace(/<\/?[^>]*>/g,'');
					}catch(e){}
					//alert(getClass+" "+getNoneAClass);
					if((getClass == null || getClass == "undefined") && (getNoneAClass == null || getNoneAClass == "undefined")){
						if(b){
							if(getParentID == "0"){
								if(getExpand == "0"){
									getClass = "icon-double-angle-right bigger-130";
								}else{
									getClass = "icon-double-angle-down bigger-130";
								}
								
							}else{
								if(getExpand == "0"){
									getClass = "icon-angle-right bigger-130";
								}else{
									getClass = "icon-angle-down bigger-130";
								}
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
						$(this).children("td:eq(0)").html("<a class=\"blue\" href=\"javascript:void(0)\"><i class=\"" + getClass + "\" style=\"padding:0 8px 0 10px;\"></i>" + html + "</a>");
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
				}); */
			}
			// 存储当前点击的ID,name 设置点击添加时默认的上级
			var clickedID = "";
			var clickedName = ""
			function toggleChildNode(obj){
				obj =$(obj).children("a");
				var getid = $(obj).parents("tr").attr("data-id");
				clickedID = getid;
				clickedName = $(obj).html();
				try{
					clickedName = clickedName.replace(/<\/?[^>]*>/g,'')
				}catch(e){}
				if($(obj).children("i").attr("class") == "icon-double-angle-right bigger-130" || $(obj).children("i").attr("class") == "icon-angle-right bigger-130"){
					$(obj).parents("tr").attr("expand","1");
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
					$(obj).parents("tr").attr("expand",0);
					if($(obj).children("i").attr("class") == "icon-angle-down bigger-130"){
						$(obj).children("i").attr("class","icon-angle-right bigger-130");
					}else{
						$(obj).children("i").attr("class","icon-double-angle-right bigger-130");
					}
					hideByRecursion($(obj).parents("tr").attr("data-id"),$(obj).parents("tr").attr("data-level"));
				}
				// 和动画伸缩时间一致,可以动态更改长度
				autoSizeDelay();
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
						$("tbody>tr:eq("+i+")").attr("expand","0");
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
				expandData = toJsonArray(getAllExpandRow(),"expand");
				expandList = toJsonArray(getAllExpandList(),"expandList");
				initData(expandData,expandList);
			}
			function buttonActionText(data,parentID){
				var view = "<a class=\"blue tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"详情\" onclick=\"fixedSize('详情','System/Org/view?id="+data+"','950','630');\"> <i class=\" icon-book bigger-130\"></i> </a>";
				var edit = "";
				if(parentID != 0){
					edit = "<a class=\"blue tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"修改\" onclick=\"fixedSize('修改','System/Org/edit?id="+data+"','950','490');\"> <i class=\" icon-pencil bigger-130\"></i> </a>";
				}
				var del = "<a class=\"red tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"删除\" onclick=\"fixedSizeDialog('System/Org/delete?id="+data+"',this);\"> <i class=\"icon-trash bigger-130\"></i> </a>";
				return "<div>"+view+edit+del+"</div>";
			}
			/* 
			function queryByStartTime(){
				if (maincontent_datatable) {
					var getValue = $("input[name=sortByTime]").val();
					if(getValue == "1"){
						$("#sortBtn").html("<i class='icon-arrow-down bigger-125'></i>按开始时间降序");
						$("input[name=sortByTime]").val("0");
					}else{
						$("input[name=sortByTime]").val("1");
						$("#sortBtn").html("<i class='icon-arrow-up bigger-125'></i>按开始时间升序");
					}
				}
			} */
		</script>

</body>
</html>