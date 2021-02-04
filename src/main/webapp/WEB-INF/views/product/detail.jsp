<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<h1>PRODUCT DETAIL</h1>
<div data-id="${prod.id}">
	<img src="/static/images/products/${prod.image}">

	<ul>
		<li>Name: ${prod.name}</li>
		<li>Unit Price: ${prod.unitPrice}</li>
		<li>Product Date: ${prod.productDate}</li>
		<li>Category: ${prod.category.nameVN}</li>
	</ul>

	<div>${prod.description}</div>
	<jsp:include page="_buttons.jsp" />
	<ul class="nav nav-tabs">
		<li class="active"><a data-toggle="tab" href="#same">Cùng loại</a></li>
		<li><a data-toggle="tab" href="#visited">Đã xem</a></li>
		<li><a data-toggle="tab" href="#favorite">Yêu thích</a></li>
	</ul>

	<div class="tab-content nn-thumb">
		<div id="same" class="tab-pane fade in active">
			<c:forEach items="${prod.category.products}" var="p">
				<a href="/product/detail/${p.id}"><img src="/static/images/products/${p.image}"></a>
			</c:forEach>
		</div>
		<div id="visited" class="tab-pane fade">
			<c:forEach items="${clicks}" var="p">
				<a href="/product/detail/${p.id}"><img src="/static/images/products/${p.image}"></a>
			</c:forEach>
		</div>
		<div id="favorite" class="tab-pane fade">
			<c:forEach items="${favos}" var="p">
				<a href="/product/detail/${p.id}"><img src="/static/images/products/${p.image}"></a>
			</c:forEach>
		</div>
	</div>
</div>
<jsp:include page="_send.jsp"></jsp:include>