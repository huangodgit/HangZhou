<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title> 杭州“绿色经济”智慧平台</title>

<s:include value="/common/include.jsp"></s:include>

</head>

<body>
	<div class="navbar navbar-default" id="navbar">
		<script type="text/javascript">
			try {
				ace.settings.check('navbar', 'fixed');
			} catch (e) {
			}
		</script>

		<div class="navbar-container" id="navbar-container">
			<div class="navbar-header pull-left">
				<a href="#" class="navbar-brand"> </a>
				<!-- /.brand -->
			</div>
			<!-- /.navbar-header -->

			<div class="navbar-header pull-right" role="navigation" style="padding-top: 21px;">
				<ul class="nav ace-nav">
					<span id="loginUser" data-value='<s:property value="loginUser.name" />'></span>
					<li class=""><a data-toggle="dropdown" href="#" class="dropdown-toggle"> <img class="nav-user-photo" src="vendor/assets/avatars/profile-pic.jpg" alt="Jason's Photo" /> <span
							class="user-info"> <small>当前用户</small> <s:property value="loginUser.name" />
						</span> <i class="icon-caret-down"></i>
					</a>

						<ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
							<li><a href="#"> <i class="icon-cog"></i> 设置
							</a></li>
							<li><a href="#"> <i class="icon-user"></i> 个人信息
							</a></li>
							<li class="divider"></li>
							<li>
							<!-- <a href="http://115.29.11.152:8000/cas/logout"> --> 
							<a href="logout"> 
							<i class="icon-off"></i> 退出
							</a></li>
						</ul></li>

				</ul>
				<!-- /.ace-nav -->
			</div>
			<!-- /.navbar-header -->
		</div>
		<!-- /.container -->
	</div>

	<div class="main-container" id="main-container">
		<script type="text/javascript">
			try {
				ace.settings.check('main-container', 'fixed')
			} catch (e) {
			}
		</script>

		<div class="main-container-inner">
			<a class="menu-toggler" id="menu-toggler" href="#"> <span class="menu-text"></span>
			</a>

			<div class="sidebar" id="sidebar">
				<script type="text/javascript">
					try {
						ace.settings.check('sidebar', 'fixed');
					} catch (e) {
					}
				</script>
				<!-- #sidebar-shortcuts  -->
				<s:property value="topMenuHtmlStr" escape="false" />
				
				<div class="sidebar-shortcuts" id="sidebar-shortcuts">
					<div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
						<span class="btn btn-success"></span> <span class="btn btn-info"></span> <span class="btn btn-warning"></span> <span class="btn btn-danger"></span>
					</div>
				</div>
				<!-- #sidebar-shortcuts -->

				

				<!-- /.nav-list -->

				<div class="sidebar-collapse" id="sidebar-collapse">
					<i class="icon-double-angle-right" data-icon1="icon-double-angle-right" data-icon2="icon-double-angle-left"></i>
				</div>

			</div>

			<div class="main-content" id="maincontent">
				<iframe id="main" runat="server" src="main.jsp" width="100%" height="1080px" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe>
			</div>
			<!-- /.main-content -->


			<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse"> <i class="icon-double-angle-up icon-only bigger-110"></i>
			</a>
		</div>
		<!-- /.main-container -->
	</div>


	<script type="text/javascript">
		function callAction(url) {
			$('#maincontent').load(url);
		};

		function changeMain(url) {
			$("#main").attr("src", url);
		}

		function openBox(url) {
			layer.open({
				type : 2,
				title : false,
				skin : 'layui-layer-rim', //加上边框
				shadeClose : true,
				shade : 0.6,
				closeBtn : false,
				area : [ '550px', '450px' ],
				content : url
			//iframe的url
			});
		}

		(function($) {
			$.fn.dataTableExt.oApi.fnReloadAjax = function(oSettings,
					sNewSource, fnCallback, bStandingRedraw) {
				if (sNewSource !== undefined && sNewSource !== null) {
					oSettings.sAjaxSource = sNewSource;
				}
				// Server-side processing should just call fnDraw
				if (oSettings.oFeatures.bServerSide) {
					this.fnDraw();
					return;
				}
				this.oApi._fnProcessingDisplay(oSettings, true);
				var that = this;
				var iStart = oSettings._iDisplayStart;
				var aData = [];
				this.oApi._fnServerParams(oSettings, aData);
				oSettings.fnServerData
						.call(
								oSettings.oInstance,
								oSettings.sAjaxSource,
								aData,
								function(json) {
									/* Clear the old information from the table */
									that.oApi._fnClearTable(oSettings);
									/* Got the data - add it to the table */
									var aData = (oSettings.sAjaxDataProp !== "") ? that.oApi
											._fnGetObjectDataFn(
													oSettings.sAjaxDataProp)(
													json)
											: json;
									for ( var i = 0; i < aData.length; i++) {
										that.oApi._fnAddData(oSettings,
												aData[i]);
									}
									oSettings.aiDisplay = oSettings.aiDisplayMaster
											.slice();
									that.fnDraw();
									if (bStandingRedraw === true) {
										oSettings._iDisplayStart = iStart;
										that.oApi._fnCalculateEnd(oSettings);
										that.fnDraw(false);
									}
									that.oApi._fnProcessingDisplay(oSettings,
											false);
									/* Callback user function - for event handlers etc */
									if (typeof fnCallback == 'function'
											&& fnCallback !== null) {
										fnCallback(oSettings);
									}
								}, oSettings);
			}
		})(jQuery);
	</script>
</body>
</html>