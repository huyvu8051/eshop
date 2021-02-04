$(function() {
	$(".txt-cart-update").on("input",function() {
		var id = $(this).parents("[data-id]").attr("data-id");
		var qty = $(this).val();
		$.ajax({
			url: `/cart/update/${id}/${qty}`,
			success: function(resp) {
				var info = JSON.parse(resp);
				$("#cart-cnt").html(info.count);
				$("#cart-ant").html(info.amount);

			}
		});
		var price = $(this).parents("[data-id]").attr("data-price");
		var disc = $(this).parents("[data-id]").attr("data-disc");
		var amt = Math.round(price*qty*(1-disc)*100)/100;
		$(this).parents("tr").find("td:eq(5)").html(`$${amt}`);
		
	});
	$(".btn-cart-clear").click(function() {
		$.ajax({
			url: "/cart/clear",
			success: function() {
				$("#cart-cnt").html(0);
				$("#cart-ant").html("0.0");

			}
		});
		$(".sp-cart tbody>tr").each(function(index, tr) {

			$(this).hide(500 * (1 + index));

		})
	});
	$(".btn-cart-remove").click(function() {
		var id = $(this).parents("[data-id]").attr("data-id");
		$.ajax({
			url: "/cart/remove/" + id,
			success: function(resp) {
				var info = JSON.parse(resp);
				$("#cart-cnt").html(info.count);
				$("#cart-ant").html(info.amount);

			}
		});
		$(this).parents("[data-id]").hide(100);
	});
	$(".btn-cart-add").click(function() {
		var id = $(this).parents("[data-id]").attr("data-id");
		$.ajax({
			url: "/cart/add/" + id,
			success: function(resp) {
				var info = JSON.parse(resp);
				$("#cart-cnt").html(info.count);
				$("#cart-ant").html(info.amount);
			}
		});
		var img = $(this).parents("[data-id]").find("a img");
		var src = img.attr("src");
		var css = `	.cart-fly{
								background-image: url("${src}");
								background-size: 100% 100%;
								}`;
		$("#cart-effect").html(css);
		var options = { to: "#cart-img", className: "cart-fly" };
		img.effect("transfer", options, 1000)
	})
})