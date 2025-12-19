package com.vicurus.it.core.common;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRPrintPage;
import net.sf.jasperreports.engine.JRRuntimeException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.util.JRLoader;

/**
 * <p>
 * 공통 Util.
 * </p>
 * @author YAME
 * @version $Revision: 001  $Date: 2013-07-01 
 */
@Controller
@Repository
public class CommonUtil {
	@Autowired
    private ServletContext servletContext;
	
	@Autowired
	@Resource(name="sqlSession")
	private SqlSession query;
	
	//config.properties 에서 설정 정보 가져오기 시작
	private static String NAMESPACE;
				
	@Value("#{config['db.vendor']}")
	public void setNAMESPACE(String value) {
		this.NAMESPACE = value + ".";
	}
	//config.properties 에서 설정 정보 가져오기 끝

	
	private static final Logger logger = LoggerFactory.getLogger(CommonUtil.class);
	/**
	 * 콤보 - 공통코드
	 */
	public List getCommonCodeForCombo(String str) throws Exception {
		Map map = new HashMap();
		map.put("p_code", str);
		List dataList = query.selectList(NAMESPACE+"Code.getCommonCode", map);
		return dataList;
	}
	
	public List getCommonInsurerPerName() throws Exception {
		List dataList = query.selectList(NAMESPACE+"Common.getInsurerAtContractPerName");
		return dataList;
	}
	
	/**
	 * myBatis id를 지정하여 조회
	 * @return List
	 * @throws Exception
	 * @author Jamerl
	 */
	@SuppressWarnings("rawtypes")
	public List selectCustomSQLtoList(String myBatisId) throws Exception {
		List dataList = query.selectList(myBatisId);
		return dataList;
	}
	
