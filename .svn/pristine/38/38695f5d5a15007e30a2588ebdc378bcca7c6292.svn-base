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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style>
	#zpp_ore_request_edoc_table {
		width: 100%;
   		border: 1px solid black;
   		border-collapse : collapse;
   		text-align: center;
	}
	#zpp_ore_request_edoc_table td {
		height: 22px;
		padding: 3px;
		border: 1px solid black;
	}
	#zpp_ore_request_edoc_table th {
	border: 1px solid black;
	    background-color: rgb(243, 243, 243);
	    height: 22px;
	    padding: 3px;
	    text-align: center;
	}
	#zpp_ore_request_edoc_table tr>td:first-child{
		background-color: rgb(243, 243, 243);
	}
	#zpp_ore_request_edoc_table .white {
		background-color: white !important;
	}
	tbody.assay_limit tr>td:nth-child(3){
		text-align: right;
	}
</style>
</head>
<body>
<div style="width:100%;">
	<table id="zpp_ore_request_edoc_table" class=tbl_def>
		<colgroup>
			<col width="40%" />
			<col width="10%" />
			<col width="40%" />
			<col width="10%" />
		</colgroup>
		<thead>
			<tr>
				<th>항목</th>
				<th>구분</th>
				<th>값</th>
				<th>단위</th>
			</tr>
		</thead>
		<tbody>
			<tr>
			<td>광종</td>
			<td></td>
			<td>
				${bl_data.MATERIAL_NAME }
			</td>
			<td></td>
			</tr>
			<tr>
				<td>SELLER</td>
				<td></td>
				<td>
					${bl_data.SELLER_NAME }
				</td>
				<td></td>
			</tr>
			<tr>
				<td>입항일</td>
				<td></td>
				<td>
					${bl_data.IMPORT_DATE }
				</td>
				<td></td>
			</tr>
			<tr>
				<td>입고번호</td>
				<td></td>
				<td>
					${bl_data.IMPORT_NO }
				</td>
				<td></td>
			</tr>
			<tr>
				<td>PO No</td>
				<td></td>
				<td>
					${bl_data.PO_NO }
				</td>
				<td></td>
			</tr>
			<tr>
				<td>선박명</td>
				<td></td>
				<td>
					${bl_data.VESSEL_NAME }
				</td>
				<td></td>
			</tr>
			<tr>
				<td>Discharging Rate</td>
				<td></td>
				<td>
					${bl_data.DISCHARGING_RATE }
				</td>
				<td></td>
			</tr>
			<tr>
				<td>Dem/Des</td>
				<td></td>
				<td>
					${bl_data.DEM_DES }
				</td>
				<td></td>
			</tr>
			<tr>
				<td>수량-DMT</td>
				<td></td>
				<td>
					${bl_data.DMT }
				</td>
				<td></td>
			</tr>
			<tr>
				<td>수량-WMT</td>
				<td></td>
				<td>
					${bl_data.WMT }
				</td>
				<td></td>
			</tr>
			<tr>
				<td>수분</td>
				<td></td>
				<td>
					${bl_data.MOISTURE }
				</td>
				<td>%</td>
			</tr>
		</tbody>
		<tbody class="assay_exchange">
			<tr>
				<td rowspan='4'>Assay Exchange</td>
				<td></td>
				<td>
					${bl_data.LBL_IG_1 }
				</td>
				<td></td>
			</tr>
			<tr>
				<td class="white"></td>
				<td>
					${bl_data.LBL_IG_2 }
				</td>
				<td></td>
			</tr>
			<tr>
				<td class="white"></td>
				<td>
					${bl_data.LBL_IG_3 }
				</td>
				<td></td>
			</tr>
			<tr>
				<td class="white"></td>
				<td>
					${bl_data.LBL_IG_4 }
				</td>
				<td></td>
			</tr>
		</tbody>
		<tbody class="assay_limit">
			<tr>
				<td rowspan='11'>Assay Limit</td>
				<td>${bl_data.ASSAY_LIMIT_IG_1 }</td>
				<td>${bl_data.ASSAY_LIMIT_AMT_1 }</td>
				<td>${bl_data.ASSAY_LIMIT_UNIT_1 }</td>
			</tr>
			<tr>
				<td class="white">${bl_data.ASSAY_LIMIT_IG_2 }</td>
				<td>${bl_data.ASSAY_LIMIT_AMT_2 }</td>
				<td>${bl_data.ASSAY_LIMIT_UNIT_2 }</td>
			</tr>
			<tr>
				<td class="white">${bl_data.ASSAY_LIMIT_IG_3 }</td>
				<td>${bl_data.ASSAY_LIMIT_AMT_3 }</td>
				<td>${bl_data.ASSAY_LIMIT_UNIT_3 }</td>
			</tr>
			<tr>
				<td class="white">${bl_data.ASSAY_LIMIT_IG_4 }</td>
				<td>${bl_data.ASSAY_LIMIT_AMT_4 }</td>
				<td>${bl_data.ASSAY_LIMIT_UNIT_4 }</td>
			</tr>
			<tr>
				<td class="white">${bl_data.ASSAY_LIMIT_IG_5 }</td>
				<td>${bl_data.ASSAY_LIMIT_AMT_5 }</td>
				<td>${bl_data.ASSAY_LIMIT_UNIT_5 }</td>
			</tr>
			<tr>
				<td class="white">${bl_data.ASSAY_LIMIT_IG_6 }</td>
				<td>${bl_data.ASSAY_LIMIT_AMT_6 }</td>
				<td>${bl_data.ASSAY_LIMIT_UNIT_6 }</td>
			</tr>
			<tr>
				<td class="white">${bl_data.ASSAY_LIMIT_IG_7 }</td>
				<td>${bl_data.ASSAY_LIMIT_AMT_7 }</td>
				<td>${bl_data.ASSAY_LIMIT_UNIT_7 }</td>
			</tr>
			<tr>
				<td class="white">${bl_data.ASSAY_LIMIT_IG_8 }</td>
				<td>${bl_data.ASSAY_LIMIT_AMT_8 }</td>
				<td>${bl_data.ASSAY_LIMIT_UNIT_8 }</td>
			</tr>
			<tr>
				<td class="white">${bl_data.ASSAY_LIMIT_IG_9 }</td>
				<td>${bl_data.ASSAY_LIMIT_AMT_9 }</td>
				<td>${bl_data.ASSAY_LIMIT_UNIT_9 }</td>
			</tr>
			<tr>
				<td class="white">${bl_data.ASSAY_LIMIT_IG_10 }</td>
				<td>${bl_data.ASSAY_LIMIT_AMT_10 }</td>
				<td>${bl_data.ASSAY_LIMIT_UNIT_10 }</td>
			</tr>
			<tr>
				<td class="white">${bl_data.ASSAY_LIMIT_IG_11 }</td>
				<td>${bl_data.ASSAY_LIMIT_AMT_11 }</td>
				<td>${bl_data.ASSAY_LIMIT_UNIT_11 }</td>
			</tr>
		</tbody>
		<tr>
			<td>Surveyor</td>
			<td></td>
			<td>
				${bl_data.SURVEYOR }
			</td>
			<td></td>
		</tr>
		<tr>
			<td>L/C No</td>
			<td></td>
			<td>
				${bl_data.LC_NO }
			</td>
			<td></td>
		</tr>
		<tr>
			<td>통관일</td>
			<td></td>
			<td>
				${bl_data.CLEARANCE_DATE }
			</td>
			<td></td>
		</tr>
		<tr>
			<td>수량결정방법</td>
			<td></td>
			<td>
				${bl_data.AMOUNT_DECISION }
			</td>
			<td></td>
		</tr>
		<tr>
			<td>하역사</td>
			<td></td>
			<td>
				${bl_data.UNLOADING }
			</td>
			<td></td>
		</tr>
		<tr>
			<td>입고창고</td>
			<td></td>
			<td>
				${bl_data.IMPORT_STORAGE }
			</td>
			<td></td>
		</tr>
		<tr>
			<td>접안부두</td>
			<td></td>
			<td>
				${bl_data.DOCK_NO }
			</td>
			<td></td>
		</tr>
		<tr>
			<td>야간/주휴작업일정</td>
			<td></td>
			<td>
				${bl_data.SPECIAL_SCHEDULE }
			</td>
			<td></td>
		</tr>
	</table>
</div>
</body>