<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	$(document).ready(function() {
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
		
		/* 댓글 보내기 */
		$("#comment_post").on("click", function() {
			var comment_textarea = $("#comment_textarea").val();
			console.log('[TEST]comment_textarea:',comment_textarea);
			
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			
			var board_no = $("#board_no").val();
			
			var data = 
			{
				'BOARD_NO' : board_no,
				'CLASS' : 0, //0:부모, 1:자식
				'CONTENT' : comment_textarea
			};
			
			console.log('[TEST]data:',data);
			
			$.ajax({
				url : "/biz/board/insertComment",
				type : "post",
				cache : false,
				async : true,
				data : data,
				dataType : "json",
				success : function(result) {
					console.log('[TEST]result:',result);
					if(result.result > 0){
						//댓글입력창 초기화
						$("#comment_textarea").val('');
						
						//댓글 리로드
						comment_reload();
					}
					
				},
				beforeSend : function(xhr) {
					// 2019-10-23 khj - for csrf
					xhr.setRequestHeader(header, token);
					$('.wrap-loading').removeClass('display-none');
				},
				complete : function() {
					$('.wrap-loading').addClass('display-none');
				},
				error : function(request, status, error) {
					console.log("code:" + request.status + "\n" + "message:" + request.json + "\n" + "error:" + error);
					swalDangerCB("댓글 저장에 실패하였습니다.\n관리자에게 문의해주세요.");
				}
			});
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
				<input type="hidden" name="board_no" id="board_no" />
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
				<!-- 댓글 입력창 -->
				<div class="container_medium2" style="background: #f0f0f0; margin-bottom: 20px;">
		            <div style="padding:20px;">
		                <div style="margin-bottom: 10px;">Comments</div>
		                	<textarea id="comment_textarea" style="width: 100%; height: 100px; margin-bottom: 10px;"></textarea>
		                <div>
		                    <button id="comment_post" class="btn" style="background: black; color: white;">Post</button>
		                </div>
	                </div>
        		</div>
        		<!-- 댓글 결과창 -->
        		<div id="comment_result">
        		</div>
			</div>

			<div class="modal-footer">
				<button id="viewCloseBtn" type="button" class="just-close btn"
					data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
