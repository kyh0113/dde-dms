<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%
String s_user_id = (String)request.getSession().getAttribute("s_user_id");
String s_user_name = (String)request.getSession().getAttribute("s_user_name");
String s_business_code = (String)request.getSession().getAttribute("s_business_code");
String s_branch_code = (String)request.getSession().getAttribute("s_branch_code");
String s_team_code = (String)request.getSession().getAttribute("s_team_code");
String s_business_name = (String)request.getSession().getAttribute("s_business_name");
String s_branch_name = (String)request.getSession().getAttribute("s_branch_name");
String s_team_name = (String)request.getSession().getAttribute("s_team_name");
String s_auth_code = (String)request.getSession().getAttribute("s_auth_code");
String s_position = (String)request.getSession().getAttribute("s_position_cd");

//!!공통 - 버튼 권한 그룹 시작
String buttun_auth = request.getAttribute("button_auth") == null ? "N@N@N@N" : request.getAttribute("button_auth").toString();
String [] buttun_auth_array = buttun_auth.split("@");
String button_auth_search = buttun_auth_array[0];
String button_auth_exec = buttun_auth_array[1];
String button_auth_delete = buttun_auth_array[2];
String button_auth_excel = buttun_auth_array[3];
//!!공통 - 버튼 권한 그룹 끝
%>
<script type="text/javascript">
//<![CDATA[
/*
 * 아래쪽에 checkAuthGroup_ver02() 함수가 존재함.
 *
 *
*/

function getIEVersion(){
    var agent = navigator.userAgent;
    var reg = /MSIE\s?(\d+)(?:\.(\d+))?/i;
    var matches = agent.match(reg);
    if (matches != null) {
//         return { major: matches[1], minor: matches[2] };
        return matches[1];
    }
//     return { major: "-1", minor: "-1" };
    return "-1";
}

$(document).ready(function(){
	<%-- !!공통 - 버튼 권한 그룹 시작 --%>
	<%-- 조회권한 --%>
	<%if("N".equals(button_auth_search)){%>
		$('.button_auth_search').addClass("notactive").attr("disabled", true);
		if(getIEVersion() === "10"){
			$('.button_auth_search i').hide();
		}
	<%}%>
	<%-- 실행권한 --%>
	<%if("N".equals(button_auth_exec)){%>
		$('.button_auth_exec').addClass("notactive").attr("disabled", true);
		if(getIEVersion() === "10"){
			$('.button_auth_exec i').hide();
		}
	<%}%>
	<%-- 삭제권한 --%>
	<%if("N".equals(button_auth_delete)){%>
		$('.button_auth_delete').addClass("notactive").attr("disabled", true);
		if(getIEVersion() === "10"){
			$('.button_auth_delete i').hide();
		}
	<%}%>
	<%-- 엑셀다운로드권한 --%>
	<%if("N".equals(button_auth_excel)){%>
		$('.button_auth_excel').addClass("notactive").attr("disabled", true);
		if(getIEVersion() === "10"){
			$('.button_auth_excel i').hide();
		}
	<%}%>
	<%-- !!공통 - 버튼 권한 그룹 끝 --%>
	
	//20161123 torus 버튼비활성화작업
	if("<%=s_auth_code%>" == "400"){
		$('a.btn:not(div.top_link a)').addClass("notactive").attr("disabled", true);
		$('a.btn:not(div.top_link a) i').hide();
	}
});
//]]>
</script>