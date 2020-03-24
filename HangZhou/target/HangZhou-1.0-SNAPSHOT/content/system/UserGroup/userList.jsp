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
</head>

<body id="framebody">

	<div class="page-content" style="padding: 0px;">

		<div class="row">
			<div class="col-xs-12">
				<!-- PAGE CONTENT BEGINS -->
				<!-- <div class="breadcrumbs" id="breadcrumbs">
					<ul class="breadcrumb">
						<li><i class="icon-home home-icon"></i> <a href="#">主页</a></li>

						<li><a href="#">系统管理</a></li>
						<li class="active">用户管理</li>
					</ul>

				</div> -->
				
				<input type="hidden" id="selectedUser" data-value='<s:property value="selectedUser"/>' />
				<form id="formSelect">
				<input type="hidden" name="id" value='<s:property value="id"/>' />
				<div class="row" style="padding:0px 12px;">
					<div class="col-xs-12">

						<div class="table-responsive">
							<table id="sample-table-2"
								class="table table-striped table-bordered table-hover font">
								<thead>
									<tr>
										<th>序号</th>
										<th>用户名</th>
										<th>显示名称</th>
										<th>姓名</th>
										<th>电话</th>
 									    <th>操作</th>
									</tr>
								</thead>

								<tbody>
									<s:iterator value="userList" status="st">
										<tr data-id='<s:property value="id" />'>
											<td><s:property value="#st.index+1" /></td>
											<td><s:property value="name" /></td>
											<td><s:property value="loginName" /></td>
											<td><s:property value="member.name" /></td>
											<td><s:property value="member.phone" /></td>
											<td><div>
												<a data-rel="tooltip" data-placement="top" title="" data-original-title="选中" class="blue tooltip-info" href="javascript:void(0);">
												<!-- <i class="icon-ok-circle bigger-130"></i> -->
												<input type="checkbox" name="selected" value='<s:property value="id" />'/></a></div></td>
										</tr>
									</s:iterator>
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
			var listNum = 0;
			var prevNum = -1;

			$(function(){
				parent.$("iframe").attr("scrolling","no");
				selectIfSelected();
				loadDatatable();
				autoSizeIFrameHeight(true);
			})
			function loadDatatable(){
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
								},//"bJQueryUI" : true,
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
								"bServerSide" : false,
								"aaSorting": [[ 0, "desc" ]],
								"bDestroy" : true,
								"bSortCellsTop" : true
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
			function searchMaincontentDatatable() {
				if (maincontent_datatable) {
					maincontent_datatable.fnReloadAjax();
				}
			}
			function submitForm(){
				$.ajax({
					url:"System/UserGroup/editUser",
					data:$("#formSelect").serializeArray(),
					dataType:"JSON",
					type:"POST",
					success:function(json){
						if(json.ok){
			    			 parent.ui_info(json.info);
			    			 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			    			// parent.maincontent_datatable.fnReloadAjax();
			    			 parent.reloadAjax();
			    			 parent.layer.close(index); //再执行关闭  
			    		 }else{
			    			 ui_error(json.info);
			    		 }
					}
				});
			}
			function selectIfSelected(){
				
				var getSelectedVal = $("#selectedUser").attr("data-value");
				var dataArr = new Array();
				if(getSelectedVal.length > 0){
					if(getSelectedVal.indexOf(",") >= 0){
						dataArr = getSelectedVal.split(",");
					}else{
						dataArr[0] = getSelectedVal;
					}
				}
				$("table>tbody>tr").each(function(x,i){
					for(var i = 0 ; i < dataArr.length ; i++){
						if(parseInt($(this).attr("data-id")) == parseInt(dataArr[i])){
							checkSingle($(this).children("td:eq(5)").children("div").children("a"));
							break;
						}
					}
				});
			}
		</script>

</body>
</html>