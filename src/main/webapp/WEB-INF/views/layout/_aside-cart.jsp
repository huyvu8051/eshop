<%@ page pageEncoding="utf-8" %>
<div class="panel panel-danger nn-cart">
	<div class="panel-heading">
		<h3 class="panel-title">
			<span class="glyphicon glyphicon-shopping-cart"></span> Shopping Cart
		</h3>
	</div>
	<div class="panel-body">
		<div class="col-xs-5 text-center">
			<img id="cart-img" src="/static/images/shopping-cart.gif">
		</div>
		<ul class="col-xs-7">
			<li><strong id="cart-cnt">${cart.count}</strong> items</li>
			<li><strong id="cart-ant">${cart.amount}</strong> usd</li>
			<li><a href="/cart/view">View Cart</a></li>
		</ul>						
	</div>
</div>
<style id="cart-effect">
	.cart-fly{
	background-image: url("?");
	background-size: 100% 100%;
	}
</style>