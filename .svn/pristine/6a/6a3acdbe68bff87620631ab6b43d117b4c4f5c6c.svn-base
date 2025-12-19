<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
if (request.getProtocol().equals("HTTP/1.1"))
	response.setHeader("Cache-Control", "no-cache");
%>

<script type="text/javascript" src="/resources/js/jquery-1.11.1.min.js"></script>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<style>
		.tbl_def {
			width: 100%;
	   		border: 1px solid black;
	   		border-collapse : collapse;
	   		text-align: center;
		}
		.tbl_def td {
			height: 22px;
			padding: 3px;
			border: 1px solid black;
		}
		.tbl_def th {
		border: 1px solid black;
		    background-color: rgb(243, 243, 243);
		    height: 22px;
		    padding: 3px;
		    text-align: center;
		}
		.tbl_def .white {
			background-color: white !important;
		}
		.tbl_def tbody.assay_limit tr>td:nth-child(3){
			text-align: right;
		}
	</style>
</head>
<body>
<div id="table_space" style="width:100%;">
	<table class=tbl_def>
		<colgroup>
			<col width="10%" />
			<col width="15%" />
			<col width="10%" />
			<col width="15%" />
			<col width="10%" />
			<col width="15%" />
			<col width="10%" />
			<col width="15%" />
		</colgroup>
		<thead>
			<tr>
				<th>광종명</th>
				<td>
					${req_data[0].MATERIAL_NAME }
				</td>
				<th>업체명</th>
				<td>
					${req_data[0].SELLER_NAME }
				</td>
				<th>입항일자</th>
				<td>
					${req_data[0].IMPORT_DATE }
				</td>
				<th>LOT COUNT</th>
				<td>
					${req_data[0].LOT_COUNT }
				</td>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table>
</div>
<br><br>
<div style="width:100%;">
	<table id="table_1" class=tbl_def>
		<colgroup>
			<col width="25%" />
			<col width="25%" />
			<col width="25%" />
			<col width="25%" />
		</colgroup>
		<thead id="thead">
		</thead>
		<tbody id="tbody">
		</tbody>
	</table>
</div>
</body>

<script>
var aData = ${req_data_string};
console.log('[TEST]aData:',aData);

jQuery(document).ready(function() {
	renderTable();
});

function renderTable(lotCount) {
	// 성분별로 구분 
	
	for(var i=0; i<aData.length; i++){
		const oItem = aData[i];
		console.log('[TEST]oItem:',oItem);
	}
	// 성분별로 테이블 생성
	createTable();
	
}

function createTable() {
	// 테이블 생성
	const oTable = document.createElement('table');
	oTable.classList.add('tbl_def');
	
	// colGroup 생성
	const oColgroup = document.createElement('colgroup');
	for(var i=0; i<4; i++){
		const oCol = document.createElement('col');
		oCol.setAttribute('width', '25%');
		oColgroup.appendChild(oCol);
	}
	
	oTable.appendChild(oColgroup);
	
	// head 생성
	createHead(oTable);
	
	// body 생성
	createBody(oTable);
	
}

function createHead(oTable) {
	const oHead = document.createElement('thead');
	const oTr = document.createElement('tr');
	oTr.style.cssText = 'background-color: rgb(243, 243, 243); font-weight: bold;';    
	
	addColumn(oTr, 'Lot');
	addColumn(oTr, 'DMT');
	addColumn(oTr, 'YP');
	addColumn(oTr, 'SELLER');
	addColumn(oTr, 'SPLIT');
	addColumn(oTr, 'AVERAGE');
	addColumn(oTr, 'SELLER 의견');
	addColumn(oTr, 'YP 의견');
	
	oHead.appendChild(oTr);
	oTable.appendChild(oHead);
}

function createBody() {
	const oBody = document.createElement('tbody');
	for(var i=1; i<=aData.LOT_COUNT; i++ ){
		const oTr = document.createElement('tr');
		
		addColumn(oTr, i);
		for(var j=1; j<=3; j++){
			addColumn(oTr, aData['LOT_' + i + '_IG_' + j + '_VALUE']);
		}
		oBody.appendChild(oTr);		
	}
}

function addColumn(oTr, oContents){
	const oTd = document.createElement('td');
		
	oTd.innerHTML = oContents;
	oTr.appendChild(oTd);		
}

</script>
