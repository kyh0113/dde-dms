<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	var oEditors = [];
	$(document).ready(function(){
		/* scope를 가지고 와서 Grid영역을 불러와서 다루자 */
		var scope = angular.element(document.getElementById("board-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴
		
		/* 스마트 에디터2 시작 */
		nhn.husky.EZCreator.createInIFrame({
		    oAppRef: oEditors,
		    /* textarea id값 */
		    elPlaceHolder: "write_content",
		    /* 스마트에디터2 틀HTML */
		    sSkinURI: "/resources/js/se/SmartEditor2Skin.html",
		    /* 스마트 에디터2 로드완료시 동작 */
		    fOnAppLoad: function(){
		    	/* height가 0px되는 버그가 있어서 넣어줌. */
		    	var ifram = $("#write_content").next("iframe");
		    	ifram.css("width","100%").css("height","344px").focus();  
		    	
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
		$("#writeSave").on("click",function(){
			swal({
				  icon : "info",
				  text: "저장하시겠습니까?",
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
					  
					  //에디터에 작성된 내용을 실제 서버에 전달될 텍스트박스에 업데이트 시키는 처리 부분입니다.
					  oEditors.getById["write_content"].exec("UPDATE_CONTENTS_FIELD", []);

					  var form = $("#boardWrFrm")[0];
					  var formData = scope.fileDropZone.uploadFile("boardWrFrm");
					  
				  	  var attachFileTable = $("#attachFileTable");
				  	  
					  $.ajax({
						 	type: 'POST',
							url: '/biz/board/insertBoard',
							data: formData,
							processData: false,
				            contentType: false,
							success: function(data){
								$("#search_plc").trigger("click");
								//form태그 리셋
								form.reset();
								//첨부파일 폼에서 저장파일들 remove
								attachFileTable.children().remove();
								
								//검색동작
								$("#board_searchValue").val("");
								$("#search_btn").trigger("click");
								
								swalSuccess("저장 되었습니다.");
								$("#boardWriteModal").modal("hide");
							},
					        complete: function(){}
						});	 	  
				  }
			});   
		});
		
		//첨부파일 모달띄우기
		$("#addAttachFile_btn").on("click",function(){
			var $attachFileUpload = $("#attachFileUpload");
			$attachFileUpload.modal({
				backdrop : false,
				keyboard: false
			});
		});
		
		//보드게시판 화면 리로드
		$("#writeClose").on("click",function(){
			$("#board_searchValue").val("");
			$("#search_btn").trigger("click");
		});
		
		//팝업 게시글 확인
		$("#popup_yn").change(function(){
	        if($("#popup_yn").is(":checked")){
	        	var data = [{name : '${_csrf.parameterName}', value : '${_csrf.token}'}];
	            $.ajax({
					type: 'POST',
					url: '/biz/board/popupChk',
					data: data,
					//서버에서 반환되는 데이터 형식을 지정합니다.
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
</script>

<!-- Modal -->
<div class="modal fade" id="boardWriteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
    
      <!-- 모달 헤더 -->
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title" id="myModalLabel">공지글 작성</h4>
      </div>
      
      <!-- 모달 본문 -->
      <div class="modal-body">
      
     	<!-- 버그때문에 의미없는 form추가ㅣ-->
	  	<form></form>
	  	<form id="boardWrFrm" novalidate enctype="multipart/form-data">
	  		<!-- 20191023_khj for csrf -->
			<input type="hidden" name="${_csrf.parameterName}" id="${_csrf.parameterName}" value="${_csrf.token}" />
	      	<!-- 테이블 -->
		  	<table class="modal_table" border="0" cellpadding="0" cellspacing="0">
	        	 <colgroup>
	            	<col width="12%" />                           
                    <col />
                    <col width="12%" />
                    <col/>
	             </colgroup>
	             <tr class="tbl_box_modal">
	             	<th scope="col">제목</th>
	               	<td>
	                	<input id="board_title" name="board_title" type="text" class="inputTxt" style="width:85%; display: inline-block;">
	                	<label style="color:red;"><input type="checkbox" id="board_header_yn" name="board_header_yn"  value="Y">&nbsp;머리글</label>
	                	<label style="color:red;"><input type="checkbox" id="popup_yn" name="popup_yn"  value="Y">&nbsp;팝업</label>
	               	</td>
	             </tr>
	             <tr class="tbl_box_modal" style="margin-bottom:10px;">
	             	<th scope="col"  class="for-modify-strong">첨부파일</th>
	             	<td>
	             		<button id="addAttachFile_btn" class="btn btn_apply">파일첨부</button>
	             		<span class="input-group-addon" style="padding:0px 0px; float : left; height:21px; display:none;"></span>
	             	</td>                                           
	           	</tr>
	           	<tr class="tbl_box_modal_content">
	            	<td colspan="2">
	             	<textarea name="write_content" id="write_content" rows="10" cols="10" style="width: 100%;height: 250px;"></textarea>
	             	</td>
	           </tr>    
		  	</table>
	  	</form>
      </div>
      
      <!-- 모달 푸터 -->
      <div class="modal-footer">
      	<button id="writeSave" type="button" class="btn">저장</button>
        <button id="writeClose" type="button" class="btn" data-dismiss="modal">닫기</button>
      </div>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
