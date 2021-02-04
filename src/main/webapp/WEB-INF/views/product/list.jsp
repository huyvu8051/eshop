<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<c:forEach items="${list}" var="p">
	<div class="col-sm-4 nn-prod text-center" data-id="${p.id}">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h4 class="panel-title">${p.name}</h4>
			</div>
			<div class="panel-body">
				<a href="/product/detail/${p.id}"> <img src="/static/images/products/${p.image}">
				</a>
			</div>
			<div class="panel-footer">
				<div class="row">
					<div class="col-xs-4 text-left">$${p.unitPrice}</div>
					<div class="col-xs-8 text-right">
						<jsp:include page="_buttons.jsp" />
					</div>
				</div>
			</div>
			<c:choose>
				<c:when test="${p.discount > 0}">
					<img src="/static/images/promo-icon.gif">
				</c:when>
				<c:when test="${p.available}">
					<img src="/static/images/new-icon.gif">
				</c:when>
			</c:choose>
		</div>
	</div>
</c:forEach>
<jsp:include page="_send.jsp"></jsp:include>

