<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>

<div class="panel panel-danger">
	<div class="panel-heading">
		<h3 class="panel-title"><strong>REVENUE BY YEAR</strong></h3>
	</div>
	<table class="table table-hover">
		<thead class="bg-success">
			<tr>
				<th class="text-center">Year</th>
				<th class="text-center">Quantity</th>
				<th class="text-center">Revenue</th>
				<th class="text-center">Min Price</th>
				<th class="text-center">Max Price</th>
				<th class="text-center">Average Price</th>
			</tr>
		</thead>
		<tbody class="text-center">
		<c:set var="total" value="0"/>
		<c:forEach var="a" items="${items}">
			<c:set var="total" value="${total + a[2]}"/>
			<tr>
				<td>${a[0]}</td>
				<td><f:formatNumber value="${a[1]}" pattern="#,###"/></td>
				<td>$<f:formatNumber value="${a[2]}" pattern="#,###.00"/></td>
				<td>$<f:formatNumber value="${a[3]}" pattern="#,###.00"/></td>
				<td>$<f:formatNumber value="${a[4]}" pattern="#,###.00"/></td>
				<td>$<f:formatNumber value="${a[5]}" pattern="#,###.00"/></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="panel-footer">
		<strong>TOTAL REVENUE: $<f:formatNumber value="${total}" pattern="#,###.00"/></strong>
	</div>
</div>
