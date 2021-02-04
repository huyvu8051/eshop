<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<c:set var="prefix" value="/admin/order" scope="request"/>
<c:set var="form" value="${order}" scope="request"/>

<h4 class="alert alert-success">ORDER MANAGER</h4>

<!-- tabs -->
<ul class="nav nav-tabs">
	<li class="active">
		<a data-toggle="tab" href="#edit"> 
			<span class="glyphicon glyphicon-edit"></span> Edit
		</a>
	</li>
	<li>
		<a data-toggle="tab" href="#list">
			<span class="glyphicon glyphicon-list"></span> List
		</a>
	</li>
</ul>
<!-- tab content -->
<div class="tab-content">
	<div id="edit" class="tab-pane fade in active">
		<jsp:include page="_form.jsp"/>
	</div>
	<div id="list" class="tab-pane fade">
		<jsp:include page="_list.jsp"/>
	</div>
</div>