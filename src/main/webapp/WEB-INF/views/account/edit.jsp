<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<form:form action="/account/edit" enctype="multipart/form-data" modelAttribute="user">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">EDIT PROFILE</h3>
		</div>
		<div class="panel-body">
			<div>
				<div class="col-sm-3 nn-photo text-center">
					<label for="photo_file"><img src="/static/images/customers/${user.photo }"></label>

				</div>
				<div class="col-sm-9">
					<div class="form-group">
						<label>Username</label>
						<form:input path="id" readonly="true" class="form-control" />
						<form:errors path="id" />
					</div>
					<form:hidden path="password" />
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
						<label>Photo</label> <input type="file" id="photo_file" name="photo_file">
						<form:hidden path="photo" />
					</div>
				</div>
			</div>


			<form:hidden path="admin" />
			<form:hidden path="activated" />
		</div>
		<div class="panel-footer text-right">
			<div class="pull-left text-danger">${message}</div>
			<button class="btn btn-sm btn-success">
				<span class="glyphicon glyphicon-envelope"></span> Update Profile
			</button>
		</div>
	</div>
</form:form>
<style>
.nn-photo img {
	max-height: 280px;
	max-width: 95%;
}
</style>
<script>
	$(function() {
		$("#photo_file").change(function() {
			if (this.files && this.files.length > 0) {
				var reader = new FileReader();
				reader.onload = function() {
					$(".nn-photo img").attr("src", reader.result)
				};
				reader.readAsDataURL(this.files[0]);
			}
		});
	})
</script>








