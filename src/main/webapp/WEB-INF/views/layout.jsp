<%@ page pageEncoding="utf-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Online Shopping Mall</title>
	<tiles:insertAttribute name="head"/>
</head>
<body>
	<div class="container">
		<!-- HEADER -->
		<tiles:insertAttribute name="header"/>
		<!-- MENU -->
		<tiles:insertAttribute name="menu"/>
		<!-- MIDDLE -->
		<div class="row">
			<!-- BODY -->
			<article class="col-sm-9">
				<div class="row" style="margin-right:5px;">
					<tiles:insertAttribute name="body"/>
				</div>
			</article>
			<!-- ASIDE -->
			<tiles:insertAttribute name="aside"/>
		</div>
		<!-- FOOTER -->
		<tiles:insertAttribute name="footer"/>
	</div>
</body>
</html>