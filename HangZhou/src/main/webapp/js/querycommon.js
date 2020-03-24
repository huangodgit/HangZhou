String.prototype.Trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "");
};
String.prototype.LTrim = function() {
	return this.replace(/(^\s*)/g, "");
};
String.prototype.Rtrim = function() {
	return this.replace(/(\s*$)/g, "");
};
String.prototype.TrueName = function() {
	var i = this.indexOf("[");
	return this.substring(0, i);
};
String.prototype.TrueType = function() {
	var i = this.indexOf("[");
	var j = this.indexOf("]");
	return this.substring(i + 1, j);
};

//&type=dark&pcount=参数数&p1name=参数名&p1type=参数类型&p1value=参数值&p2name=参数名&p2type=参数类型&p2value=参数值
function getParamStr(names) {
	var tj = document.getElementsByName(names);
	var items = tj[0].getElementsByTagName("input");
	var items1 = tj[0].getElementsByTagName("select");
	var sorttj = document.getElementById("sorttj").value;
	var sorttype = document.getElementById("reorder").value;
	var names = [];
	var values = [];
	var idx = 0;
	var names1 = [];
	var values1 = [];
	var idx1 = 0;
	for ( var i = 0; i < items.length; i++) {
		if (items[i].type == "text") {
			var val = items[i].value.Trim();
			if (val.length > 0) {
				names[idx] = items[i].name.Trim();
				values[idx] = val;
				idx = idx + 1;
			}
		}
	}
	for ( var j = 0; j < items1.length; j++) {
		var val = items1[j].value.Trim();
		if ((items1[j].name == "sorttj") || (items1[j].name == "reorder"))
			continue;
		if ((items1[j].value == "all"))
			continue;
		if (val.length > 0) {
			names1[idx1] = items1[j].name.Trim();
			values1[idx1] = val;
			idx1 = idx1 + 1;
		}
	}

	var nlen = names.length;
	var nlen1 = names1.length;
	//if (nlen==0&&nlen1==0) return "";
	var param = "&pcount=" + (nlen + nlen1 + 1);
	if (nlen != 0) {
		for ( var i = 1; i < nlen + 1; i++) {
			param = param + "&p" + i + "name=" + names[i - 1].TrueName() + "&p"
					+ i + "type=" + names[i - 1].TrueType() + "&p" + i
					+ "value=" + encodeURI(values[i - 1]);
		}
	}
	if (nlen1 != 0) {
		for ( var i = 1; i < nlen1 + 1; i++) {
			param = param + "&p" + (i + nlen) + "name="
					+ names1[i - 1].TrueName() + "&p" + (i + nlen) + "type="
					+ names1[i - 1].TrueType() + "&p" + (i + nlen) + "value="
					+ encodeURI(values1[i - 1]);
		}
	}
	param = param + "&p" + (nlen + nlen1 + 1) + "name=sortfield" + "&p"
			+ (nlen + nlen1 + 1) + "type=" + sorttype + "&p"
			+ (nlen + nlen1 + 1) + "value=" + sorttj;
	return param;
}
//模糊查询
function darkquery(names) {
	var tj = document.getElementsByName(names);
	//tj[0].encoding = "application/x-www-form-urlencoded";
	tj[0].action = tj[0].action + "&type=dark" + getParamStr(names);
	//alert(tj[0].action);
	//tj[0].submit();
	navTab.reload(tj[0].action);
};
//精确查询
function rigorquery() {
	var tj = document.getElementsByName("gq_querycondition");
	tj[0].encoding = "application/x-www-form-urlencoded";
	tj[0].action = window.gqueryurl + "&type=rigor" + getParamStr();
	//tj[0].submit();
	navTab.reload(tj[0].action);
};

function show(id) {
	eDiv = document.getElementById(id);
	if (eDiv.style.display == 'block')
		eDiv.style.display = 'none';
	else
		eDiv.style.display = 'block';
};

function OMO(event) {

	if (window.event) {
		event = window.event;
		if (event.srcElement.tagName == "IMG")
			event.srcElement.parentElement.className = "T";
		else
			event.srcElement.className = "T";
	} else {
		var trg = event.target;
		if (trg.tagName == "IMG")
			trg.parentNode.className = "T";
		else
			trg.className = "T";
	}

}

function OMOU(event) {
	if (window.event) {
		event = window.event;
		if (event.srcElement.tagName == "IMG")
			event.srcElement.parentElement.className = "T";
		else
			event.srcElement.className = "P";
	} else {
		var trg = event.target;
		if (trg.tagName == "IMG")
			trg.parentNode.className = "T";
		else
			trg.className = "P";
	}
}

