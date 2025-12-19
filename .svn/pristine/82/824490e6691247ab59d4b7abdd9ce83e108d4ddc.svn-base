function customExtend(obj, src){ //두개의 Array 합치는 함수 
 			Object.keys(src).forEach(function(key) { obj[key] = src[key]; });
		    return obj;
}

function gPostArray(obj){
	var paramArray = {};
	jQuery.each(obj, function(i, obj){
		paramArray[obj.name] = obj.value;
	 });
	 return paramArray;
}

function dateToYYYY_MM_DD(dateStr){
	var dateString  = dateStr+"";
	var year = dateString.substring(0, 4);
	var month = dateString.substring(4, 6);
	var day = dateString.substring(6, 8);
    return year + '-' + month + '-' + day;
}

//maxlength 체크
function maxLengthCheck(object){
	 var regexp = /^[0-9]*$/;
	 if(!regexp.test(object.value)){
		 object.value = null;
		 return false;
	 }
	 if (object.value.length > object.maxLength){
		 object.value = object.value.slice(0, object.maxLength);
	 }
	 if(object.value <= object.min){
		 object.value = 0;
	 }
}


function expandNode(treeID, nodeID) { //jstree 특정노드와 부모까지 오픈하는 함수
    // Expand all nodes up to the root (the id of the root returns as '#')
	//console.log("nodeID : ", nodeID);
	$(treeID).jstree("deselect_all");
	$(treeID).jstree("select_node", nodeID, false);
	if(isEmpty(nodeID)){
		return false;
	}
	if(nodeID == "#"){
		$(treeID).jstree("select_node", "ul > li:first");
		var selectednode = $(treeID).jstree("get_selected");
		$(treeID).jstree("open_node",selectednode,false,true);
		//$(treeID).jstree("open_node", selectednode);​
		return false;
	}
	
    while (nodeID != '#' && nodeID != false) {
        // Open this node
        $(treeID).jstree("open_node", nodeID);
        // Get the jstree object for this node
        var thisNode = $(treeID).jstree("get_node", nodeID);
        // Get the id of the parent of this node
        nodeID = $(treeID).jstree("get_parent", thisNode);

    }
}

function addComma(id){
	//console.log(document.getElementById(id).value);
	var str = document.getElementById(id).value.replace(/,/gi,"");
	//console.log(str);
	var x = Number(str);
	document.getElementById(id).value = x.toLocaleString();
}

function addCommaReturn(number){
	var x = Number(number);
	return x.toLocaleString();
}

var isEmpty = function(value){ 
		if( value == "" || value == null || value == "NULL" || value == "null" || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){ 
			return true 
		}else{ 
			return false 
		} 
};

function btnBlock(){
	var close_yn = $("#termcode option:selected").data("close-yn");
	if(close_yn == "Y"){
		$(".basic_btn").attr("disabled",true);
		$("#qnql_modal_open_btn").attr("disabled", false);
		$(".just-close").attr("disabled", false);
	}else{
		$(".basic_btn").attr("disabled",false);
	}
	$("#excel_down").attr("disabled",false);
}

function accountBsInfoCall(){
	
	var bsdata = {};
	$.ajax({
		type: 'POST',
		url: '/icm/accountBsInfo',
		data: {termcode : $("#termcode option:selected").data("term-code")},
		dataType: 'json',
		async : false,
		success: function(data){
			//console.log("accountBsInfo---");
			//console.log(data);
			bsdata = data;
			
		}
	});	    
	//console.log("bsdata:",bsdata);
	return bsdata;
}

function swalInfo(text){
	swal({
		text : text,
		icon : "info",
		button : "확인",
		closeOnClickOutside : false,
		closeOnEsc : false
	});
}

function swalSuccess(text){
	swal({
		text : text,
		icon : "success",
		button : "확인",
		closeOnClickOutside : false,
		closeOnEsc : false
	});
}
function swalWarning(text){
	swal({
		text : text,
		icon : "warning",
		button : "확인",
		closeOnClickOutside : false,
		closeOnEsc : false
	});
}
function swalDanger(text){
	swal({
		text : text,
		icon : "error",
		button : "확인",
		closeOnClickOutside : false,
		closeOnEsc : false
	});
}
/**
 * swal(정보)
 * @author 2020-05-07 jamerl
 * @param text
 * @param func - function(){} or null
 * @returns
 */
function swalInfoCB(text,func){
	swal({
		text : text,
		icon : "info",
		button : "확인",
		closeOnClickOutside : false,
		closeOnEsc : false
	}).then(func);
}
/**
 * swal(성공)
 * @author 2020-05-07 jamerl
 * @param text
 * @param func - function(){} or null
 * @returns
 */
function swalSuccessCB(text,func){
	swal({
		text : text,
		icon : "success",
		button : "확인",
		closeOnClickOutside : false,
		closeOnEsc : false
	}).then(func);
}
/**
 * swal(경고)
 * @author 2020-05-07 jamerl
 * @param text
 * @param func - function(){} or null
 * @returns
 */
function swalWarningCB(text,func){
	swal({
		text : text,
		icon : "warning",
		button : "확인",
		closeOnClickOutside : false,
		closeOnEsc : false
	}).then(func);
}
/**
 * swal(위험)
 * @author 2020-05-07 jamerl
 * @param text
 * @param func - function(){} or null
 * @returns
 */
function swalDangerCB(text,func){
	swal({
		text : text,
		icon : "error",
		button : "확인",
		closeOnClickOutside : false,
		closeOnEsc : false
	}).then(func);
}

