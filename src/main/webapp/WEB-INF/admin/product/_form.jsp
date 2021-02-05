<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<script src="http://js.nicedit.com/nicEdit-latest.js"></script>
<script>
bkLib.onDomLoaded(nicEditors.allTextAreas);
$(function(){
	$(window).resize(function(){
		var nicedit = $("textarea").parent().find(">div");
		nicedit.css({"width": "100%"});
		nicedit.find("[contenteditable]").width(nicedit.width() - 8);
		nicedit.find("[contenteditable]").css({"outline": "none"});
	});
	$(window).resize();

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
<form:form modelAttribute="product" action="${prefix}/index" enctype="multipart/form-data">
	<div class="panel panel-default">
		<div class="panel-body">
			<div class="row">
				<div class="col-sm-3 text-center">
					<img src="/static/images/products/${product.image}" style="max-height:200px;max-width:99%">
				</div>
				<div class="col-sm-9">
					<div class="row">
						<div class="form-group col-sm-4">
							<label>Id</label>
							<form:input path="id" class="form-control" readonly="true" placeholder="Auto Number"/>
						</div>
						<div class="form-group col-sm-4">
							<label>Name</label>
							<form:errors path="name"/>
							<form:input path="name" class="form-control"/>
						</div>
						<div class="form-group col-sm-4">
							<label>Unit Price</label>
							<form:errors path="unitPrice"/>
							<form:input path="unitPrice" class="form-control"/>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-sm-4">
							<label>Quantity</label>
							<form:errors path="quantity"/>
							<form:input path="quantity" class="form-control"/>
						</div>
						<div class="form-group col-sm-4">
							<label>Sales Off</label>
							<form:errors path="discount"/>
							<form:input path="discount" class="form-control"/>
						</div>
						<div class="form-group col-sm-4">
							<label>Product Date</label>
							<form:errors path="productDate"/>
							<form:input path="productDate" class="form-control datepicker"/>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-sm-4">
							<label>Image</label>
							<form:hidden path="image"/>
							<input name="image_file" type="file" class="form-control"/>
						</div>
						<div class="form-group col-sm-4">
							<label>Available?</label>
							<div class="form-control">
								<form:radiobutton  path="available"  value="true" label="Yes"/>
								<form:radiobutton path="available" value="false" label="No"/>
							</div>
						</div>
						<div class="form-group col-sm-4">
							<label>Category</label>
							<form:select path="category.id" class="form-control"
								items="${categories}" itemValue="id" itemLabel="nameVN"/>
						</div>
					</div>				
				</div>
			</div>
			<div class="row">
				<div class="form-group col-sm-12">
					<label>Description</label>
					<form:textarea path="description" rows="5" class="form-control"></form:textarea>
				</div>			
			</div>
		</div>
		<div class="panel-footer text-right">
			<div class="pull-left text-danger">${message}${param.message}</div>
			<jsp:include page="../layout/_btn-crud.jsp"/>
		</div>
	</div>
</form:form>