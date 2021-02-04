<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<form:form action="/account/register" enctype="multipart/form-data" modelAttribute="user">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">REGISTRATION</h3>
		</div>
		<div class="panel-body">
			<div class="form-group">
				<label>Username</label>
				<form:input path="id" class="form-control" />
				<form:errors path="id" />
			</div>
			<div class="form-group">
				<label>Password</label>
				<form:input path="password" class="form-control" />
				<form:errors path="password" />
			</div>
			<div class="form-group">
				<label>Fullname</label>
				<form:input path="fullname" class="form-control" />
				<form:errors path="fullname" />
			</div>
			<div class="form-group">
				<label>Email</label>
				<form:input path="email" class="form-control" />
				<form:errors path="email" />
			</div>
			<div class="form-group">
				<label>Photo</label> <input type="file" name="photo_file">
				<form:hidden path="photo" />
			</div>

		</div>
		<div class="panel-footer text-right">
			<div class="pull-left text-danger">${message}</div>
			<button class="btn btn-sm btn-success">
				<span class="glyphicon glyphicon-envelope"></span> Sign up
			</button>
		</div>
	</div>
</form:form>