	@SuppressWarnings("rawtypes")
	public List selectCustomSQLtoList(String myBatisId, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false);
		List dataList = query.selectList(myBatisId, paramMap);
		return dataList;
	}
	
	@SuppressWarnings("rawtypes")
	public List selectCustomSQLtoList(String myBatisId, Map paramMap) throws Exception {
		List dataList = query.selectList(myBatisId, paramMap);
		return dataList;
	}
	
	/**
	 * myBatis id를 지정하여 조회
	 * @return String
	 * @throws Exception
	 * @author Jamerl
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map selectCustomSQLtoMap(String myBatisId, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false);
		Map map = new HashMap();
		map.put("result_code", 1);
		map.put("list", query.selectList(myBatisId, paramMap));
		return map;
	}
	
	/**
	 * myBatis id를 지정하여 조회
	 * @return String
	 * @throws Exception
	 * @author Jamerl
	 */
	@SuppressWarnings("rawtypes")
	public String selectCustomSQLtoString(String myBatisId, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Util util = new Util();
		Map paramMap = util.getParamToMap(request, false);
		String dataList = query.selectOne(myBatisId, paramMap);
		return dataList;
	}
	@SuppressWarnings("rawtypes")
	public String selectCustomSQLtoString(String myBatisId, Map paramMap) throws Exception {
		String dataList = query.selectOne(myBatisId, paramMap);
		return dataList;
	}
	
    @SuppressWarnings({ "unchecked", "rawtypes" })
	public static List merge(List list0, List list1) {
        if (list0 == null) return list1;
        if (list1 == null) return list0;
        
        List list = new ArrayList(list0);
        for (int i = 0; i < list1.size(); i++) {
            list.add(list1.get(i));
        }
        return list;
    }
    
    public static boolean isNull(String str) {
        return (str == null || str.trim().equals(""));
    }
    
    public static boolean isHave(int num, int[] numArray) {
        boolean result = false;
        if (numArray != null) {
            for (int i = 0; i < numArray.length; i++) {
                if (numArray[i] == num) {
                    result = true;
                    break;
                }
            }
        }
        return result;
    }
    
	/**
	 * 문자열로 구성될 날자를 조합해서 반환한다.
     * @param toYear
     * @param toMonth
     * @param toDay
     * @param string
     * @return
     */
	public static String getMergedStringDate(String year, String month, String day, String time) {
        StringBuffer result = new StringBuffer();
        result.append(year);
        if (month.length() == 1) {
            result.append('0');
        }
        result.append(month);
        if (day.length() == 1) {
            result.append('0');
        }
        result.append(day);
        result.append(time);
        
        return result.toString();
    }
	
    /**
     * 이전 페이지 주소를 가져온다.
     * 
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
	public static String getPrevUrl(HttpServletRequest request) {
        String url = request.getHeader("referer");

		if (url != null) {
    		StringBuffer sb = new StringBuffer(url);
    		Enumeration enumer = request.getParameterNames();
    		boolean isFirst = (url.indexOf("?") < 0);
            if (isFirst) {
                String name = null;
                String value = null;
                while(enumer.hasMoreElements()) {
                    name = (String)(enumer.nextElement());
                    value = request.getParameter(name);
                    if (value != null && !name.equals("url")) {
                        if(isFirst) {
                            sb.append('?');
                            sb.append(name).append("=").append(value);
                            isFirst = false;
                        } else {
                            sb.append('&').append(name).append("=").append(value);
                        }
                    }
                }                
            }
    		url = sb.toString();
		}
        
        return url;
    }
    
    /**
     * html 태그 을 모두 제거
     * @param param
     * @return
     */
    public static String delHtmlTag(String param){
        Pattern p = Pattern.compile("\\<(\\/?)(\\w+)*([^<>]*)>");
        Matcher m = p.matcher(param);
        param = m.replaceAll("").trim();
        return param;
    }

    /**
     * 세자리마다 콤마찍기
     * @param str
     * @return
     */
	public static String comma(String str){
        String temp = reverseString(str);
        String result = "";
 
        for(int i = 0 ; i < temp.length() ; i += 3) {
            if(i + 3 < temp.length()) {
                result += temp.substring(i, i + 3) + ",";
            }
            else {
                result += temp.substring(i);
            }
        }
 
        return reverseString(result);
    }
 
	public static String reverseString(String s){
        return new StringBuffer(s).reverse().toString();
    }
	
    /**
     * 오늘날짜구하기
     * @param str
     * @return
     */
	public static String getToday(){
		 Date now = new Date(); 
		 SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 
 
        return sdf.format(now);
    }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void generatePDFOutput(HttpServletResponse resp, Map parameters, List fileNames, Connection conn) throws JRException, NamingException, SQLException, IOException {
		JasperPrint jasperPrint = new JasperPrint();
		ArrayList<JasperPrint> reportsList = new ArrayList<JasperPrint>();
		for(int i=0; i < fileNames.size(); i++){
			logger.debug("경로확인: {}", servletContext.getRealPath("/WEB-INF/reports/" + fileNames.get(i) + ".jasper"));
			File reportFile = new File(servletContext.getRealPath("/WEB-INF/reports/" + fileNames.get(i) + ".jasper"));
			if(!reportFile.exists()){
				throw new JRRuntimeException("File "+fileNames.get(i)+"not found. The report design must be compiled first.");
			}
			JasperReport jasperReport = (JasperReport)JRLoader.loadObjectFromFile(reportFile.getPath());	//jasperreport 객체 생성
			JasperPrint jp = JasperFillManager.fillReport(jasperReport, parameters, conn);					//jasperreport DB연결
			reportsList.add(jp);																			//리스트에 jasperprint 객체 담음(레포트 종류만큼 반복)
		}
		if(reportsList != null && reportsList.size() > 0){
			jasperPrint = mergeReport(reportsList); 	//merge the report
			//PDF 출력
			byte[] bytes = JasperExportManager.exportReportToPdf(jasperPrint);
			resp.setContentType("application/pdf");
			resp.setContentLength(bytes.length);
			ServletOutputStream ouputStream = resp.getOutputStream();
			ouputStream.write(bytes, 0, bytes.length);
			ouputStream.flush();
			ouputStream.close();
		}
	}
	//report MERGE Function
	private JasperPrint mergeReport(ArrayList<JasperPrint> reportList){
		JasperPrint jrPrint = new JasperPrint();
		JasperPrint jp = (JasperPrint) reportList.get(0);
		//set the report layout
		//jrPrint.setOrientaion(jp.getOrientation());
		jrPrint.setLocaleCode(jp.getLocaleCode());
		jrPrint.setPageHeight(jp.getPageHeight());
		jrPrint.setPageWidth(jp.getPageWidth());
		jrPrint.setTimeZoneId(jp.getTimeZoneId());
		jrPrint.setName(jp.getName());
		//get each report and merge int 1 by 1
		for(int i=0; i < reportList.size(); i++){
			jp = (JasperPrint) reportList.get(i);
			List<JRPrintPage> list = jp.getPages();	
			//Merging the reorts into 1 single report
			for(int j=0; j < list.size(); j++){
				jrPrint.addPage((JRPrintPage)list.get(j));
			}
		}
		return jrPrint;
	}
}
