<%@ page pageEncoding="utf-8"%>

<!-- Modal -->
<div id="send-dialog" class="modal fade" role="dialog">
	<div class="modal-dialog">

		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">Gửi thông tin hàng hoá cho bạn bè và người thân</h4>
			</div>
			<div class="modal-body">
				<input type="hidden" id="id">
				<div class="form-group">
					<input class="form-control" id="from" placeholder="Sender?">
				</div>
				<div class="form-group">
					<input class="form-control" id="to" placeholder="Receive?">
				</div>
				<div class="form-group">
					<input class="form-control" id="subject" placeholder="Subject">
				</div>
				<div class="form-group">
					<textarea class="form-control" id="body" placeholder="Content?" rows="3"></textarea>
				</div>
			</div>
			<div class="modal-footer ">
			<div class="pull-left" id="sending" style="display: none">
			<img src="/static/images/small-loading.gif" >Sending, please wait...</div>
				<button class="btn btn-send2Friend">Send</button>
			</div>
		</div>

	</div>
</div>
