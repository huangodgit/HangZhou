<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<title>图表</title>
	<script type="text/javascript" src='<s:url value="/js/echarts.min.js"/>'></script>
	<s:include value="/common/include.jsp"></s:include>
</head>
<body>

<div id="chart" style="height: 600px"></div>

<script type="text/javascript">
	jQuery(function($) {
		var myChart = echarts.init($('#chart')[0]);
		sendAjax('System/News/listPageView','', function(json){
			var newsesTypes = [];//图例
			var PageViews =[];//数据

			$.each(json.typeList,function (index, newsesType) {
				newsesTypes[index] = newsesType;
				PageViews[index] = {
					value: json.PageViewsList[index], name: newsesType
				}
			});

			var option = {
				title : {
					text: '某站点用户访问来源',
					x:'center'
				},
				tooltip : {
					trigger: 'item',
					formatter: "{a} <br/>{b} : {c} ({d}%)"
				},
				legend: {
					orient: 'vertical',
					left: 'left',
					data: newsesTypes
				},
				series : [
					{
						name: '新闻类型访问量',
						type: 'pie',
						radius: '55%',
						center: ['50%', '60%'],
						data: PageViews,
					}
				]
			};

			// var option = {
			// 	title: {
			// 		text: '某站点用户访问来源',
			// 		x: 'center'
			// 	},
            //     tooltip: {
            //         trigger: 'item',
            //         formatter: "{a} <br/>{b} : {c} "
            //     },
			// 	legend: {
			// 		orient: 'vertical',
			// 		left: 'left',
			// 		data: ['新闻类型访问量']
			// 	},
            //     xAxis: {
            //         data: newsesTypes
            //     },
			// 	yAxis: {},
			// 	series: [{
			// 		name: '新闻类型访问量',
			// 		type: 'bar',
			// 		radius: '55%',
			// 		center: ['50%', '60%'],
			// 		data: PageViews
			// 	}]
			// };

			if (option && typeof option === "object") {
				myChart.setOption(option, true);
			}
		});
	})
</script>
</body>
</html>
