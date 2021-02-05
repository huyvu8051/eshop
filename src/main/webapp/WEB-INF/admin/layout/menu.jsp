<%@ page pageEncoding="utf-8"%>

<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<button class="navbar-toggle" data-toggle="collapse" data-target="#menu">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="/home/index"><span class="glyphicon glyphicon-home"></span> E-Shop</a>
		</div>
		<div class="collapse navbar-collapse" id="menu">
			<ul class="nav navbar-nav navbar-right">
				 <li class="dropdown">
					<a class="dropdown-toggle" data-toggle="dropdown" href="#"> 
						<span class="glyphicon glyphicon-briefcase"></span> Management
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="/admin/product/index">Product</a></li>
						<li><a href="/admin/category/index">Category</a></li>
						<li><a href="/admin/customer/index">Customer</a></li>
						<li class="divider"></li>
						<li><a href="/admin/order/index">Order</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="dropdown" href="#"> 
						<span class="glyphicon glyphicon-stats"></span> Report
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="/admin/inventory/category">Inventory by Category</a></li>
						<li class="divider"></li>
						<li><a href="/admin/revenue/product">Revenue by Product</a></li>
						<li><a href="/admin/revenue/category">Revenue by Category</a></li>
						<li><a href="/admin/revenue/customer">Revenue by Customer</a></li>
						<li class="divider"></li>
						<li><a href="/admin/revenue/year">Revenue by Year</a></li>
						<li><a href="/admin/revenue/quarter">Revenue by Quarter</a></li>
						<li><a href="/admin/revenue/month">Revenue by Month</a></li>
					</ul>
				</li>
				<li class="dropdown">
					<a class="dropdown-toggle" data-toggle="dropdown" href="#"> 
						<span class="glyphicon glyphicon-lock"></span> Security
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="/admin/home/login">Sign In</a></li>
						<li><a href="/admin/home/logoff">Sign Out</a></li>
						<li><a href="/admin/home/change">Change Password</a></li>
						<li class="divider"></li>
						<li><a href="/admin/customer/index?permission">User Permissions</a></li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
</nav>