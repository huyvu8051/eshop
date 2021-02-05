<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<div class="panel panel-default">
	<table class="table table-hover">
		<thead>
			<tr>
				<th>Id</th>
				<th>Password</th>
				<th>Fullname</th>
				<th>Email</th>
				<th>Photo</th>
				<th>Activated?</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="item" items="${users}">
			<tr>
				<td>${item.id}</td>
				<td>${item.password}</td>
				<td>${item.fullname}</td>
				<td>${item.email}</td>
				<td>${item.photo}</td>
				<td>${item.activated?'Yes':'No'}</td>
				<td class="text-center">
					<a href="${prefix}/edit/${item.id}" class="btn btn-sm btn-info">
						<span class="glyphicon glyphicon-edit"></span>
					</a>
					<a href="${prefix}/delete/${item.id}" class="btn btn-sm btn-danger">
						<span class="glyphicon glyphicon-trash"></span>
					</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="panel-footer">
		<ul class="pager">
			<li><a href="${prefix}/index?pageNo=${0}#users">First</a></li>
			<li><a href="${prefix}/index?pageNo=${pageNo-1}#users">Previous</a></li>
			<li><a href="${prefix}/index?pageNo=${pageNo+1}#users">Next</a></li>
			<li><a href="${prefix}/index?pageNo=${pageCount-1}#users">Last</a></li>
		</ul>
	</div>
</div>
<script>
$(function(){
	if(location.hash){
		$(".nav-tabs a[href='#users']").tab('show');
	}
})
</script>