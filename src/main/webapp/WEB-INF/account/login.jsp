<%@ page pageEncoding="UTF-8"%>
<form action="/account/login" method="post">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">LOGIN</h3>
		</div>
		<div class="panel-body">
			<div class="form-group">
				<label>Username</label><input name="username" value="${username}" class="form-control">
			</div>
			<div class="form-group">
				<label>Password</label><input name="password" value="${password}" class="form-control">
			</div>
			<div class="form-group">
				<label class="form-control"><input type="checkbox" name="remember" value="true">Remember me?</label>
			</div>
		</div>
		<div class="panel-footer text-right">
			<div class="pull-left text-danger">${message }${param.message }</div>
			<button class="btn btn-sm btn-success">
				<span class="glyphicon glyphicon-envelope"></span> Login
			</button>
		</div>
	</div>
</form>
