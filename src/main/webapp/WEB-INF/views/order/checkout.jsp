<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>

<!-- Shopping Cart -->
<div class="panel panel-success">
	<div class="panel-heading">
		<h4 class="panel-title">SHOPPING CART</h4>
	</div>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>Id</th>
				<th>Name</th>
				<th>Unit Price</th>
				<th>Discount</th>
				<th>Quantity</th>
				<th>Amount</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="p" items="${cart.items}">
				<tr>
					<td>${p.id}</td>
					<td>${p.name}</td>
					<td>$<f:formatNumber value="${p.unitPrice}" pattern="#,###.00" />
					</td>
					<td><f:formatNumber value="${p.discount * 100}" pattern="#,###.00" /> %</td>
					<td>${p.quantity}</td>
					<td>$<f:formatNumber value="${p.unitPrice*p.quantity*(1-p.discount)}" pattern="#,###.00" />
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="panel-footer">Total Amount: ${cart.amount}</div>
</div>

<!-- Purchase Form -->
<form:form action="/order/checkout" modelAttribute="order">
	<div class="panel panel-primary">
		<div class="panel-heading">
			<div class="text-danger pull-right">${message}</div>
			<h4 class="panel-title">CHECK OUT</h4>
		</div>
		<div class="panel-body">
			<div class="row">
				<div class="form-group \">
					<label>Customer</label>
					<form:input path="customer.id" class="form-control" />
				</div>
				<div class="form-group \">
					<label>Order Date</label>
					<form:input path="orderDate" class="form-control" />
				</div>
				<div class="form-group \">
					<label>Total Amount</label>
					<form:input path="amount" class="form-control" />
				</div>
				<div class="form-group \">
					<label>Shipping address</label>
					<form:input path="address" class="form-control" />
				</div>
				<div class="form-group \">
					<label>Notes</label>
					<form:textarea path="description" class="form-control" rows="4"/>
				</div>
			</div>
		</div>
		<div class="panel-footer">
			<button class="btn btn-primary">
				<span class="glyphicon glyphicon-save"></span> Purchase
			</button>
		</div>
	</div>
</form:form>

