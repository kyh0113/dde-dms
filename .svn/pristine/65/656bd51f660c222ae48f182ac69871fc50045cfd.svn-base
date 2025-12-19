package com.yp.zwc.rst.cntr;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.vicurus.it.core.common.Util;
import com.yp.login.srvc.intf.YPLoginService;
import com.yp.zwc.rst.srvc.intf.YP_ZWC_RST_Service;

@Controller
public class YP_ZWC_RST_Controller {

	@Autowired
	private YP_ZWC_RST_Service rstService;
	
	@Autowired
	private YPLoginService lService;
	private static final Logger logger = LoggerFactory.getLogger(YP_ZWC_RST_Controller.class);

	/**
	 * 조업도급 > 도급검수 > 도급비 소급처리
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zwc/rst/zwc_rst_create", method = RequestMethod.POST)
	public ModelAndView zwc_rst_create(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 소급처리 > 도급비 소급처리");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("zclss", ((String) session.getAttribute("zclss")));
		paramMap.put("zclst", ((String) session.getAttribute("zclst")));
		paramMap.put("schkz", ((String) session.getAttribute("schkz")));
		paramMap.put("jo_name", ((String) session.getAttribute("jo_name")));
		paramMap.put("auth", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString());

		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zwc/rst/zwc_rst_create");

		return mav;
	}
	
	/**
	 * 조업도급 > 소급처리 > 도급비 소급처리 > 소급처리
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/ipt/merge_tbl_working_monthly_report_retro")
	public ModelAndView insert_tbl_working_monthly_report_retro(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【소급처리】조업도급 > 소급처리 > 도급비 소급처리");
		HashMap resultMap = new HashMap();
		
		int result = rstService.merge_tbl_working_monthly_report_retro(request, response);
		
		resultMap.put("result", result);
		return new ModelAndView("DataToJson", resultMap);
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급비 소급처리
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/yp/zwc/rst/zwc_rst_summary_list", method = RequestMethod.POST)
	public ModelAndView zwc_rst_summary_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.debug("【화면호출】조업도급 > 소급처리 > 소급비 집계표 조회");
		ModelAndView mav = new ModelAndView();
		// 공통 - 네비게이션 시작
		Map breadcrumb = lService.select_breadcrumb(request, response);
		mav.addObject("menu", breadcrumb);
		// 공통 - 네비게이션 끝

		Util util = new Util();
		HashMap paramMap = util.getParamToMapWithNull(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		// session attr to param
		HttpSession session = request.getSession();
		paramMap.put("emp_code", (String) session.getAttribute("empCode"));
		paramMap.put("emp_name", ((String) session.getAttribute("userName")));
		paramMap.put("dept_cd", ((String) session.getAttribute("userDeptCd")));
		paramMap.put("dept_name", ((String) session.getAttribute("userDept")));
		paramMap.put("zclss", ((String) session.getAttribute("zclss")));
		paramMap.put("zclst", ((String) session.getAttribute("zclst")));
		paramMap.put("schkz", ((String) session.getAttribute("schkz")));
		paramMap.put("jo_name", ((String) session.getAttribute("jo_name")));
		paramMap.put("auth", session.getAttribute("WC_AUTH") == null ? "US" : session.getAttribute("WC_AUTH").toString());

		if (paramMap.get("auth") == null)
			paramMap.put("auth", "US");

		mav.addObject("req_data", paramMap);
		mav.setViewName("/yp/zwc/rst/zwc_rst_summary_list");

		return mav;
	}
	
	/**
	 * 조업도급 > 도급검수 > 소급비 집계 조회 > 엑셀 다운로드
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/yp/xls/zwc/rst/zwc_rst_summary_list", method = RequestMethod.POST)
	public ModelAndView xls_zwc_rst_summary_list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)

		List<HashMap<String, String>> list = rstService.select_zwc_rst_list_report(request, response);

		mav.addObject("alllist", list);
		mav.addObject("GUBUN_CODE", req_data.get("GUBUN_CODE"));
		mav.setViewName("/yp/zwc/rst/xls/zwc_rst_summary_list");
		return mav;
	}

	/**
	 * 조업도급 > 도급검수 > 소급비 집계 조회 > 소급비청구서
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping("/yp/popup/zwc/rst/zwc_rst_bill")
	public ModelAndView zwc_rst_bill(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【팝업 - 소급비청구서】조업도급 > 도급검수 > 소급비 집계 조회 ");
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		List<HashMap<String, Object>> result = rstService.zwc_rst_bill(request, response);
		
		mav.addObject("BASE_YYYY", req_data.get("BASE_YYYY"));
		mav.addObject("VENDOR_NAME", req_data.get("VENDOR_NAME"));
		mav.addObject("REPRESENTATIVE", rstService.zwc_rst_bill_representative(request, response));
		mav.addObject("list", result);
		mav.setViewName("/yp/zwc/rst/zwc_rst_bill");
		
		return mav;
	}
	
	/**
	 * 조업도급 > 소급처리 > 소급비 집계 조회 > 전표생성
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping("/yp/popup/zwc/rst/zwc_rst_doc_create")
	public ModelAndView zwc_rst_doc_create(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【팝업 - 전표생성】조업도급 > 소급처리 > 소급비 집계 조회 ");
		ModelAndView mav = new ModelAndView();
		
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		mav.addObject("GUBUN_CODE", req_data.get("GUBUN_CODE_AGGREGATION"));	//0:저장품,1:저장품 외
		mav.addObject("BASE_YYYY", req_data.get("CHECK_YYYY"));					//검수년월
		mav.addObject("GJAHR", req_data.get("CHECK_YYYY").toString().substring(0, 4));	//회계연도
		mav.addObject("VENDOR_CODE", req_data.get("VENDOR_CODE"));				//벤더코드
		mav.addObject("VENDOR_NAME", req_data.get("VENDOR_NAME"));				//벤더명
		mav.addObject("SAP_CODE", req_data.get("SAP_CODE"));					//업체 SAP코드
		mav.addObject("HKONT", req_data.get("HKONT"));							//총계정원장계정 - 저장품:43307115, 저장품외:43204101
		mav.addObject("TOTAL", req_data.get("TOTAL"));							//소급비 집계표 합계
		mav.addObject("VAT", req_data.get("VAT"));								//부가세
		mav.addObject("SUB_TOTAL", req_data.get("SUB_TOTAL"));					//공급가액
		
		List<HashMap<String, Object>> result = rstService.zwc_rst_doc_create_dt_list(request, response);	//전표생성 저장할 상세목록 가져오기
		
		JSONArray jArray = new JSONArray();
		for (int i = 0; i < result.size(); i++) {
			JSONObject data= new JSONObject();
			data.put("BSCHL", "40");											//전기키
			if("0".equals(result.get(i).get("GUBUN_CODE2"))) data.put("HKONT", "43307115");	//총계정원장계정(저장품)
			else data.put("HKONT", "43204101");												//총계정원장계정(저장품외)
			data.put("ZKOSTL", "230104");										//집행부서
			data.put("KOSTL", result.get(i).get("COST_CODE"));					//코스트센터
			//data.put("CHECK_YYYYMM", result.get(i).get("CHECK_YYYYMM"));		//검수년월
			data.put("BASE_YYYY", result.get(i).get("BASE_YYYY"));				//기준년도
			data.put("VENDOR_CODE", result.get(i).get("VENDOR_CODE"));			//벤더코드
			data.put("CONTRACT_CODE", result.get(i).get("CONTRACT_CODE"));		//계약코드
			data.put("WRBTR", result.get(i).get("PAY_AMOUNT"));					//전표통화금액 : 소급비상세조회의 월도급비??
			data.put("SGTXT", result.get(i).get("CONTRACT_NAME"));				//품목텍스트 : 거래처별 계약명(소급비 청구서)
			data.put("MENGE", result.get(i).get("MENINS"));						//수량 : 인력계약(1) - 도급월보의 월기준량, 물량계약(2) - 도급월보의 실적물량(집계), 저장품(3)
			data.put("MEINS", result.get(i).get("UNIT_NAME"));					//기본단위 : 도급계약의 단위
			jArray.add(i, data);
		}
		
		mav.addObject("list", jArray);
		mav.setViewName("/yp/zwc/rst/zwc_rst_doc_create");
		
		return mav;
	}
	
	/**
	 * 조업도급 > 도급검수 > 도급비 집계 조회 > 전표생성 저장
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({"rawtypes", "unchecked"})
	@RequestMapping("/yp/zwc/rst/zwc_rst_doc_create_save")
	public ModelAndView zwc_rst_doc_create_save(HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.debug("【팝업 - 전표생성】조업도급 > 소급처리 > 소급비 집계 조회 ");
		Util util = new Util();
		HashMap req_data = (HashMap) util.getParamToMap(request, false); // 폼에서 날아오는 모든 파라메터 담음(싱글)
		
		HttpSession session = request.getSession();
		req_data.put("emp_code", session.getAttribute("empCode"));		//사번 담기
		
		String[] return_str = rstService.createDocument(req_data);		//전표생성

		if(!"".equals(return_str[0])) {
			req_data.put("flag", return_str[0]);
			req_data.put("doc_no", return_str[2]);
			if("S".equals(return_str[0])) {	//전표생성 성공시
				int result = rstService.updateDocumentNumber(req_data);		//전표생성 후 소급비테이블에 전표번호 UPDATE
			}
		}
		
		HashMap resultMap = new HashMap();
		resultMap.put("flag", return_str[0]);
		resultMap.put("msg", return_str[1]);
		resultMap.put("doc_no", return_str[2]);

		return new ModelAndView("DataToJson", resultMap);
	}
}
