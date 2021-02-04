<%@ page pageEncoding="UTF-8"%>
<form action="/account/forgot" method="post">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">FORGOT PASSWORD</h3>
		</div>
		<div class="panel-body">
			<div class="form-group">
				<label>Username</label><input name="username" value="${username}" class="form-control">
			</div>
			<div class="form-group">
				<label>EMAIL</label><input name="email" value="${email}" class="form-control">
			</div>
		</div>
		<div class="panel-footer text-right">
			<div class="pull-left text-danger">${message }</div>
			<button class="btn btn-sm btn-success">
				<span class="glyphicon glyphicon-envelope"></span> Retriev
			</button>
		</div>
	</div>
</form>
