<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>

<form:form modelAttribute="order" action="/order/checkout">
	<div class="panel panel-warning">
		<div class="panel-heading">
			<h4 class="panel-title">ORDER INFORMATION</h4>
		</div>
		<div class="panel-body">
			<div class="row">
				<div class="form-group col-sm-6">
					<label>Customer</label>
					<div class="form-control">${order.customer.fullname}</div>
				</div>
				<div class="form-group col-sm-6">
					<label>Shipping Address</label>
					<div class="form-control">${order.address}</div>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-sm-6">
					<label>Order Date</label>
					<div class="form-control">
						<f:formatDate value="${order.orderDate}" pattern="hh:mm a dd-MM-yyyy"/>
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
					<form:textarea path="description" readonly="true" rows="5" class="form-control"/>
				</div>
			</div>
		</div>
		<div class="panel-footer">
			<h4 class="panel-title">ORDER LINES</h4>
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
			<c:forEach var="d" items="${order.orderDetails}">
				<tr>
					<td>${d.id}</td>
					<td>${d.product.name}</td>
					<td>
						$<f:formatNumber value="${d.unitPrice}" pattern="#,###.00"/>
					</td>
					<td>
						<f:formatNumber value="${d.discount * 100}" pattern="#,###.00"/> %
					</td>
					<td>${d.quantity}</td>
					<td>
						$<f:formatNumber value="${d.unitPrice*d.quantity*(1-d.discount)}" pattern="#,###.00"/>
					</td>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<div class="panel-body text-center">
			<img src="/static/images/stamp.png" style="width:100px">
			<br>
			<img src="/static/images/signature.png" style="width:200px">
		</div>
	</div>
</form:form>

