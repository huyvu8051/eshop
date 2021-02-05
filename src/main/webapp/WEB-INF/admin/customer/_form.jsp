<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<form:form modelAttribute="customer" action="${prefix}/index" enctype="multipart/form-data">
	<div class="panel panel-default">
		<div class="panel-body">
			<div class="row">
				<div class="col-sm-3 text-center">
					<img src="/static/images/customers/${customer.photo}" style="max-height:200px;max-width:99%">
				</div>
				<div class="col-sm-9">
					<div class="row">
						<div class="form-group col-sm-6">
							<label>Username</label>
							<form:errors path="id"/>
							<form:input path="id" class="form-control"/>
						</div>
						<div class="form-group col-sm-6">
							<label>Password</label>
							<form:errors path="password"/>
							<form:password path="password" showPassword="true" class="form-control"/>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-sm-6">
							<label>Fullname</label>
							<form:errors path="fullname"/>
							<form:input path="fullname" class="form-control"/>
						</div>					
						<div class="form-group col-sm-6">
							<label>Email Address</label>
							<form:errors path="email"/>
							<form:input path="email" class="form-control"/>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-sm-6">
							<label>Photo</label>
							<form:hidden path="photo"/>
							<input name="photo_file" type="file" class="form-control"/>
						</div>
						<div class="form-group col-sm-6">
							<label>Permission</label>
							<div class="form-control">
								<form:checkbox  path="admin"  value="true" label="Administrator?"/>
								<form:checkbox path="activated" value="true" label="Activated?"/>
							</div>
						</div>					
					</div>
				</div>
			</div>
		</div>
		<div class="panel-footer text-right">
			<div class="pull-left text-danger">${message}${param.message}</div>
			<jsp:include page="../layout/_btn-crud.jsp"/>
		</div>
	</div>
</form:form>
<script>
$(function(){
	$(":file").change(function(){
		if(this.files != null && this.files.length > 0){
			var reader = new FileReader();
			reader.addEventListener("load", function () {
				$("img").attr("src", reader.result);
			}, false);
			if (this.files[0]) {
				reader.readAsDataURL(this.files[0]);
			}
		}
	});
	$("img").click(function(){
		$(":file").click();
	})
})
</script>