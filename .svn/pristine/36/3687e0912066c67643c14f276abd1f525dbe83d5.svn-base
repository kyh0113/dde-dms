package com.vicurus.it.core.common;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Map;
import java.util.Random;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.ArrayList;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 
/**
 * <p>
 * WebUtil.
 * </p>
 * @author YAME
 * @version $Revision: 001  $Date: 2013-07-01 
 */
public class WebUtil {
    
	
   
    /**
     * 쿠키값을 생성한다.
     * @param res
     * @param name
     * @param value
     */
    public static void setCookie(HttpServletResponse res, String name, String value ) {

    	Cookie cookie=new Cookie(name, value);  // 쿠키 생성

    	cookie.setMaxAge(-1);	// 쿠키의 생성시간 저장 .  -1이면 계속유지 .. 홈페이지 벗어나면 사라짐.
    	cookie.setPath("/");	// 패스 설정??
    	res.addCookie(cookie);
    }
    /**
     * 쿠키값을 생성한다.
     * @param res
     * @param name
     * @param value
     * @param age
     */
    public static void setCookie(HttpServletResponse res, String name, String value, int age) {

    	Cookie cookie=new Cookie(name, value); // 쿠키 생성
    	
    	cookie.setMaxAge(age);
    	cookie.setPath("/");
    	res.addCookie(cookie);
    }
    /**
     * 쿠키값을 가져온다.
     * @param request
     * @param name
     * @return
     */
    public static Cookie getCookie(HttpServletRequest request, String name) {
        Cookie value = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                if (cookies[i].getName().equals(name)) {
                    value = cookies[i];
                    break;
                }
            }
        }       
        return value;
    }
   
    /**
     * 쿠키를 제거한다.
     * @param request
     * @param name
     */
    public static void removeCookie(HttpServletRequest request, String name) {
        Cookie cookie = getCookie(request, name);
        if (cookie != null) {
            cookie.setMaxAge(0);
        }
    }
    /**
     * 쿠키를 제거한다.
     * @param request
     * @param res
     * @param name
     */
    public static void removeCookie(HttpServletRequest request, HttpServletResponse res, String name) {
        Cookie cookie = getCookie(request, name);
        if (cookie != null) {
            cookie.setMaxAge(0);
            cookie.setPath("/");
            res.addCookie(cookie);
        }
    }
    
    /**
     * 현재페이지의 주소를 가져온다.
     * 
     * @param request
     * @return
     */
    public static String getURI(HttpServletRequest request) {
       return request.getRequestURI() + "?" + request.getQueryString(); 
    }
    
    /**
     * 관심 컨텐츠로 등록하기 위한 현재페이지 주소를 가져온다.
     * 
     * @param request
     * @return
     */
    public static String getURIForContent(HttpServletRequest request) {
        StringBuffer uri = new StringBuffer(); 
        uri.append(request.getRequestURI()).append("?");
        String query = request.getQueryString();
        if (query != null) {
            int index = -1;
            if ((index = query.indexOf("listURI")) > -1) {
                if (index > 0) {
                    uri.append(query.substring(0, index - 1));
                    int eIndex = query.indexOf("&", index + 1);
                    if (eIndex > -1) {
                        uri.append(query.substring(eIndex));
                    }                    
                }

            } else {
                uri.append(query);
            }
        }
        return uri.toString();
    }
    
    public static String getListURL(HttpServletRequest request) {
        String listURI = request.getParameter("listURI");
        return CommonUtil.isNull(listURI) ? CommonUtil.getPrevUrl(request) : listURI;
    }
    /**
     * 년,월을 yyyyMM 형식으로 리턴
     * @param year
     * @param month
     * @return
     */
    public static String mergeDateStringYYYYMM(String year, String month){
        StringBuffer result = new StringBuffer();
        result.append(year);
        if (CommonUtil.isNull(month)) {
            result.append("00");
        } else {
            if (month.length() < 2) {
                result.append("0");
            }
            result.append(month);
        }
        
        return result.toString();
    }
    /**
     * 년,월을 yyyyMM 형식으로 리턴
     * @param year
     * @param month
     * @return
     */
    public static String mergeDateStringYYYYMM(int year, int month){
    	return mergeDateStringYYYYMM(year==0 ? "0000" : year+"", month==0 ? "00" : month+"");
    }
    /**
     * 년, 월, 일을 입력받아 하나(8자리 yyyyMMdd)로 합친다.
     * 월, 일이 null일경우는 00으로 된다. 
     * 
     * @param year
     * @param month
     * @param day
     * @return
     */
    public static String mergeDateString2(String year, String month, String day) {
        StringBuffer result = new StringBuffer();
        result.append(year);
        if (CommonUtil.isNull(month)) {
            result.append("00");
        } else {
            if (month.length() < 2) {
                result.append("0");
            }
            result.append(month);
        }
        
        if (CommonUtil.isNull(day)) {
            result.append("00");
        } else {
            if (day.length() < 2) {
                result.append("0");
            }
            result.append(day);
        }
        
        return result.toString();
    }
    /**
     * 년월일 형식을 yyyyMMdd 형식으로 리턴
     * @param request
     * @param name1 year
     * @param name2 month
     * @param name3 day
     * @return
     */
    public static String mergeDateString2(HttpServletRequest request, String name1, String name2, String name3) {
        return mergeDateString2(request.getParameter(name1), request.getParameter(name2), request.getParameter(name3));
    }
    
    /**
     * 년, 월, 일, 시, 분
     * yyyMMddHHmm 형식으로 리턴 
     * @param year
     * @param month
     * @param day
     * @param hour
     * @param min
     * @return
     */
    public static String mergeDateString3(String year, String month, String day, String hour, String min) {
        StringBuffer result = new StringBuffer();
        result.append(year);
        if (CommonUtil.isNull(month)) {
            result.append("00");
        } else {
            if (month.length() < 2) {
                result.append("0");
            }
            result.append(month);
        }
        
        if (CommonUtil.isNull(day)) {
            result.append("00");
        } else {
            if (day.length() < 2) {
                result.append("0");
            }
            result.append(day);
        }

        if (CommonUtil.isNull(hour)) {
            result.append("00");
        } else {
            if (hour.length() < 2) {
                result.append("0");
            }
            result.append(hour);
        }        
        
        if (CommonUtil.isNull(min)) {
            result.append("00");
        } else {
            if (min.length() < 2) {
                result.append(min);
            }        	
            result.append("0");
        }        
        
        return result.toString();
    }
    /**
     * yyyMMddHHmm 형식으로 리턴 
     * @param request
     * @param name1 year
     * @param name2 month
     * @param name3 day
     * @param name4 hour
     * @param name5 minute
     * @return
     */
    public static String mergeDateString3(HttpServletRequest request, String name1, String name2, String name3, String name4, String name5) {
        return mergeDateString3(request.getParameter(name1), request.getParameter(name2), request.getParameter(name3), request.getParameter(name4), request.getParameter(name5));
    }    
    
    /**
     * 우편번호를 붙임
     * @param zipcode1
     * @param zipcode2
     * @return
     */
    public static String mergeZipcode(String zipcode1, String zipcode2) {
        StringBuffer result = new StringBuffer();
        if (zipcode1 != null) {
            result.append(zipcode1.trim());
        }
        if (zipcode2 != null) {
        	result.append("-");
            result.append(zipcode2.trim());
        }
        return result.toString();
    }
    /**
     * 이메일주소를 붙임
     * @param email1
     * @param email2
     * @return
     */
    public static String mergeEmail(String email1, String email2) {
        StringBuffer result = new StringBuffer();
        if (email1 != null) {
            result.append(email1.trim());
        }
        if (email2 != null) {
            result.append("@");
            result.append(email2.trim());
        }
        return result.toString();
    }
    
    /**
     * 세 문자열을 입력받아 전화번호를 만든다.
     * 
     * @param telNo1
     * @param telNo2
     * @param telNo3
     * @return
     */
    public static String mergeTelNo(String telNo1, String telNo2, String telNo3) {
        StringBuffer result = new StringBuffer();
        if (telNo1 != null) {
            result.append(telNo1.trim());
            if (telNo2 != null) {
                result.append("-");
                result.append(telNo2.trim());
            }
            if (telNo3 != null) {
                result.append("-");
                result.append(telNo3.trim());
            }
        } else {
            if (telNo2 != null) {
                result.append(telNo2.trim());
                if (telNo3 != null) {
                    result.append("-");
                    result.append(telNo3.trim());
                }
            } else {
                if (telNo3 != null) {
                    result.append(telNo3.trim());
                }                
            }
        }

        return result.toString();
    }
    
    /**
     * 세 문자열을 입력받아 생년월일를 만든다.
     * 
     * @param birth1
     * @param birth2
     * @param birth3
     * @param deligater
     * @return
     */
    public static String mergeBrith(String birth1, String birth2, String birth3, String deligater) {
        StringBuffer result = new StringBuffer();
        if (birth1 != null) {
            result.append(birth1.trim());
            if (birth1 != null) {
                result.append(deligater);
                result.append(birth2.trim());
            }
            if (birth3 != null) {
                result.append(deligater);
                result.append(birth3.trim());
            }
        } else {
            if (birth2 != null) {
                result.append(birth2.trim());
                if (birth3 != null) {
                    result.append(deligater);
                    result.append(birth3.trim());
                }
            } else {
                if (birth3 != null) {
                    result.append(birth3.trim());
                }                
            }
        }

        return result.toString();
    }
    /**
     * 
     * @param request
     * @param name1
     * @param name2
     * @param name3
     * @return
     */
    public static String mergeTelNo(HttpServletRequest request, String name1, String name2, String name3) {
        return mergeTelNo(request.getParameter(name1), request.getParameter(name2), request.getParameter(name3));
    }
    
    
   

    /**
     * 현재 날짜를 String형식으로 리턴
     * @param formatString
     * @return
     */

    public static String getCurDateStr(String formatString) {
        SimpleDateFormat formatter  = new SimpleDateFormat(formatString);
        Date currentTime= new Date();
        return formatter.format(currentTime);
    }
    
    /**
     * 달수를 더한 날짜를 리턴
     * @param year
     * @param month
     * @param addMonth
     * @return yyyyMM 형식
     */
    public static String getDateAdd(String year, String month, int addMonth) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMM");
		GregorianCalendar cal = new GregorianCalendar(Integer.parseInt(year),Integer.parseInt(month)-1,1);
		cal.add(Calendar.MONTH, addMonth);
		return formatter.format(cal.getTime());
    }
    
    
    
    /**
     * 날짜에 날수를 더함
     * @param date
     * @param addDay
     * @return
     */
    public static Date getDateAddDay(Date date, int addDay){
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(date);
		cal.add(Calendar.DATE, addDay);
		return cal.getTime();
    }
    /**
     * 날짜에 달을 더함
     * @param date
     * @param addMonth
     * @return
     */
    public static Date getDateAddMonth(Date date, int addMonth){
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(date);
		cal.add(Calendar.MONTH, addMonth);
		return cal.getTime();
    }
    
    /**
     * 날짜에 날을 더하거나 빼기_2012/10/12 김현종 추가
     * @param date
     * @param addMonth
     * @return
     * @throws ParseException 
     */
    public static String getDateAddDay(String date, int addDay) throws ParseException{
		GregorianCalendar cal = new GregorianCalendar();

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
		Date newDate2 = format.parse(date);

		cal.setTime(newDate2);
		cal.add(Calendar.DAY_OF_MONTH, addDay);
		
		return format.format(cal.getTime());
    }
    
    /**
     * 날짜에 달을 더하거나 빼기_2012/10/12 김현종 추가
     * @param date
     * @param addMonth
     * @return
     * @throws ParseException 
     */
    public static String getDateAddMonth(String date, int addMonth) throws ParseException{
		GregorianCalendar cal = new GregorianCalendar();

		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd"); 
		Date newDate2 = format.parse(date);

		cal.setTime(newDate2);
		cal.add(Calendar.MONTH, addMonth);
		
		return format.format(cal.getTime());
    }
   
    

    /**
     * 날수를 더한 날짜를 리턴
     * @param year
     * @param month
     * @param day
     * @param addDay
     * @return yyyyMMdd
     */
    public static String getDateAdd(String year, String month, String day, int addDay) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		GregorianCalendar cal = new GregorianCalendar(Integer.parseInt(year),Integer.parseInt(month)-1,Integer.parseInt(day));
		cal.add(Calendar.DATE, addDay);
		return formatter.format(cal.getTime());
    }
    
    /**
     * 달수를 더한 날짜를 리턴
     * @param date
     * @param addMonth
     * @return yyyyMMdd
     */
    public static String getDateAdd(String date, int addMonth) {
    	int year = Integer.parseInt(date.substring(0, 4));
    	int month = Integer.parseInt(date.substring(4, 6));
    	int day = Integer.parseInt(date.substring(6, 8));
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		GregorianCalendar cal = new GregorianCalendar(year, month-1, day);
		cal.add(Calendar.MONTH, addMonth);
		return formatter.format(cal.getTime());
    }
    
    
    /**
     * 시작일부터 종료일까지 사이의 날짜를 배열에 담아 리턴
     * ( 시작일과 종료일을 모두 포함한다 )
     * @author JD_CHOI
     * @param fromDate yyyyMMdd 형식의 시작일
     * @param toDate yyyyMMdd 형식의 종료일
     * @return yyyyMMdd 형식의 날짜가 담긴 배열
     */
    public static String[] getDiffDays(String fromDate, String toDate) {
	     SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	
	     Calendar cal = Calendar.getInstance();
	
	     try {
	    	 cal.setTime(sdf.parse(fromDate));
	     } catch (Exception e) { }
	
	     int count = getDiffDayCount(fromDate, toDate);
	
	     // 시작일부터
	     cal.add(Calendar.DATE, -1);
	
	     // 데이터 저장
	     ArrayList<String> list = new ArrayList<String>();
	
	     for (int i = 0; i <= count; i++) {
	    	 cal.add(Calendar.DATE, 1);
	    	 list.add(sdf.format(cal.getTime()));
	     }
	
	     String[] result = new String[list.size()];
	
	     list.toArray(result);
	
	     return result;
    }
    
    /**
     * 그달의 끝날짜를 구함
     * @param selectMonth
     * @return
     */
    public static int getEndDay(String selectMonth){
    	int endDay = 0;
    	int year = Integer.parseInt(selectMonth.substring(0,4));
    	int month = Integer.parseInt(selectMonth.substring(4,6));
    	
    	 Calendar sday = Calendar.getInstance(); //시스템이 새로 알맞는 시간을 불러들이기 위해 선언
    	  Calendar eday = Calendar.getInstance();//끝
    	  sday.set(year, month - 1, 1);		//1일로 셋팅//0월부터 시작하기때문에 -1 해야함
    	  eday.set(year, month -1, sday.getActualMaximum(Calendar.DATE));
    	  
    	  //그월의 끝날을 구한다.
    	  endDay = eday.get(Calendar.DATE);
    	return endDay;
    }
    
    /**
     * 시작일부터 종료일까지 사이의 선택된 날짜를 배열로 받아서
     * 그사이 선택된날짜를 제외한 날짜를 리턴
     * @author JD_CHOI
     * @param inDate
     * @return emptyDays
     */
    public static String[] getDiffDaysEmpty(String[] inDate, String fromDate, String toDate){
    	
    	String[] fullDays = getDiffDays(fromDate,toDate);
    	String[] emptyDays = new String[fullDays.length];
    	
    	int dayCnt = 0;
    	int arrCnt = 0;
    	
    	if(!isNull(inDate)&&!isNull(fullDays)){
    		for(int i=0;i<fullDays.length;i++){
    			dayCnt=0;
	    		for(int j=0;j<inDate.length;j++){
	    			if(fullDays[i].equals(inDate[j])){
	    				dayCnt++;
	    			}
	    		}
	    		if(dayCnt==0){
	    			emptyDays[arrCnt] = fullDays[i];
	    			arrCnt++;
	    			//System.out.println(":FULLDAYS:::"+fullDays[i]);
	    		}
    		}
    	}
    	
    	return emptyDays;
    }
	/**
	 * 두날짜 사이의 일수를 리턴
	 * @author JD_CHOI
	 * @param fromDate yyyyMMdd 형식의 시작일
	 * @param toDate yyyyMMdd 형식의 종료일
	 * @return 두날짜 사이의 일수
	 */
	public static int getDiffDayCount(String fromDate, String toDate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	
		 try {
			 
			 return (int) ((sdf.parse(toDate).getTime() - sdf.parse(fromDate).getTime()) / 1000 / 60 / 60 / 24);
			 
		 } catch (Exception e) {
			 
			 return 0;
		 }
	}
	/**
	 * 두날짜 사이에 속하는지 여부
	 * @param startDate
	 * @param endDate
	 * @param selectDate
	 * @return
	 */
	public static boolean getBetweenDateFlag(String startDate,String endDate, String selectDate){
		boolean flag = false;
		
		try{
			String betweenDays[] = getDiffDays(startDate,endDate);
			if(!isNull(betweenDays))
				for(int i=0;i<betweenDays.length;i++){
					if(selectDate.equals(betweenDays[i]))	flag = true;
				}
			return flag;
		}catch (Exception e) {
			 return flag;
	    }
	}

    /**
     * 데이트형을 스트링으로 반환한다.
     * @param formatString
     * @param date
     * @return
     */

	public static String getDate2Str(String formatString ,Date date) {
		SimpleDateFormat formatter = new SimpleDateFormat(formatString);
		Date dTime= date;
		return formatter.format(dTime);
	}
	
	/**
	 * 파일 확장자를 소문자로 반환한다.
	 * @param filename
	 * @return
	 */
	public static String getFileExt(String filename){
		String[] fileextSp = filename.split("[.]");
		int fileextSize = fileextSp.length;
		String fileext = fileextSp[(fileextSize-1)];
		return fileext.toLowerCase();
	}	
	
	/**
	 * Map을 정렬후 리턴함
	 * @param map
	 * @return
	 */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public static SortedMap sortMap(Map map){
    	return Collections.synchronizedSortedMap(new TreeMap(map)); 
    }

    /**
     * null을 문자열로 리턴. 좌우공백은 제거
     * @param s
     * @return
     */
    public static String checkNull(String s) {    		
    	return s = (s == null) ? "" : s.trim();
    }
    
    /**
     * null을 문자열로 리턴. 좌우공백은 제거
     * @param s
     * @return
     */
    public static String checkNull(String s, String d) {
    	return s = (s == null) ? d : s.trim();
    }
    /**
     * null을 문자열로 리턴. 좌우공백은 제거
     * @param s
     * @return
     */
    public static int checkNull(String s, int d) {
    	if(s == null)
    		return d;
    	else
    		return Integer.parseInt(s.trim());
    }
    /**
     * null을 문자열로 리턴. 좌우공백은 제거
     * @param s
     * @return
     */
    public static String checkNull(Object s) {
    	if(s == null)
    		return "";
    	else
    		return s.toString().trim();
    }
    /**
     * null을 문자열로 리턴. 좌우공백은 제거
     * @param s
     * @return
     */
    public static String checkNull(Object s, String d) {
    	if(s == null)
    		return d;
    	else
    		return s.toString().trim();
    }
    /**
     * null을 문자열로 리턴. 좌우공백은 제거
     * @param s
     * @return
     */
    public static int checkNull(Object s, int d) {
    	if(s == null)
    		return d;
    	else
    		return Integer.parseInt(s.toString().trim());
    }
    /**
     * 
     * @param s
     * @return
     */
    public static boolean isNull(String s) {
    	return (s == null || "".equals(s.trim()));
    }
    
    /**
     * 
     * @param s
     * @return
     */
    public static boolean isNull(Object obj) {
    	return (obj == null);
    }    
    /**
     * 호스트명을 리턴
     * @param request
     * @return
     */
    public static String getHostUrl(HttpServletRequest request){
    	StringBuffer hostSB = new StringBuffer();
        int port = request.getServerPort();
        if (port == 443) {
        	hostSB.append("https://");
        }else{
        	hostSB.append("http://");
        }
        hostSB.append(request.getServerName());
        if (port != 80 && port != 443) {
            hostSB.append(":").append(port);
        }
        return hostSB.toString();
    }
    
	/**
	 * 오늘의 week정보를 리턴
	 * @return 1(일),..,7(토)
	 */
	public static int getCurWeek(){
		Calendar rightNow = Calendar.getInstance();
		return rightNow.get(Calendar.DAY_OF_WEEK); // 일~토:1~7

	}
	/**
	 * 해당일의 요일정보 리턴
	 * @param sY
	 * @param sM
	 * @param sD
	 * @return 1(일),..,7(토)
	 */
	public static int getSelWeek(String sY, String sM, String sD){
		GregorianCalendar cal = 
			new GregorianCalendar(Integer.parseInt(sY),Integer.parseInt(sM)-1,Integer.parseInt(sD));
		return cal.get(Calendar.DAY_OF_WEEK);
	}

	/**
	 * 선택한 날이 속한 주의 모든 날짜를 가져옴
	 * @param sY
	 * @param sM
	 * @param sD
	 * @return String[7]
	 */
	public static String[] selWeekDayRange(String sY, String sM, String sD){
		String[] sa = new String[7];
		
		//int i = getCurWeek(); // 1~7
		int i = getSelWeek(sY, sM, sD);
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
		
		GregorianCalendar cal = 
			new GregorianCalendar(Integer.parseInt(sY),Integer.parseInt(sM)-1,Integer.parseInt(sD));
		cal.add(Calendar.DAY_OF_MONTH, -i+1); // week First Day
		
		sa[0] = formatter.format(cal.getTime());
		for(int j=1; j<=6; j++){
			cal.add(Calendar.DAY_OF_MONTH, 1);
			sa[j] = formatter.format(cal.getTime());
		}
		
		return sa;
	}

	/**
	 * 랜덤값을 n개만큼 가져옴
	 * @param max 최대값
	 * @param num 가져올 개수
	 * @return int[]
	 */
	public static int[] getRandomIdx(int max, int num) {
		int[] dat = new int[num];
		for(int i=0; i<dat.length; i++)
			dat[i] = -1;
		
		Random ran = new Random();
		int r = 0;
		int n=0;
		boolean dup = false;
		while(n < num){
			r = ran.nextInt(max);
			if(r<0)
				r*=-1;
			dup = false;
			for(int i=0; i<n; i++){
				if(r == dat[i])
					dup = true;
			}
			if(!dup){
				dat[n++] = r;
			}
		}
		
		return dat;
	}
	
	/**
	 * 랜덤한 6자리 숫자값을 생성시킨다
	 * @return
	 */
	public static String getNewRandomValue() {
	  	DecimalFormat df = new DecimalFormat("000000");
	  	return  df.format(Math.random() * 1000000);	
	}
	

	
	/**
	 *
	 * ex)
	 * formatNumber(4, "00"); // 04
	 * @param n
	 * @param formatString
	 * @return
	 */
	public static String formatNumber(int n, String formatString) {
		DecimalFormat form = new DecimalFormat(formatString);
		return form.format(n);
	}

    /**
     * 문자열 앞에 문자를 채운다
     * 
     * @param s
     * @param chr
     *            null이면 "0"으로 변경
     * @param len
     * @return
     */
    public static String leftPad(String s, int len, String chr) {
        if (s == null || "".equals(s))
            return "";
        if (chr == null || "".equals(chr))
            chr = "0";
        if (s.length() >= len)
            return s.substring(0, len);

        for (int i = s.length(); i < len; i++) {
            s = chr + s;
        }
        return s;
    }

    /**
     * 주어진 문자로 길이만큼 채운 후 돌려준다.
     * 
     * @param i
     * @param chr
     *            null이면 "0"으로 변경
     * @param len
     * @return
     */
    public static String leftPad(int i, int len, String chr) {
        return leftPad(i + "", len, chr);
    }

    /**
     * 주어진 문자로 길이만큼 "0"으로 채운 후 돌려준다.
     * 
     * @param s
     * @param len
     * @return
     */
    public static String leftPad(String s, int len) {
        return leftPad(s, len, null);
    }

    /**
     * 주어진 문자로 길이만큼 "0"으로 채운 후 돌려준다.
     * 
     * @param i
     * @param len
     * @return
     */
    public static String leftPad(int i, int len) {
        return leftPad(i + "", len, null);
    }
    /**
     * 달의 마지막날
     * @param Y
     * @param M
     * @return
     */
	public static int getMonthLastDay(String Y, String M){
		int dom[] = {
				31,28,31,30,
				31,30,31,31,
				30,31,30,31
			};
		int yy = Integer.parseInt(Y);
		int mm = Integer.parseInt(M);
		mm--;

		GregorianCalendar cal = new GregorianCalendar(yy,mm,1);
		int daysInMonth = dom[mm];
		if(cal.isLeapYear(cal.get(Calendar.YEAR)) && mm == 1){
			daysInMonth++;
		}
		return daysInMonth;
	}

