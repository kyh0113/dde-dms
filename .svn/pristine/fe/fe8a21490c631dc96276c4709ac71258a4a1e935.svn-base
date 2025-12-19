<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	$(document).ready(
			function() {

				/* scope를 가지고 와서 Grid영역을 불러와서 다루자 */
				var scope = angular.element(
						document.getElementById("board-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴

				$("#viewAttachFile_btn").on("click", function() {
					var $attachFileUpload = $("#attachFileUpload");
					$attachFileUpload.modal({
						backdrop : false,
						keyboard : false
					});
				});

				$("#viewCloseBtn").on("click", function() {
					$("#board_searchValue").val("");
					$("#search_btn").trigger("click");
				});

			});
</script>

<!-- Modal -->
<div class="modal fade" id="viewModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog" style="width: 1000px;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h2 class="row modal-title">상세보기</h2>
			</div>
			<!-- 버그때문에 의미없는 form추가ㅣ-->
			<form></form>
			<div class="modal-body" style="height: 600px; overflow: auto;">
				<table class="modal_table" border="0" cellpadding="0"
					cellspacing="0">
					<colgroup>
						<col width="12%" />
						<col />
						<col width="12%" />
						<col />
					</colgroup>
					<tr class="tbl_box_modal">
						<th scope="col">제목</th>
						<td colspan="3"><span id="view_title"></span></td>
					</tr>
					<tr class="tbl_box_modal">
						<th scope="col">작성일</th>
						<td><span id="view_creation_date"></span></td>
						<th>작성인</th>
						<td><span id="view_created_by_name"></span></td>
					</tr>
					<tr class="tbl_box_modal">
						<th scope="col" class="for-modify-strong">첨부파일</th>
						<td colspan="3">
							<div class="input-group" id="board_view_modal_files"></div>
							<!-- <button id="viewAttachFile_btn" class="btn btn_apply">첨부파일</button>
							<span class="input-group-addon"
							style="padding: 0px 0px; float: left; height: 21px; display: none;"></span> -->
						</td>
					</tr>
					<tr>
						<td colspan="4">
							<div id="view_content" style="width: 100%; min-height: 500px;"></div>
						</td>
					</tr>
				</table>
			</div>

			<div class="modal-footer">
				<button id="viewCloseBtn" type="button" class="just-close btn"
					data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
