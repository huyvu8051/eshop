<%@ page pageEncoding="utf-8" %>
<div class="panel panel-info">
	<div class="panel-heading">
		<h3 class="panel-title">
			<span class="glyphicon glyphicon-search"></span> Search
		</h3>
	</div>
	<div class="panel-body">
		<form action="/product/list-by-keywords">
			<div class="input-group">
				<input name="keywords" value="${param.keywords}" placeholder="Keywords?" class="form-control">
				<div class="input-group-addon"><span class="glyphicon glyphicon-search"></span></div>
			</div>
		</form>
	</div>
</div>