function excelDownloadForm(param){
	var form = document.createElement("form");
	form.setAttribute("method","post");
	form.setAttribute("action", "/core/excel/excelDown");
	for(var key in param){
		var input = document.createElement("input");
		input.setAttribute("type", "hidden");
		input.setAttribute("name", key);
		input.setAttribute("value", param[key]);
		form.appendChild(input);
	}
	document.body.appendChild(form);
	return form;
}

function fillZero(n, width) {
	  n = n + '';
	  return n.length >= width ? n : new Array(width - n.length + 1).join('0') + n;
}

function NVL(str){
	if(str == null)
		str = "";
	return str;
}

$(document).ready(function(){
	$(".only-number").on("input",function(){
		var object = this;
		var regexp = /^[0-9]*$/;
		if(!regexp.test(object.value)){
			 object.value = null;
			 return false;
		}
	});
	
	$('#termListView li').find("a").on('click',function(e){
	    var $this = $(this);
	    //console.log($this[0].id);
	    $('#termListView_btn').html($this.html()).append("<span class='glyphicon glyphicon-chevron-down pull-right'></span>");
	    $("#termcode").val($this[0].id).prop("selected", true).change();
	});
	
	$('#d_termListView li').find("a").on('click',function(e){
	    var $this = $(this);
	    //console.log($this[0].id);
	    $('#d_termListView_btn').html($this.html()).append("<span class='glyphicon glyphicon-chevron-down pull-right'></span>");
	    $("#d_termcode").val($this[0].id).prop("selected", true).change();
	});
	
	$('#m_termListView li').find("a").on('click',function(e){
	    var $this = $(this);
	    //console.log($this[0].id);
	    $('#m_termListView_btn').html($this.html()).append("<span class='glyphicon glyphicon-chevron-down pull-right'></span>");
	    $("#m_termcode").val($this[0].id).prop("selected", true).change();
	});
	
	$('#a_termListView li').find("a").on('click',function(e){
	    var $this = $(this);
	    //console.log($this[0].id);
	    $('#a_termListView_btn').html($this.html()).append("<span class='glyphicon glyphicon-chevron-down pull-right'></span>");
	    $("#a_termcode").val($this[0].id).prop("selected", true).change();
	});  
	
	
	//20191218_khj 추가
	$('#ref_termListView li').find("a").on('click',function(e){
	    var $this = $(this);
	    //console.log($this[0].id);
	    $('#ref_termListView_btn').html($this.html()).append("<span class='glyphicon glyphicon-chevron-down pull-right'></span>");
	    $("#ref_termcode").val($this[0].id).prop("selected", true).change();
	});
	
});


function numCHK(VAL) {
	var numCHR = '0123456789';
	
	if (VAL.length > 0) {
		for (var i=0; i < VAL.length; i++) {
			if (-1 == numCHR.indexOf(VAL.charAt(i))) {
				return false;
			}
		}
		return true;
	}
}   

//숫자만 입력되도록
function number_filter(str){
	return str.replace(/[^0-9]/gi, "");
}


//한글만 입력되도록
function korean_filter(str){
	if((event.keyCode < 12592) || (event.keyCode > 12687))
		event.returnValue = false
}

//숫자만 허용
function NumFormatCheck(str) { 
  var strReg = /[^0-9]/gi; 

  if (strReg.test(str) ){
		return false;
  }else{
  	return true;
  }
}

//숫자랑 소수점 허용
function NumDotFormatCheck(str) { 
  var strReg = /[^0-9 .]/gi; 

  if (strReg.test(str) ){
		return false;
  }else{
  	return true;
  }
}

//숫자랑 콤마 허용
function NumComFormatCheck(str) { 
  var strReg = /[^0-9 ,]/gi; 

  if (strReg.test(str) ){
		return false;
  }else{
  	return true;
  }
}

//영문,숫자만 허용(ID체크)
function IdFormatCheck(str) { 
  var strReg = /^[A-Za-z0-9]+$/; 

  if (!strReg.test(str) ){
		return false;
  }else{
  	return true;
  }
}

//이메일 포맷 체크
function EmailFormatCheck(str){
	var strReg = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	
	if(!strReg.test(str)){
		return false;
  }else{
  	return true;
  }
}

//핸드폰번호 포맷 체크
function HpFormatCheck(str){
	var strReg = /[01](0|1|6|7|8|9)(\d{4}|\d{3})(\d{4})$/g;
	
	if(!strReg.test(str)){
		return false;
  }else{
  	return true;
  }
}

//전화번호 포맷 체크
function TelFormatCheck(str){
	var strReg = /\d{2,3}\d{3,4}\d{4}$/;
	
	if(!strReg.test(str)){
		return false;
  }else{
  	return true;
  }
}


function digit_check(e)	{
	var code = e.which ? e.which:event.keyCode;
	if(!((code >= 48 && code <= 57) || (code >= 96 && code <= 105) || (code == 8) || (code == 9))) {
		return false;
	}
}

function isValidDay(yyyy, mm, dd) {
	//유효한(존재하는) 일(日)인지 체크
	var m = parseInt(mm,10) - 1;
	var d = parseInt(dd,10);
	
	var end = new Array(31,28,31,30,31,30,31,31,30,31,30,31);
	if ((yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0) {
		end[1] = 29;
	}
	return (d >= 1 && d <= end[m]);
}

//숫자키만 입력받기, 편집키 허용
function onlyNumberKey(event){
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 109 || keyID == 189 || keyID == 8 || keyID == 9 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		return false;
}

function removeChar(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9-]/g, "");
}

