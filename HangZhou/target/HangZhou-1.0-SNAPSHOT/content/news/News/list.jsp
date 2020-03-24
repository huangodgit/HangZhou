<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<title><s:property value="menuTitle"/></title>
<s:include value="/common/include.jsp"></s:include>
<link rel="stylesheet" type="text/css" href="css/list.css">
</head>

<body>

	<div class="page-content" style="padding: 0px;">

		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<div class="breadcrumbs" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="icon-home home-icon"></i> <a href="main.jsp">主页</a></li>

						<li><a href="javascript:void(0)"><s:property value="menuTitle"/></a></li>
						<li class="active"><s:property value="newsType"/></li>
					</ul>

				</div>
				<form id="maincontent_dataserchform">
					<div class="well padding8" style="margin: 0px; height: 95px;">
						<div class="col-xs-12 font14"
							style="padding: 0px; padding-bottom: 8px;">

							<s:if test="loginUser.loginName=='admin'">
							</s:if>
							<div class="col-xs-3">
								<input type="text" id="form-field-1" placeholder="标题"
									name="title" class="col-xs-12">
							</div>
							<div class="col-xs-1">
								<button type="button" style="margin: 0px; padding: 2px;"
									onclick="searchMaincontentDatatable();"
									class="btn btn-purple btn-sm font14">
									查询 <i class="icon-search icon-on-right bigger-110"></i>
								</button>
							</div>
						</div>
						<hr class="width-100"
							style="margin: 0px; border-top: 1px solid #d5e3ef;">
						<div class="col-xs-12" style="padding: 8px 0px;">
							<div class="col-xs-4" style="padding: 0px;">
								<div class="col-xs-4">
									<button
										onclick="showLayerDialog('<s:property value='newsType'/>'+'新增','News/News/insert?newsType='+'<s:property value='newsType'/>','100%', '100%')"
										type="button" class="btn btn-info btn-sm radius-4 font14"
										style="width: 100px; padding: 1px;">
										<i class="icon-plus-sign align-top bigger-125"></i> 新增
									</button>
								</div>
							</div>
							<div class="col-xs-8"></div>
						</div>	
					</div>
				</form>
				<div class="row" style="padding: 0px 12px;">
					<div class="col-xs-12">

						<div class="table-responsive">
							<table id="sample-table-2" style="table-layout:fixed"
								class="table table-striped table-bordered table-hover font14">
								<thead>
									<tr>
										<th style="width: 10%;">序号</th>
										<th style="width: 20%;">标题</th>
										<th style="width: 10%;">发布人</th>
										<th style="width: 15%;">发布时间</th>
										<th style="width: 15%;">状态</th>
										<th style="width: 15%;">操作</th>
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
			$('[data-rel=tooltip]').tooltip();
			//加载扩展模块
			layer.config({
				extend : 'extend/layer.ext.js'
			});

			$(".chosen-select").chosen();
			maincontent_datatable = $('#sample-table-2')
					.dataTable(
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
								"aoColumns" : [
										{
											"mData" : "id",
											"mRender" : function(data, type,
													full) {
												return "<span class='tableSpan'>"+data+"</span>";
											}
										},
										{
											"mData" : "title",
											"mRender" : function(data, type,
													full) {
												var len = data.length;
												if (len > 21) {
													data = data
															.substring(0, 21);
													data += "...";
												}
												return "<span class='tableSpan'>"+data+"<span/>";
											}
										},
										{
											"mData" : "operator",
											"bSortable":false,
											"mRender" : function(data, type,
													full) {
												return "<span class='tableSpan'>"+data+"</span>";
											}
										},
										{
											"mData" : "operateTime",
											"mRender" : function(data, type,
													full) {
												return "<span class='tableSpan'>"+data+"</span>";
											}
										},
										{
											"mData" : "status",
											"mRender" : function(data, type,
													full) {
												return "<span class='tableSpan'>"+data+"</span>";
											}
										},
										{
											"mData" : "id",
											"bSortable":false,
											"mRender" : function(data, type,
													full) {
												var view = "<a class=\"blue tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"详细信息\" onclick=\"showLayerDialog('详细信息','News/News/view?id="
														+ data
														+ "','100%', '100%');\"> <i class=\" icon-book bigger-130\"></i> </a>";
												var edit = "<a class=\"green tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"修改\" onclick=\"showLayerDialog('修改','News/News/edit?id="
														+ data
														+ "','100%', '100%');\"> <i class=\"icon-pencil bigger-130\"></i> </a>";
														var res="";
														
														if(full.status=='已转为待决策项目'&&full.handleTime!=undefined){
															res = "<a class=\"grey tooltip-info\" style=\"cursor: no-drop;\"id=\"res\"data-rel=\"tooltip\" data-placement=\"top\" title=\"已处理\" > <i class=\"icon-edit bigger-130\"></i> </a>";
															
													}else{
														res = "<a class=\"green tooltip-info\" id=\"res\"data-rel=\"tooltip\" data-placement=\"top\" title=\"处理\" onclick=\" showLayerDialogXY('处理','News/News/handle?id="
															+ data+"','60%', '48%','3%','20%')\"> <i class=\"icon-edit bigger-130\"></i> </a>";
													}
														
														
													
														
												var del = "<a class=\"red tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"删除\"  onclick=\"del('News/News/delete?id="
														+ data
														+ "');\"> <i class=\"icon-trash bigger-130\"></i> </a>";
											if(full.topNumber!=1){
											    var up =  "<a class=\"orange tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"置顶\" onclick=\"Stick('News/News/stick?id="
													+ data
													+ "');\" > <i class=\"icon-circle-arrow-up bigger-130\"></i> </a>";
											   }else{
											    var up=  "<a class=\"green tooltip-info\" data-rel=\"tooltip\" data-placement=\"top\" title=\"取消置顶\" onclick=\"canelStick('News/News/canelStick?id="
													+ data
													+ "');\" > <i class=\"icon-circle-arrow-down bigger-130\"></i> </a>";
													}
												return "<div class=\"action-buttons\">"
														+ view
														+ edit
														+ res+up
														+ del + "</div>";
											}
										}

								],
								//"bJQueryUI" : true,
								"bPaginate" : true,// 分页按钮
								"bFilter" : false,// 搜索栏
								"bLengthChange" : false,// 每行显示记录数
								"iDisplayLength" : 10,// 每页显示行数
								"bSort" : true,// 排序
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
					            "bStateSave" : true,
								"sAjaxSource" : 'News/News/listAllForJQueryDataTable?menuTitle=' + "<s:property value='menuTitle'/>" + "&&newsType=" + "<s:property value='newsType'/>",
								"fnServerData" : function(sSource, aoData,
										fnCallback) {
									var aa = $("#maincontent_dataserchform")
											.serializeArray();
									aa.push({
										'name' : 'aoData',
										'value' : JSON.stringify(aoData)
									});
									$.ajax({
										"type" : 'post',
										"url" : sSource,
										"dataType" : "json",
										"data" : aa,
										"success" : function(resp) {
											fnCallback(resp);
										}
									});
								}
							});

			$('table th input:checkbox').on(
					'click',
					function() {
						var that = this;
						$(this).closest('table').find(
								'tr > td:first-child input:checkbox').each(
								function() {
									this.checked = that.checked;
									$(this).closest('tr').toggleClass(
											'selected');
								});

					});

			$('[data-rel="tooltip"]').tooltip({
				placement : tooltip_placement
			});
			function tooltip_placement(context, source) {
				var $source = $(source);
				var $parent = $source.closest('table');
				var off1 = $parent.offset();
				var w1 = $parent.width();

				var off2 = $source.offset();
				var w2 = $source.width();

				if (parseInt(off2.left) < parseInt(off1.left)
						+ parseInt(w1 / 2))
					return 'right';
				return 'left';
			}
		});

		function del(url) {
			ui_confirm("确定要删除吗？", function() {
				sendAjax(url, " ", function(json) {
					if (json.status) {
						ui_info(json.info);
						maincontent_datatable.fnReloadAjax();
					} else {
						ui_error(json.info);
					}
				});
			});
		}
		function toDecided(url,obj){
			ui_confirm("确定转为已决策吗？",function(){
				 sendAjax(url," ", function(json){
		    		 if(json.status){
		    			 ui_info("已成功转为已决策");
		    			 maincontent_datatable.fnReloadAjax();
		    			 
		    		 }else{
		    			 ui_error("转换失败");
		    		 }
		    	 });
			  });
		}

		function Stick(url) {
			ui_confirm("确定置顶吗？", function() {
				sendAjax(url, " ", function(json) {
					if (json.status) {
						ui_info(json.info);
						maincontent_datatable.fnReloadAjax();
					} else {
						ui_error(json.info);
					}
				});
			});
		}
		function canelStick(url) {
			ui_confirm("确定取消置顶吗？", function() {
				sendAjax(url, " ", function(json) {
					if (json.status) {
						ui_info(json.info);
						maincontent_datatable.fnReloadAjax();
					} else {
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