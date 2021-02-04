<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<script src="http://js.nicedit.com/nicEdit-latest.js"></script>
<script>
bkLib.onDomLoaded(nicEditors.allTextAreas);
$(function(){
	$(window).resize(function(){
		var nicedit = $("textarea").parent().find(">div");
		nicedit.css({"width": "100%"});
		nicedit.find("[contenteditable]").width(nicedit.width() - 8);
		nicedit.find("[contenteditable]").css({"outline": "none"});
	});
	$(window).resize();
});
</script>

<form:form modelAttribute="order" action="${prefix}/index">
	<div class="panel panel-default">
		<div class="panel-body">
			<div class="row">
				<div class="form-group col-sm-4">
					<label>Id</label>
					<form:input path="id" class="form-control" readonly="true" placeholder="Auto Number"/>
				</div>
				<div class="form-group col-sm-4">
					<label>Customer</label>
					<form:input path="customer.id" class="form-control"/>
				</div>
				<div class="form-group col-sm-4">
					<label>Shipping Address</label>
					<form:input path="address" class="form-control"/>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-sm-4">
					<label>Order Date</label>
					<form:input path="orderDate" class="form-control datepicker"/>
				</div>
				<div class="form-group col-sm-4">
					<label>Amount</label>
					<form:input path="amount" class="form-control"/>
				</div>
			</div>
			<div class="row">
				<div class="form-group col-sm-12">
					<label>Description</label>
					<form:textarea path="description" rows="3" class="form-control"/>
				</div>
				<div class="form-group col-sm-12">
					<label>Order Lines</label>
					<jsp:include page="_details.jsp"/>
				</div>
			</div>
		</div>
		
		<div class="panel-footer text-right">
			<div class="pull-left text-danger">${message}${param.message}</div>
			<jsp:include page="../layout/_btn-crud.jsp"/>
		</div>
	</div>
</form:form>


