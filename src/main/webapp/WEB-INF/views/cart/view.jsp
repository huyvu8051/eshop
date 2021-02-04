<%@ page pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<h1>SHOPPING CART</h1>
<table class="table table-hover sp-cart">
	<thead>
		<tr>
			<th>ID</th>
			<th>Name</th>
			<th>Unit Price</th>
			<th>Discount</th>
			<th>Quantity</th>
			<th>Amount</th>
			<th></th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach items="${cart.items }" var="p">
			<tr data-id="${p.id}" data-price="${p.unitPrice}" data-disc="${p.discount}">
				<td>${p.id}</td>
				<td>${p.name}</td>
				<td>$<f:formatNumber value="${p.unitPrice}" pattern="#,###.00" /></td>
				<td>${p.discount*100}%</td>
				<td><input value="${p.quantity}" type="number" min="1" style="width: 50px" class="txt-cart-update"></td>
				<td>$<f:formatNumber value="${p.unitPrice*p.quantity*(1-p.discount)}" pattern="#,###.00" /></td>
				<td><button class="btn btn-sm btn-danger btn-cart-remove">
						<span class="glyphicon glyphicon-trash "></span>
					</button></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div>
	<button class="btn btn-sm btn-info">
		<span class="glyphicon glyphicon-plus"></span> Add more
	</button>
	<button class="btn btn-sm  btn-danger btn-cart-clear">
		<span class="glyphicon glyphicon-remove"></span> Clear
	</button>
	<button class="btn btn-sm  btn-warning">
		<span class="glyphicon glyphicon-heart"></span> Check out
	</button>
</div>