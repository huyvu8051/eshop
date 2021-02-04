<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Website Administration</title>
	<tiles:insertAttribute name="head"/>
</head>
<body>
	<div class="container">
		<header class="row">
			<h2 class="alert alert-success">Website Administration</h2>
		</header>
		<nav class="row">
			<tiles:insertAttribute name="menu"/>
		</nav>
		<article class="row">
			<tiles:insertAttribute name="body"/>
		</article>
		<footer class="row">
			<tiles:insertAttribute name="footer"/>
		</footer>
	</div>
</body>
</html>