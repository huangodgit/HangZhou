<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<s:include value="/common/include.jsp"></s:include>
	</head>

	<body style="background-color:#FFFFFF">
		<div class="page-content">
			<div class="row">
				<div class="col-xs-12">
					<!-- PAGE CONTENT BEGINS -->	
					<div>
						<div id="user-profile-1" class="user-profile row">
							<div class="col-xs-12 col-sm-9">
								<div class="profile-user-info profile-user-info-striped">
									<div class="profile-info-row "> <div class="profile-info-name">编号</div> <div class="profile-info-value"> <span class="editable" id="username"><s:property value="code"/></span> </div> </div> 
									<div class="profile-info-row "> <div class="profile-info-name">企业名称</div> <div class="profile-info-value"> <span class="editable" id="username"><s:property value="name"/></span> </div> </div> 
									<div class="profile-info-row "> <div class="profile-info-name">企业法人</div> <div class="profile-info-value"> <span class="editable" id="username"><s:property value="legalMember"/></span> </div> </div> 
									<!-- <div class="profile-info-row "> <div class="profile-info-name">电话</div> <div class="profile-info-value"> <span class="editable" id="username"><s:property value="phone"/></span> </div> </div>  -->
									<div class="profile-info-row "> <div class="profile-info-name">营业执照号 </div> <div class="profile-info-value"> <span class="editable" id="username"><s:property value="businessLicenseNum"/></span> </div> </div> 
									<div class="profile-info-row "> <div class="profile-info-name">纳税人识别号</div> <div class="profile-info-value"> <span class="editable" id="username"><s:property value="taxpayerNumber"/></span> </div> </div> 
									<div class="profile-info-row "> <div class="profile-info-name">注册资金</div> <div class="profile-info-value"> <span class="editable" id="username"><s:property value="fund"/></span> </div> </div> 
									<div class="profile-info-row "> <div class="profile-info-name">注册地址</div> <div class="profile-info-value"> <span class="editable" id="username"><s:property value="address"/></span> </div> </div> 
									<div class="profile-info-row "> <div class="profile-info-name">成立时间</div> <div class="profile-info-value"> <span class="editable" id="username"><s:property value="foundTime"/></span> </div> </div> 
									<%-- <div class="profile-info-row "> <div class="profile-info-name">简介</div> <div class="profile-info-value no-padding-left"> <textarea class="form-control limited no-padding-left" id="editor10" maxlength="500" rows="4" name="intro" readonly><s:property value='intro'/></textarea></div> </div> --%>
								</div>
							</div>
						</div>
					</div>

					<!-- PAGE CONTENT ENDS -->
				</div><!-- /.col -->
			</div><!-- /.row -->
		</div><!-- /.page-content -->
		
</body>
</html>
