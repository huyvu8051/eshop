<%@ page pageEncoding="UTF-8"%>
<form action="/account/change" method="post">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">CHANGE PASSWORD</h3>
		</div>
		<div class="panel-body">
			<div class="form-group">
				<label>Username</label><input name="username" value="${param.username}" class="form-control">
			</div>
			<div class="form-group">
				<label>Password</label><input name="password" value="${param.password}" class="form-control">
			</div>
			<div class="form-group">
				<label>New Password</label><input name="newpwd" value="${param.newpwd}" class="form-control">
			</div>
			<div class="form-group">
				<label>Confirm New Password</label><input name="confirm" value="${param.confirm}" class="form-control">
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