//	
//    /**
//     * 메일발송
//     * @param fromUser
//     * @param fromUserName
//     * @param toUser
//     * @param subject
//     * @param content
//     */
//	public static void sendMail(String fromUser, String fromUserName, String toUser, String subject, String content, String smtpHost) {
//        try {        	
//    		SimpleMail jsendmail = new SimpleMail();
//    		jsendmail.setSmtpHost(smtpHost);
//    		jsendmail.setFromAddr(fromUser);
//    		jsendmail.setSender(fromUserName);
//    		jsendmail.setContentsType(true);  // true = HTML
//    		jsendmail.setToAddr(toUser);
//    		jsendmail.setSubject(subject);
//    		jsendmail.setContents(content);
//    		jsendmail.send();
//        }catch(Exception e){
//            e.printStackTrace();
//        }
//	}
	
	
//    /**
//     * 메일발송
//     * @param toUser
//     * @param subject
//     * @param content
//     */
//	public static void sendMailEx(String toUser, String subject, String content, String webmasterEmail, String webmasterName, String mailSmtpHost) {
//		try {
//			SimpleMail jsendmail = new SimpleMail();
//			jsendmail.setSmtpHost(mailSmtpHost);
//			jsendmail.setFromAddr(webmasterEmail);
//			jsendmail.setSender(webmasterName);
//			jsendmail.setContentsType(true);  // true = HTML
//			jsendmail.setToAddr(toUser);
//			jsendmail.setSubject(subject);
//			jsendmail.setContents(content);
//			int result = jsendmail.send();
//			if(result==250){
//				System.out.println("메일발송성공:to="+toUser);
//			}else{
//				System.out.println("메일발송실패:to="+toUser);
//			}
//		}catch(Exception e){
//            e.printStackTrace();
//        }
//	}
//	
//	/**
//     * 결과값리턴 메일발송
//     * @param fromUser
//     * @param fromUserName
//     * @param toUser
//     * @param subject
//     * @param content
//     * @return 250 이상없음. 550 오류
//     */
//	public static int sendMailResult(String fromUser, String fromUserName, String toUser, String subject, String content, String mailSmtpHost) {
//		int result = 0;
//        try {
//        	
//    		SimpleMail jsendmail = new SimpleMail();
//    		jsendmail.setSmtpHost(mailSmtpHost);
//    		jsendmail.setFromAddr(fromUser);
//    		jsendmail.setSender(fromUserName);
//    		jsendmail.setContentsType(true);  // true = HTML
//    		jsendmail.setToAddr(toUser);
//    		jsendmail.setSubject(subject);
//			if(toUser.indexOf("nate.com") > -1){
//				jsendmail.setCharset("utf-8");
//			}else{
//				jsendmail.setCharset("euc-kr");
//			}    		
//    		jsendmail.setContents(content);
//    		result = jsendmail.send();
//        }catch(Exception e){
//            e.printStackTrace();
//        }        
//        return result;
//	}
//	
//	
//    /**
//     * 결과값리턴 메일발송
//     * @param toUser
//     * @param subject
//     * @param content
//     * @return 250 이상없음. 550 오류
//     */
//	public static int sendMailResultEx(String toUser, String subject, String content, String smtpServer, String webmasterEmail, String webmasterName) {
//		int result = 0;
//		try {
//			SimpleMail jsendmail = new SimpleMail();
//			jsendmail.setSmtpHost(smtpServer);  
//			jsendmail.setFromAddr(webmasterEmail);
//			jsendmail.setSender(webmasterName);
//			jsendmail.setContentsType(true);  // true = HTML
//			jsendmail.setToAddr(toUser);
//			jsendmail.setSubject(subject);
//			jsendmail.setContents(content);
//			if(toUser.indexOf("nate.com") > -1){
//				jsendmail.setCharset("utf-8");
//			}else{
//				jsendmail.setCharset("euc-kr");
//			}
//			result = jsendmail.send();	
//		}catch(Exception e){
//            e.printStackTrace();
//        }        
//        return result;
//	}
	
	/**

	*	SHA-1 단방향 해쉬 암호화.	

	
	public static String SHA( String param ){
		String password = "";
		try{
			MessageDigest md = MessageDigest.getInstance("SHA-1");
			md.update( param.getBytes("UTF8") );
			byte[] b = md.digest();
			BASE64Encoder encoder = new BASE64Encoder();
			password = encoder.encode( b );
		}catch(Exception e){
			System.out.println(" sha encode error : " + e );
		}
		return password;

	}
	*/
	/**
	 * 이메일 값이 올바른지 체크
	 * @param email
	 * @return
	 */
    public static boolean isEmail(String email) {
        if (email==null) return false;
        
        String thePattern = "[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+";
        Pattern pattern = Pattern.compile(thePattern);
        Matcher match = pattern.matcher(email);
        boolean b = false;
        if (match.find()) {
        	 b = true;
        }
        return b;
    }
	
	/**
	 * 핸드폰 번호가 올바른지 체크 
	 * @param sms
	 * @return
	 */
	public static boolean isSms( String sms ){
        if (sms==null) return false;
        String thePattern = ("01[0|1|6|7|8|9]-[0-9]{3,4}-[0-9]{4}"); 
        Pattern pattern = Pattern.compile(thePattern);
        Matcher match = pattern.matcher(sms);
        boolean b = false;
        if (match.find()) {
        	 b = true;
        }
        return b;
	}
	
	public static boolean isImage( String filename ){
		if(isNull(filename)) filename = "";
		String ext = getFileExt(filename);
		//System.out.println("ext : " + ext);
		return ("gif".equals(ext) || "jpg".equals(ext) || "png".equals(ext) || "bmp".equals(ext) ) ;
	}
	
	/**
	 * OCS 날짜형식으로 반환
	 * yyyymmdd -> yyyy-mm-dd
	 * @param dt
	 * @return
	 */
	public static String toOcsDateFormat(String dt) {
		if(dt.length()==8){
			return dt.substring(0, 4)+"-"+dt.substring(4, 6)+"-"+dt.substring(6, 8);
		}else{
			return dt;
		}
	}
	
	public static String toOcsDateFormatParam(String dt, String kindStr) {
		if(dt.length()==8){
			return dt.substring(0, 4)+kindStr+dt.substring(4, 6)+kindStr+dt.substring(6, 8);
		}else{
			return dt;
		}
	}    
    
    public static String removeTag(String value){
    	String returnVal = value.
    	replaceAll("(?i)<script", "<s_cript").
    	replaceAll("(?i)<iframe", "<i_frame").
    	replaceAll("(?i)</script", "</s_cript").
    	replaceAll("(?i)</iframe", "</i_frame")
    	;    	
    	return returnVal;
    	
    }
    
    /**
     * 체크박스 파라메터 체킹후 여러개일경우 "|" 붙여준다
     * 2012/10/10 김현종 추가
     * @param Array
     * @return Value
     */
    public static String chkBoxCheck(String[] Array){
 
		String Value = "";
		
		if(Array != null){
			for (int i = 0; i < Array.length; i++) {
				if (!"".equals(Value)) Value += "|";
				Value += (String) Array[i];
			}
		}
    	return Value;
    
    }
    
    public static int getYear() {
		return getNumberByPattern("yyyy");
	}
    
    public static int getMonth() {
		return getNumberByPattern("MM");
	}
    
    public static int getDay() {
		return getNumberByPattern("dd");
	}
    
    public static int getNumberByPattern(String pattern) {
		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat (pattern);
		String dateString = formatter.format(new java.util.Date());
		return Integer.parseInt(dateString);
	} 
}