function loadSjbd(tabid,name,flag,type) {
	var url = "CompareData/{1}/{2}.qy?querytable={4}&pgf=1&"+
		"type={3}&pcount=1&p1name=sjbdjg&p1type=str&p1value=";
	var par = name.split('_');
	url=url.replace(/\{1\}/g,par[1]);
	url=url.replace(/\{2\}/g, name);
	url=url.replace(/\{3\}/g, type);
	url=url.replace(/\{4\}/g, name+"_compare");
	if(flag==1) {
		url=url+encodeURI('比对成功');
		navTab.openTab(tabid, url, { title:"比对成功情况", fresh:true, data:{} });
	}else{
		url=url+encodeURI('失败');
		navTab.openTab(tabid, url, { title:"比对失败情况", fresh:true, data:{} });
	}
}

function loadSjbdByRksj(tabid,name,flag,type,rksj) {
	var url = "CompareData/{1}/{2}.qy?querytable={4}&pgf=1&"+
		"type={3}&pcount=3&p1name=sjbdjg&p1type=str&p1value=";
	var par = name.split('_');
	url=url.replace(/\{1\}/g,par[1]);
	url=url.replace(/\{2\}/g, name);
	url=url.replace(/\{3\}/g, type);
	url=url.replace(/\{4\}/g, name+"_compare");
	if(flag==1) {
		url=url+encodeURI('比对成功')+"&p2name=rksj_min&p2type=bdate&p2value="+rksj+"&p3name=rksj_max&p3type=bdate&p3value="+rksj;
		navTab.openTab(tabid, url, { title:"比对成功情况", fresh:true, data:{} });
	}else{
		url=url+encodeURI('失败')+"&p2name=rksj_min&p2type=bdate&p2value="+rksj+"&p3name=rksj_max&p3type=bdate&p3value="+rksj;
		navTab.openTab(tabid, url, { title:"比对失败情况", fresh:true, data:{} });
	}
}

//联动查找
function changSign(selectObject) {
	$this = $(selectObject);
	$td1 = $($this.parents("td:first")[0]);
	$td2 = $($td1.next("td"));
	$select = $($td2.find("select"));
	var refUrl = $this.attr("refUrl");
	$.ajax({
		type:'GET', dataType:"json", url:refUrl.replace("{value}", $this.attr("value")), cache: false,
		data:{},
		success: function(json){
			if (!json) return;
			var html = '';
			$.each(json, function(i){
				if (json[i] && json[i].length > 1){
					html += '<option value="'+json[i][0]+'">' + json[i][1] + '</option>';
				}
			});
			var $refCombox = $select.parents("div.combox:first");
			$select.html(html).insertAfter($refCombox);
			$refCombox.remove();
			$select.trigger("refChange").trigger("change").combox();
		}
	});

	//改成日期框
	if($this.val().indexOf("date")>-1){
		$text=$($td1.parent().find("input[type=text]")[0]);
		$text.attr("style","color:rgb(187, 187, 187)");
		$text.val("输入yyyy-MM-dd");
		$text.focus(function(){
			$(this).val("");
			$(this).attr("style","");
		});
		$text.blur(function(){
			if(!$text.val()){
				$text.attr("style","color:rgb(187, 187, 187)");
				$text.val("输入yyyy-MM-dd");
			}else{
				if($text.val()!=""&&!$text.val().match(/^\d+-\d+-\d+$/)){
					alert("输入yyyy-MM-dd");
					$text.focus();
				}
			}
		});
	}
		
	if($this.val().indexOf("varchar")>-1){
		$text=$($td1.parent().find("input[type=text]")[0]);
		$text.attr("style","color:rgb(187, 187, 187)");
		$text.val("请输入");
		$text.focus(function(){
			$(this).val("");
			$(this).attr("style","");
		});
		$text.blur(function(){
			if(!$text.val()){
				$text.attr("style","color:rgb(187, 187, 187)");
				$(this).val("请输入");
			}
		});
	}	
}

//检查选择条件
function checkFileds() {
	var $tr = $("#jbsxBox2 tr");
	var map = new Map();
	$.each($tr,function(){
		var $this=$(this);
		var $selectFir=$($this.find("select:first"));
		var val = $selectFir.val();
		if(val){
			if(val.indexOf("请选择")>-1){
				alertMsg.error('请选择查询字段');
				return false;
			}
			//else if(map.get(val)){
				//alertMsg.error('查询条件出现重复，请修改后提交');
			//}else{
				//map.put(val,val);
			//}
		}
	});
	return true;
}

