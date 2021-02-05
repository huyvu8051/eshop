<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>

<div class="panel panel-default">
	<div class="panel-heading">
		<h4 class="panel-title">MY ORDERS</h4>
	</div>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>Id</th>
				<th>Order Date</th>
				<th>Address</th>
				<th>Amount</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="o" items="${orders}">
			<tr>
				<td>#${o.id}</td>
				<td>
					<f:formatDate value="${o.orderDate}" pattern="hh:mm a, dd-MM-yyyy"/>
				</td>
				<td>${o.address}</td>
				<td>
					$<f:formatNumber value="${o.amount}" pattern="#,###.00"/>
				</td>
				<td>
					<a href="/order/detail/${o.id}" class="btn btn-sm btn-warning">
						<span class="glyphicon glyphicon-search"></span>
					</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="panel-footer">
	</div>
</div>