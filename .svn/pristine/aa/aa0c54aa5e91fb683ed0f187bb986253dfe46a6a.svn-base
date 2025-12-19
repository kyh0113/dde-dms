<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- Modal -->
<div class="modal fade" id="boardUpdate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div id="modal-dialog-id" class="modal-dialog" style="width:1200px;">
    <div id="modal-content-id" class="modal-content" style="min-height:700px; min-width:1200px;">
      <div class="modal-header">
        <h4 class="modal-title">모달용 게시판팝업</h4>
      </div>
      <div class="modal-body" style="min-height:600px;" >
      		<div class="popup_tblType01" style="position:absolute;left:5px;top:15px;right:5px;bottom:15px;" >
      			<!-- 버그때문에 의미없는 form추가ㅣ-->
				<form></form>
				<form id="boardUpFrm" novalidate enctype="multipart/form-data">
					<!-- 20191023_khj for csrf -->
					<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
				    <input type="hidden" id="update_board_no" name="update_board_no">
				    <input type="hidden" id="attach_no" name="attach_no">
				  	<div class="modal-body" style="height : 600px; overflow: auto;">
				  		<div class="tableWrap">
			            	<table class="modal_table" border="0" cellpadding="0" cellspacing="0">
		                        <colgroup>
		                        	<col width="10%" />                           
		                            <col width="40%" />
		                            <col width="10%" />
		                            <col width="40%" />
		                        </colgroup>
		                        <tr class="tbl_box_modal">
		                        	<th scope="col">제목</th>
		                            <td colspan="3">
		                           		<input id="board_update_title" name="board_update_title" type="text" class="inputTxt" style="width:85%; display: inline-block;">
			                           	<label style="color:red;"><input type="checkbox" id="board_update_header_yn" name="board_update_header_yn" value="Y">머리글</label>
			                           	<!-- <label style="color:red;"><input type="checkbox" id="update_popup_yn" name="update_popup_yn"  value="Y">팝업</label> -->
		                            </td>
		                        </tr>
		                        <tr class="tbl_box_modal">
		                        	<th scope="col">작성일</th>
		                            <td>
		                           		<span id="update_creation_date"></span>
		                            </td>
		                            <th>작성인</th>
		                            <td>
		                           		<span id="update_created_by_name"></span>
		                            </td>
	                       		</tr>
		                        <tr class="tbl_box_modal">
			                       <th scope="col"  class="for-modify-strong">첨부파일</th>
			                       <td colspan="3">
			                       		<button id="addAttachFile_update_btn" class="btn btn_apply">파일첨부</button>
			                       		<span class="input-group-addon" style="padding:0px 0px; float : left; height:21px; display:none;"></span>
			                       </td>                                             
			                     </tr> 
		                        <tr class="tbl_box_modal_content">
		                        	<td colspan="4">
		                        	<textarea name="update_content" id="update_content" rows="10" cols="10" style="width: 100%;height: 250px;"></textarea>
		                        	</td>
		                        </tr>    
			            	</table>
			          	</div>	 
				  	</div>                      
				</form>
      	  	</div>	 	
      </div>
      <div class="modal-footer">
      	<button id="updateSave" type="button" class="btn" >수정</button>
      	<button id="updateClose" type="button" data-dismiss="modal" class="just-close btn">닫기</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
	var oEditors = [];
	$(document).ready(function(){
		
		/* scope를 가지고 와서 Grid영역을 불러와서 다루자 */
		var scope = angular.element(document.getElementById("board-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
		
		 /* 스마트 에디터2 시작 */
		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    /* textarea id값 */
		    elPlaceHolder: "update_content",
		    /* 스마트에디터2 틀HTML */
		    sSkinURI: "/resources/js/se/SmartEditor2Skin.html",
		    /* 스마트 에디터2 로드완료시 동작 */
		    fOnAppLoad: function(){
		    	/* height가 0px되는 버그가 있어서 넣어줌. */
		    	var ifram = $("#update_content").next("iframe");
		    	ifram.css("width","100%").css("height","344px");   

				//oEditors.getById["update_content"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		    },
		    fCreator: "createSEditor2",
		    htParams: { 
		    	bUseToolbar: true, //툴바 사용여부
		    	bUseVerticalResizer: true, //입력창 크기 조절 바
		    	bUseModeChanger: true //모드 탭
		    }
		});		
		/* 스마트에디터2 끝 */
		
		
		/* textarea와 스마트에디터2의 내용을 textarea로 옮겨준다. */
		$("#updateSave").on("click",function(){
			swal({
				  icon : "info",
				  text: "수정하시겠습니까?",
				  closeOnClickOutside : false,
				  closeOnEsc : false,
				  buttons: {
						confirm: {
						  text: "확인",
						  value: true,
						  visible: true,
						  className: "",
						  closeModal: true
						},
						cancel: {
						  text: "취소",
						  value: null,
						  visible: true,
						  className: "",
						  closeModal: true
						}
				  }
				})
				.then(function(result){
				  if(result){
					  
					  oEditors.getById["update_content"].exec("UPDATE_CONTENTS_FIELD", []);

					  var form = $("#boardUpFrm")[0];
					  var formData = scope.fileDropZone.uploadFile("boardUpFrm");
					  				  
// 					  var oForm = $("#boardWrFrm").serializeArray();
// 					  formData.append('wrData', JSON.stringify(oForm));
					  
				  	  var attachFileTable = $("#attachFileTable");
				  	  
					  $.ajax({
						 	type: 'POST',
							url: '/biz/board/updatetBoard2',
							data: formData,
							processData: false,
				            contentType: false,
							success: function(data){
								$("#search_plc").trigger("click");
								//form태그 리셋
								form.reset();
								//첨부파일 폼에서 저장파일들 remove
// 								attachFileTable.children().remove();
								
								//검색동작
								$("#board_searchValue").val("");
								$("#search_btn").trigger("click");
								
								swalSuccess("수정이 완료 됐습니다.");
								$("#boardUpdate").modal("hide");
							},
					        complete: function(){}
						});	 	  
				  }
			});   
		});
		
		$("#addAttachFile_update_btn").on("click",function(e){
			var $attachFileUpload = $("#attachFileUpload");
			$attachFileUpload.modal({
				backdrop : false,
				keyboard: false
			});
		});
		
		$("#updateClose").on("click",function(){
			$("#board_searchValue").val("");
			$("#search_btn").trigger("click");
		});
		
		$("#update_popup_yn").change(function(){
	        if($("#update_popup_yn").is(":checked")){
	        	var data = [{name : '${_csrf.parameterName}', value : '${_csrf.token}'}];
	            $.ajax({
					type: 'POST',
					url: '/biz/board/popupChk',
					data: data,
					dataType: 'json',
					async : false,
					success: function(data){
						if(data.popupNum>0){
							swalInfo("이미 선택되어진 팝업이 존재합니다."
									+"팝업이 체크된 상태에서 저장을 할 시 " 
									+"해당팝업으로 덮어씌워지게 됩니다.");
						}
					},
			        complete: function(){}
				});
	            
	        }
	    });
		
	});
	
	 //modal open event
	 $("#boardUpdate").on("shown.bs.modal",function(){

		
	
	 }); 
	 
	 //modal close event
	 $("#boardUpdate").on("hidden.bs.modal",function(){			
	 		
	 		
			
	 }); 
	
</script>





    