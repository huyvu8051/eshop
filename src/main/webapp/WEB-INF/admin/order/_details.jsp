<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>

<table class="table table-hover">
	<thead>
		<tr>
			<th>Id</th>
			<th>Name</th>
			<th>Unit Price</th>
			<th>Quantity</th>
			<th>Discount</th>
			<th>Amount</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="item" items="${order.orderDetails}">
		<tr>
			<td>${item.product.id}</td>
			<td>${item.product.name}</td>
			<td>$<f:formatNumber value="${item.unitPrice}" pattern="#,###.00"/></td>
			<td>${item.quantity}</td>
			<td>${item.discount*100}%</td>
			<td>$<f:formatNumber value="${item.unitPrice*item.quantity*(1-item.discount)}" pattern="#,###.00"/></td>
		</tr>
	</c:forEach>
	</tbody>
</table>