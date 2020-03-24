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
					<input type="hidden" id="selected" data-value='<s:property value="roleQueryName"/>' />
						<div class="table-responsive">
						<form id="roleForms">
							<input type="hidden" name="id" value='<s:property value="id"/>' />
							<table id="sample-table-2"
								class="table table-striped table-bordered table-hover font">
								<thead>
									<tr>
										<th>模块名</th>
										<th>模块代号</th>
										<th>模块权限</th>
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
			var publicObj = null;
			var savedObj = null;
			expandData = "";
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
			function initData(){
				$.ajax({
					url:"System/Module/treeHTML",
					type:"POST",
					dataType:"html",
					success:function(html){
						if (maincontent_datatable) {
							maincontent_datatable.fnClearTable(0);
							maincontent_datatable.fnDraw();
						}
						$("#insertData").html(html);
						setNewEnabled();
						initHtmlButton();
						//selectIfSelected(3);
						initDataIsHalf();
						//showCursor();
						try{
							openDataTable();
						}catch(e){}
						autoSizeiFrameInnerInLoad();
						//autoSizeIFrameHeight();
					}
				});
			}
			
			function initButtonInAjax(){
				$("tbody>tr").each(function(x,i){
					var getID = $(this).attr("data-id");
					var getLevel = $(this).attr("data-level");
					var getEnable = $(this).attr("data-enable");
					var b = looop2(getID,getLevel); // 如果有子级,返回true
					$(this).children("td:eq(5)").html(checkBox(getID,getEnable,b[1],b[2]));
				});
			}
			var time = 0;
			function initHtmlButton(){
				$("tbody>tr").each(function(x,i){
					var getClass = $(this).children("td:eq(0)").children("a").children("i").attr("class");
					var getNoneAClass = $(this).children("td:eq(0)").children("i").attr("class");
					var getID = $(this).attr("data-id");
					var getParentID = $(this).attr("data-pid");
					var getLevel = $(this).attr("data-level");
					var getEnable = $(this).attr("data-enable");
					var getDataPermission = $(this).attr("data-permission");
					$(this).children("td:eq(4)").attr("style","display:none");
					$(this).children("td:eq(5)").attr("style","display:none");
					var b = looop2(getID,getLevel); // 如果有子级,返回true
					$(this).children("td:eq(3)").html(checkBox(getID,getEnable,b[1],b[2]));
					var html = $(this).children("td:eq(0)").html().replace(/<\/?[^>]*>/g,'');
					//alert(getClass+" "+getNoneAClass);
					if((getClass == null || getClass == "undefined") && (getNoneAClass == null || getNoneAClass == "undefined")){
						if(b[0] == 1){
							
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
								getClass = "blank";
						}
					}
					if(b[0] == 1){
						$(this).children("td:eq(0)").html("<a class=\"blue\" href=\"javascript:void(0)\"><i class=\"" + getClass + "\" style=\"padding:0 8px 0 10px;\"></i>" + html + "</a>");
					}else{
						$(this).children("td:eq(0)").html("<i class=\"" + getClass + "\"></i>" + html);
					}
				});
			}
			function initDataIsHalf(){
				var t = document.getElementsByTagName("tbody")[0].childNodes;
				for(var i = 0 ; i < t.length ; i++){
					var getEnabled = t.item(i).getAttribute("data-enable");
					var getChildrenChecked = t.item(i).childNodes.item(3).firstChild.firstChild;
					if(getChildrenChecked != null){
						var getinde = parseInt(getChildrenChecked.getAttribute("data-inde"));
						if(getinde == 1){
							getChildrenChecked.firstChild.indeterminate = true;
						}else if(getinde == 2){
							getChildrenChecked.firstChild.indeterminate = false;
						}
						
					}
				}
			}
			var scanNum = 0; // 扫描总数
			var isChecked = 0; // 扫描选择勾选总数
			//var nowScannedNum = 0;
			
			var breakFlag = false; // 跳出标记
			function looop2(id,level){
				var dataArr = new Array();
				var t = document.getElementsByTagName("tr");
				var i = 0;
				var tlength = t.length;
				var returnStatus = 0; // 返回是否有孩子
				breakFlag = false;
				scanNum = 0; // 扫描是否半选总数
				isChecked = 0; // 选择勾选总数
				for(i = 0 ; i < tlength ; i++){
					if(!breakFlag){ // 跳出标记,防止重复循环
						var getPosition = getNowIDPositon(id); // 获得当前ID的序号;
						if(t[getPosition].getAttribute("data-level") != null){
							findChildrenIsChecked(id,getPosition,level);
							
						}
					}
					var getID = t[i].getAttribute("data-pid");
					var getEnabled = t[i].getAttribute("data-enable");
					if(parseInt(getID) == parseInt(id)){
						var html = t[i].children[0].innerHTML;
						var getTd = t[i].childNodes.item(5).childNodes.item(0);
						returnStatus = 1;
					} 
				}
			
				dataArr.push(returnStatus);
				dataArr.push(isChecked);
				dataArr.push(scanNum);
				return dataArr;
			}
			
			function findChildrenIsChecked(id,nowNum,level){  // 递归
				var t = document.getElementsByTagName("tr");
				for(var i = nowNum+1 ; i < t.length ; i++){ // 从当前对象的下一个对象开始检索
					if(breakFlag){ // 如果标记为跳出的,跳出
						break;
					}
					getTrId = parseInt(t[i].getAttribute("data-id"));
					getlevel = parseInt(t[i].getAttribute("data-level"));
					if(level != null && getlevel != null && getlevel > level){ // 如果当前level小于参数的level,将跳出,节省循环次数
					scanNum++;  // 计入扫描的总数
						var getEnabled = parseInt(t[i].getAttribute("data-enable"));
						if(getEnabled == 1){
							isChecked ++; // 若勾选,则累加
							findChildrenIsChecked(getTrId,i,getlevel);
						}else{ // 若不是,则跳出
							breakFlag = true;
						}
					}else{ // 若扫描到上一层,跳出
						break;
					}
				}
			}
			function getNowIDPositon(id){
				var i = 0;
				var t = document.getElementsByTagName("tr");
				for(i = 0 ; i < t.length ; i++){
					var getID = t[i].getAttribute("data-id");
					if(getID != null && id == getID){
						break;
					}
				}
				return i;
			}
			// 存储当前点击的ID,name 设置点击添加时默认的上级
			var clickedID = "";
			var clickedName = ""
			function toggleChildNode(obj){
				obj =$(obj).children("a");
				var getid = $(obj).parents("tr").attr("data-id");
				clickedID = getid;
				clickedName = $(obj).html().replace(/<\/?[^>]*>/g,'');
				if($(obj).children("i").attr("class") == "icon-double-angle-right bigger-130" || $(obj).children("i").attr("class") == "icon-angle-right bigger-130"){
					$(obj).parents("tr").attr("expand",1);
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
						$("tbody>tr:eq("+i+")").attr("expand",0);
						$("tbody>tr:eq("+i+")").hide(300);
						hideByRecursion(getTrId,getLevel);
					}
				}
			}
			var jsonObject = null;
			var permName = "";
			var getNowPosition = 0;
			
			function openChildrenBtn(obj,id){
				toggleChildNode($(obj).parents("tr").children("td:eq(0)"));
				return false;
			}
			
			function checkBox(id,isChecked,checked,total){
				//alert(checked+","+total);
				
				var checkLabel = "checked"; // 选中属性
				var tipsLabel = "取消选中"; // 取消选中文本
				var func = ""; // 方法
				var halfCheck = "0"; // 半选 默认为空 0=空 1=半选 2=全选
				// 父子全勾住
				if(isChecked == "1"){
					checkLabel = "checked";
					tipsLabel = "取消选中"
					if(total == 0){ // is children
						func = "checkSingle(this,3,"+id+")";
						halfCheck = "2";
					}else{
						if(total - checked == 0){ // children all checked
							func = "checkMultiple(this,3,false);";
							halfCheck = "2";
						}else{ // children noe cheched All
							func = "checkMultiple(this,3,false);";
							halfCheck = "1";
						}
					}
				}else{
					checkLabel = "";
					tipsLabel = "选中"
					halfCheck = "0";
					if(total == 0){
						func = "checkSingle(this,3,"+id+")";
					}else if(total - checked == 0){ // children all checked
						func = "checkMultiple(this,3,true);";
					}else{ // children noe cheched All
						func = "checkMultiple(this,3,true);";
					}
				}
				// 父勾住子未勾住
				var checkbox = "<div>"+
				"<a data-rel=\"tooltip\" data-inde="+halfCheck+" data-placement=\"top\" title=\"\" data-original-title=\""+tipsLabel+"\" class=\"blue tooltip-info\" href=\"javascript:void(0);\" onclick=\""+func+"\">"+
				"<input type=\"checkbox\" value="+id+" id=\"selected\" name=\"selected\" "+checkLabel+" >"+
				"</a></div>";
				return checkbox;
			}
			function checkSingle(obj,position,id){
				var checkStatus = $(obj).children("input").prop("checked"); 
				if(checkStatus){
   				 	$(obj).parents("tr").attr("data-enable","1");
	   			}else{
	   				$(obj).parents("tr").attr("data-enable","0");
	   			}
			}
			function changeAllParents(id,pid,level){
				var allTr = document.getElementsByTagName("tbody")[0].childNodes;
				for(var i = 0 ; i < allTr.length ; i++){
					var getId = allTr.item(i).getAttribute("data-id");
					var getpid = allTr.item(i).getAttribute("data-pid");
					var getLevel = allTr.item(i).getAttribute("data-level");
					if(pid == getId){ // 当存在父级 == 当前id时,表明当前扫描对象为选中的父级对象
						allTr.item(i).lastChild.firstChild.setAttribute("data-inde","1");
						changeAllParents(getId,getpid,getLevel);
					}else if(id == getId){
						break;
					}
				}
			}
			function setNewEnabled(){
				var getSelectedVal = $("#selected").attr("data-value");
				var dataArr = new Array();
				if(getSelectedVal.length > 0){
					if(getSelectedVal.indexOf(",") >= 0){
						dataArr = getSelectedVal.split(",");
					}else{
						dataArr[0] = getSelectedVal;
					}
				}
				var noSetted = true;
				$("table>tbody>tr").each(function(x,i){
					for(var i = 0 ; i < dataArr.length ; i++){
						noSetted = false;
						if(parseInt($(this).attr("data-id")) == parseInt(dataArr[i])){
							$(this).attr("data-enable","1");
							
							break;
						}else{
							$(this).attr("data-enable","0");
						}
					}

					if(noSetted){
						$(this).attr("data-enable","0");
					}
				});
			}

			function submitForm(){
				$.ajax({
					url:"System/Role/saveRoleModule",
					data:$("#roleForms").serializeArray(),
					dataType:"JSON",
					type:"POST",
					success:function(json){
						if(json.ok){
			    			 parent.ui_info(json.info);
			    			 var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
			    			 parent.maincontent_datatable.fnReloadAjax();
			    			 //parent.reloadAjax();
			    			 parent.layer.close(index); //再执行关闭  
			    		 }else{
			    			 ui_error(json.info);
			    		 }
					}
				});
			}
			$(function(){
				parent.$("iframe").attr("scrolling","auto");
				$("body").attr("style","overflow-x:hidden");
			});
			
		</script>
</body>
</html>