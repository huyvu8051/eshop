<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>

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
				<td>
					$<f:formatNumber value="${p.unitPrice}" pattern="#,###.00"/>
				</td>
				<td>
					<f:formatNumber value="${p.discount * 100}" pattern="#,###.00"/> %
				</td>
				<td>${p.quantity}</td>
				<td>
					$<f:formatNumber value="${p.unitPrice*p.quantity*(1-p.discount)}" pattern="#,###.00"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="panel-footer">
		Total Amount: ${cart.amount}
	</div>
</div>

<!-- Purchase Form -->
<form:form modelAttribute="order" action="/order/checkout">
	<div class="panel panel-primary">
		<div class="panel-heading">
			<div class="text-danger pull-right">${message}</div>
			<h4 class="panel-title">CHECK OUT</h4>
		</div>
		<div class="panel-body">
			<div class="row">
				<div class="form-group col-sm-6">
					<label>Customer</label>
					<div class="form-control">${order.customer.fullname}</div>
					<form:hidden path="customer.id"/>
				</div>
				<div class="form-group col-sm-6">
					<label>Shipping Address</label>
					<form:errors path="*"/>
					<form:input path="address" class="form-control"/>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-sm-6">
					<label>Order Date</label>
					<div class="form-control">
						<f:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy"/>
					</div>
				</div>
				<div class="form-group col-sm-6">
					<label>Total Amount</label>
					<div class="form-control">
						<f:formatNumber value="${order.amount}" pattern="#,###.00"/> USD
					</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-sm-12">
					<label>Notes</label>
					<form:textarea path="description" rows="3" class="form-control"/>
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

