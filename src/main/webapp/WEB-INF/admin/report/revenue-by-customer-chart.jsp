<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>

<script src="https://www.gstatic.com/charts/loader.js"></script>
<script>
	google.charts.load("current", {packages:["corechart"]});
	google.charts.setOnLoadCallback(drawChart);
	function drawChart() {
		var data = google.visualization.arrayToDataTable([
			['Customer', 'Money'],
			<c:forEach var="a" items="${items}">
			["${a[0]}",	${a[2]}],
			</c:forEach>
		]);
		var options = {
			title: 'Revenue by Customer',
			titleTextStyle: {
		        color: "orangered",
		        fontName: "Impact",
		        fontSize: 40,
		    },
	        legend: { position: 'bottom' }
		};
		var chart = new google.visualization.LineChart(document.getElementById('linechart'));
		chart.draw(data, options);
		
		$(window).resize(function(){
			options.titleTextStyle.fontSize = ($(document).width() > 650) ? 40 : 30;
			chart.draw(data, options);
		});
	}
</script>

<link href="/static/css/eshop-chart.css" rel="stylesheet"/>
<div class="chart-container">
	<div id="linechart" class="chart"></div>
</div>