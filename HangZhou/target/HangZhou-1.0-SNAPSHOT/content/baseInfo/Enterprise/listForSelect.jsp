<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title>企业列表</title>
<s:include value="/common/include.jsp"></s:include>

</head>

<body>


	<div class="page-content">
		<div>
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<form id="maincontent_dataserchform" class="row">
				<div class="well" style="margin: 0px; height: 50px; padding: 12px;">
					<div class="col-xs-12" style="padding:0px;padding-bottom:8px;">
						<div class="col-xs-2">
							<input type="text" id="form-field-1" placeholder="企业名称" class="col-xs-12" name="name">
						</div>
						<div class="col-xs-1">
							<button type="button" style="margin: 0px; padding: 2px;" onclick="searchMaincontentDatatable();"
								class="btn btn-purple btn-sm">
								查询 <i class="icon-search icon-on-right bigger-110"></i>
							</button>
						</div>
					</div>
				</div>
				</form>
				<div class="row">
					<div class="col-xs-12 no-padding">

						<div class="table-responsive">
							<table id="sample-table-2"
								class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<th>序号</th>
										<th>企业名称</th>
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
			jQuery(function($) {
				
				sendAjax("BaseInfo/Town/getAreaData?type=noid", "", function(json){
					$('#element_id').cxSelect({
						  url: json,
						  selects: ['town', 'village', 'nvillage'],
						  firstValue: ''
					});
		    	 });
				
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
										"mData" : "id",
										"mRender":function (data, type, full) {
											var view = "<a class=\"blue tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"详情\" onclick=\"showLayerDialog('详细信息','BaseInfo/Enterprise/view?id="+data+"','100%','100%');\"> <i class=\" icon-book bigger-130\"></i> </a>";
											var select = "<a class=\"blue tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"选择\" onclick=\"selectEnterprise('"+data+"','"+full.name+"');\"> <i class=\" icon-check bigger-130\"></i> </a>";
											return select+view;
					                    }
									}

							],
							"bJQueryUI" : true,
							"bPaginate" : true,// 分页按钮
							"bFilter" : false,// 搜索栏
							"bLengthChange" : false,// 每行显示记录数
							"iDisplayLength" : 10,// 每页显示行数
							"bSort": true,// 排序
							//"aLengthMenu": [[50,100,500,1000,10000], [50,100,500,1000,10000]],//定义每页显示数据数量
							//"iScrollLoadGap":400,//用于指定当DataTable设置为滚动时，最多可以一屏显示多少条数据
							//"aaSorting": [[4, "desc"]],
							"bInfo" : true,// Showing 1 to 10 of 23 entries 总记录数没也显示多少等信息
							"bWidth" : true,
							//"sScrollY": "62%",
							//"sScrollX": "210%",
							"bScrollCollapse" : true,
							//"sPaginationType" : "two_button", // 分页，一共两种样式 另一种为two_button // 是datatables默认
							"bProcessing" : true,
							"bServerSide" : true,
							"bDestroy" : true,
							"bSortCellsTop" : true,
							"sAjaxSource" : 'BaseInfo/Enterprise/listAllForJQueryDataTable',
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
			
			
			
		function searchMaincontentDatatable() {
				if (maincontent_datatable) {
					maincontent_datatable.fnReloadAjax();
				}
			}
		
		//单选
		function selectEnterprise(id,name){
			parent.$("#enterpriseName").val(name);
			parent.$("#enterpriseId").val(id);
			var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			parent.layer.close(index); //再执行关闭  
		}
		
	
		</script>

</body>
</html>