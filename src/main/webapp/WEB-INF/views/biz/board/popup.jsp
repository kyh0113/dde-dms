<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<script>
	$(document).ready(function(){
		
		/* scope를 가지고 와서 Grid영역을 불러와서 다루자 */
		var scope = angular.element(document.getElementById("board-uiGrid")).scope(); //html id를 통해서 controller scope(this) 가져옴				
	
		$("#popupAttachFile_btn").on("click",function(){
			var $attachFileUpload = $("#attachFileUpload");
			$attachFileUpload.modal({
				backdrop : false,
				keyboard: false
			});
		});
			
	});
</script>    
    
<!-- 2019-08-18 smh 추가. main창에서만 팝업창 띄워주게끔 추가. -->
<!-- Modal -->
<div class="modal fade" id="popupModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl"  style="width:1000px;">
		<div class="modal-content">
		
			<!-- 모달 헤더 -->
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h2 class="row modal-title">공지사항</h2>
			</div>
			
			
			<!-- 버그때문에 의미없는 form추가ㅣ-->
			<form></form>
			<!-- 모달 본문 -->
		  	<div class="modal-body" style="height : 600px; overflow: auto;">
            	<table class="modal_table" border="0" cellpadding="0" cellspacing="0">
                       <colgroup>
                     	<col width="12%" />                           
	                    <col />
	                    <col width="12%" />
	                    <col/>
                       </colgroup>
                       <tr class="tbl_box_modal">
                       	<th scope="col">제목</th>
                           <td colspan="3">
                          		<span id="popup_title">${popupData.title }</span>
                           </td>
                       </tr>
                       <tr class="tbl_box_modal">
                       	<th scope="col">작성일</th>
                           <td>
                          		<span id="popup_creation_date">${popupData.creation_date }</span>
                           </td>
                           <th>작성인</th>
                           <td>
                          		<span id="popup_created_by_name">${popupData.created_by_name }</span>
                           </td>
                       </tr>
                       <tr class="tbl_box_modal">
                       <th scope="col"  class="for-modify-strong">첨부파일</th>
                       <td colspan="3">
                       		<div class="input-group" id="board_view_popup_modal_files"></div>
                       		<!-- <button id="popupAttachFile_btn" class="btn btn_apply">첨부파일</button>
                       		<span class="input-group-addon" style="padding:0px 0px; float : left; height:21px; display:none;"></span> -->
                       </td>   
                     </tr> 
                       <tr class="tbl_box_modal_content">
                       	<td colspan="4">
                       		<div id="popup_content" style="width: 100%; min-height:500px;">${popupData.content}</div>
                       	</td>
                       </tr>    
            	</table>
		  	</div>                      

			<!-- 모달 푸터 -->
			<div class="modal-footer">
				<label style="color:red; margin: auto 10px auto 10px;">
					<input type="checkbox" id="popup_none" name="popup_none"  value="Y" >
					<span>&nbsp;&nbsp;7일간 보지 않기</span>
				</label><br>
      			<button id="popupCloseBtn" type="button" class="btn just-close btn" data-dismiss="modal">닫기</button>
      		</div>
      		
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script>
$(document).ready(function(){
	
	$("#popup_none").change(function(){
        if($("#popup_none").is(":checked")){
        	//7일유지 쿠기 생성
        	setCookie("not_see_popup", "Y", 7);
        }else{
        	//쿠기 삭제
        	deleteCookie("not_see_popup");
        }
    });
});

var setCookie = function(name, value, day) {
    var date = new Date();
    date.setTime(date.getTime() + day * 24 * 60 * 60 * 1000);
    document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
};

var getCookie = function(name) {
    var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
    return value? value[2] : null;
};

var deleteCookie = function(name) {
    var date = new Date();
    document.cookie = name + "= " + "; expires=" + date.toUTCString() + "; path=/";
}



</script>