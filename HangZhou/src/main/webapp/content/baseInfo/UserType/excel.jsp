<%--
  Created by IntelliJ IDEA.
  User: ShenHuan
  Date: 2019/8/19
  Time: 10:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
    <title>导入</title>
    <s:include value="/common/include.jsp"></s:include>
</head>
<body>

<div class="page-content">
    <div class="row">
        <form action="BaseInfo/UserType/importExcel" class="dropzone col-xs-12 col-lg-push-8" id="excel-dropzone" style="padding: 12px 24px;">
            <div class="dz-message" data-dz-message>导入Excel文件</div>
        </form>
        <img src="${pageContext.request.contextPath}/images/Excel_model.png" alt="Excel model">
    </div>

</div>



<script type="text/javascript">
    Dropzone.options.excelDropzone = {
        paramName: 'excel',
        acceptedFiles: '.xls,.xlsx',
        success: function (file, response) {
            this.removeFile(file);
            var json = JSON.parse(response);
            if(json.status){
                parent.ui_info(json.info);
                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                parent.maincontent_datatable.fnReloadAjax();
                parent.layer.close(index); //再执行关闭
            }else{
                ui_error(json.info);
            }
        }
    }
</script>
</body>
</html>
