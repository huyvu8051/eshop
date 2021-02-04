<%@ page pageEncoding="utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<aside class="col-sm-3">
	<div class="row">
		<!-- Cart Info -->
		<c:import url="/cart/info"/>
		<!-- Search -->
		<jsp:include page="_aside-search.jsp"/>
		<!-- Categories -->
		<c:import url="/home/aside/category"/>
		<!-- Hot Items -->
		<jsp:include page="_aside-hot.jsp"/>
	</div>
</aside>