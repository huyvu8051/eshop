$(function() {
	$(".btn-favo").click(function() {
		var id = $(this).parents("[data-id]").attr("data-id");
		$.ajax({
			url: "/product/favo/" + id,
			success: function(resp) {
				alert(resp);
			}
		})
	});
	$(".btn-send").click(function() {
		var id = $(this).parents("[data-id]").attr("data-id");
		$("#send-dialog #id").val(id);
		$("#send-dialog").modal("show");
	});

	$(".btn-send2Friend").click(function() {
		var data = {
			id: $("#send-dialog #id").val(),
			from: $("#send-dialog #from").val(),
			to: $("#send-dialog #to").val(),
			subject: $("#send-dialog #subject").val(),
			body: $("#send-dialog #body").val()
		}
		$("#sending").show();
		$.ajax({
			url: "/product/send/",
			data: data,
			type: "POST",
			success: function(resp) {
				$("#sending").hide();
				alert(resp);
				//$("#send-dialog").modal("hide");
			}
		})
	})
})



