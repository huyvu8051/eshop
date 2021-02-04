<%@ page pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<div class="panel panel-success">
	<div class="panel-heading">
		<h3 class="panel-title">
			<span class="glyphicon glyphicon-th-large"></span> Category List
		</h3>
	</div>
	 <div class="list-group">
	 <c:forEach items="${categories}" var="c">
		<a href="/product/list-by-category/${c.id}" class="list-group-item">${c.nameVN}</a>
	</c:forEach>
	</div>
</div>