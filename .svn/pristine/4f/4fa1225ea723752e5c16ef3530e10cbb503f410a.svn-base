package com.yp.batch.cntr;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yp.batch.srvc.intf.BatchService;
import com.yp.util.DateUtil;

@Controller
public class BatchController{

	private static final Logger logger = LoggerFactory.getLogger(BatchController.class);
	
	@Autowired
	BatchService batchService;
	
	@RequestMapping(value = "/yp/salary")
	public void salary(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String sabun = request.getParameter("s");
		String yyyymm = request.getParameter("y");
		batchService.retrieveSalary(sabun,yyyymm);
	}
	
	/**
	 * 배치 > SAP 조직도 동기화
	 * 01:00 (매일 1회)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/yp/batchSAP")
	public void batchSAP() throws Exception{
		batchService.batchSAP();
	}

	/**
	 * 배치 > 조업자 출퇴근 시간 DB저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/batchSyncTimecard")
	public void batchSyncTimecard(HttpServletRequest request) throws Exception{
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE,-1);
		String yesterday = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
		
		if(null != (String)request.getParameter("date")){
			yesterday = (String)request.getParameter("date");
		}
		
		batchService.batchSyncTimecard(yesterday);
	}
	
	/**
	 * 배치 > 조업자 출퇴근 시간 SAP전송
	 * 매시 30분 (매일 24회)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/batchSeokpoSoneData")
	public void batchSeokpoSoneData(HttpServletRequest request) throws Exception{
		
		String today = DateUtil.getToday();
		batchService.batchSeokpoSoneData(today);
	}
	
	/**
	 * 배치 > 본사 출퇴근 시간 SAP전송
	 * 08:40, 10:40, 13:40 (매일 3회)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/batchBonsaCapsData")
	public void batchBonsaCapsData(HttpServletRequest request) throws Exception{
		
		String today = DateUtil.getToday();
		batchService.batchBonsaCapsData(today);
	}

	/**
	 * 배치 > 안산 출퇴근 시간 SAP전송
	 * 09:10, 11:10, 14:10 (매일 3회)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/batchAnsanCapsData")
	public void batchAnsanCapsData(HttpServletRequest request) throws Exception{
		
		String today = DateUtil.getToday();
		batchService.batchAnsanCapsData(today);
	}

	/**
	 * 배치 > 조업자 출퇴근 시간 SAP전송
	 * 00:05 (매일 1회)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/batchSeokpoSoneDataYesterday")
	public void batchSeokpoSoneDataYesterday(HttpServletRequest request) throws Exception{
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE,-1);
	    String yesterday = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
		//String yesterday = (String) request.getParameter("date");
		
		batchService.batchSeokpoSoneData(yesterday);
	}
	
	/**
	 * 배치 > 조업일보 BI연동
	 * 00:10 (매일 1회)
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/yp/batchWorkingBIData")
	public void batchWorkingBIData(HttpServletRequest request) throws Exception{
		
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE,-1);
		String yesterday = new SimpleDateFormat("yyyyMMdd").format(cal.getTime());
		
		if(null != (String)request.getParameter("date")){
			yesterday = (String)request.getParameter("date");
		}
		
		batchService.batchWorkingBIData(yesterday);
	}
	
	//pdf저장 test
	@RequestMapping(value = "/yp/testPDF")
	public void savePdf(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
//		String file_name = (String)request.getParameter("file");
//		logger.debug("file="+file_name);
		
		//pdf.Excel2pdf_POI("D:\\vit_framework\\wsd_file\\aaa.xlsx");
	}
	
	@RequestMapping(value = "/yp/sapTransferEmoInfo")
	public void sapTransferEmoInfo(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		batchService.sapTransferEmoInfo();
	}
	
	/**
	 * YPWEBPOTAL-27 ENT_CODE 코드 앞의 0삭제 건
	 * 배치 > TBL_WEIGHT_DATA 의 ENT_CODE 필드의 코드 변경
	 * 
	 * 10자리일경우에 6자리로 변경하는데 앞에 0이 포함되어있을경우에만 해당한다.
	 * 
	 * 05:00 (매일 1회)
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 * 
	 */
	@RequestMapping(value = "/yp/setWeightTableEntCodeFieldReplaceData")
	public void setWeightTableEntCodeFieldReplaceData(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		batchService.setWeightTableEntCodeFieldReplaceData();
	}
	
	@RequestMapping(value = "/yp/batchMSSQLData")
	public void batchMSSQLData(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		batchService.batchMSSQLData();
	}
	
	@RequestMapping(value = "/yp/batchInsertDate")
	public void batchInsertDate(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		batchService.batchInsertDate();
	}
	
}
