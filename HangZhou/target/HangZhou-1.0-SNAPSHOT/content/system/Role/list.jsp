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
	body {
		width: 99%;
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
						<li class="active">角色管理</li>
					</ul>

				</div>
				<div class="well" style="margin:0 0 10px 0; height: 55px; padding: 3px 0 0 12px;">
						<div class="col-xs-4" style="padding: 8px 0px;">
							<div class="col-xs-4" style="padding:0px;">
								<button onclick="fixedSize('新增','System/Role/insert','640','310');" type="button" class="btn btn-info btn-sm radius-4 font" style="width: 100px; padding: 1px;">
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
										<th>序号</th>
										<th>角色名</th>
										<th>角色描述</th>
 									    <th>操作</th>
									</tr>
								</thead>

								<tbody>

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
			var listNum = 0;
			var prevNum = -1;
			jQuery(function($) {
			$('[data-rel=tooltip]').tooltip();
				//加载扩展模块
				layer.config({
					extend: 'extend/layer.ext.js'
				});
			
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
									
									{
										"mData" : "id",
										"bSortable" : false,
										"mRender":function (data, type, full) {
											var view = "<a class=\"blue tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"详情\" onclick=\"fixedSize('详情','System/Role/view?id="+data+"','633','320');\"> <i class=\" icon-book bigger-130\"></i> </a>";
											var edit = "<a class=\"blue tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"修改\" onclick=\"fixedSize('修改','System/Role/edit?id="+data+"','633','320');\"> <i class=\" icon-pencil bigger-130\"></i> </a>";
											var del = "<a class=\"red tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"删除\" onclick=\"fixedSizeDialog('System/Role/delete?id="+data+"',this);\"> <i class=\"icon-trash bigger-130\"></i> </a>";
											var pubmodule = "<a class=\"green tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"分配权限\" onclick=\"fixedSize('分配权限','System/Role/moduleList?id="+data+"','1000','600');\"> <i class=\" icon-hand-right bigger-130\"></i> </a>";
											return "<div>"+view+edit+pubmodule+del+"</div>";
										}
									}

							],
							"aoColumnDefs": [{sDefaultContent: '', aTargets: [ '_all' ]}], 
							//"bJQueryUI" : true,
							"bPaginate" : true,// 分页按钮
							"bFilter" : false,// 搜索栏
							"bLengthChange" : false,// 每行显示记录数
							"iDisplayLength" : 10,// 每页显示行数
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
							"bServerSide" : true,
							"aaSorting": [[ 0, "desc" ]],
							"bDestroy" : true,
							"bSortCellsTop" : true,
							"sAjaxSource" : 'System/Role/listAllForJQueryDataTable',
							"fnServerData" : function(sSource, aoData,fnCallback) {
								var aa = $("#maincontent_dataserchform").serializeArray();
								
							    aa.push({'name':'aoData','value':JSON.stringify(aoData)});
								$.ajax({
									"type" : 'post',
									"url" : sSource,
									"dataType" : "json",
									"data" : aa ,
									"success" : function(resp) {
										fnCallback(resp);
										autoSizeInLoad();
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
			
			
			
			
			function del(url){
				ui_confirm("确定要删除吗？",function(){
					 sendAjax(url," ", function(json){
			    		 if(json.ok){
			    			 ui_info(json.info);
			    			 maincontent_datatable.fnReloadAjax();
			    		 }else{
			    			 ui_error(json.info);
			    		 }
			    	 });
				  });
			}
			function searchMaincontentDatatable() {
				if (maincontent_datatable) {
					maincontent_datatable.fnReloadAjax();
				}
			}
			</script>

</body>
</html>