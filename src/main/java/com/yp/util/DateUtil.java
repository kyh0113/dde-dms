package com.yp.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

public class DateUtil {
	
	public static String getCurrentDateTime() {
        Date today = new Date();
        Locale currentLocale = new Locale("KOREAN", "KOREA");
        String pattern = "yyyy/MM/dd HH:mm:ss";
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
        return formatter.format(today);
    }
	

	
	
	public static String getToday() throws Exception{
		return getCurrentDateTime().substring(0, 10);
	}
	
	public static String getTodayTime() throws Exception{
		return getCurrentDateTime().substring(11);
	}
	
	public static String getTodayMonth() throws Exception{
		return getCurrentDateTime().substring(0, 7);
	}
	
	public static String setDatePattern(String date) throws Exception{
		String year = date.substring(0, 4);
		String month = date.substring(4, 6);
		String day = date.substring(6, 8);
		return year+"/"+month+"/"+day;
	}
	
	//전달 구하기
	public static String getBeforeYearMonthByYM(String yearMonth, int minusVal){
		  SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMM");
		  Calendar cal = Calendar.getInstance();
		  int year = Integer.parseInt(yearMonth.substring(0,4));
		  int month = Integer.parseInt(yearMonth.substring(4,6));

		  cal.set(year, month-minusVal, 0);

		  String beforeYear = dateFormat.format(cal.getTime()).substring(0,4); 
		  String beforeMonth = dateFormat.format(cal.getTime()).substring(4,6); 
		  String retStr = beforeYear + beforeMonth;

		  //System.out.println("retStr : "  + retStr);
		  return retStr;
	}
	
	
	public static String getYesterday(){
		SimpleDateFormat  formatter = new SimpleDateFormat("yyyyMMdd");
		Date today = new Date();
		String date =  formatter.format(today);
		Calendar cal = new GregorianCalendar(Locale.KOREA);
		cal.setTime(today);
		cal.add(Calendar.DATE, -1);
		return formatter.format(cal.getTime());
	}
	
	public static String getYesterday(String date) throws ParseException{
		SimpleDateFormat  formatter = new SimpleDateFormat("yyyyMMdd");
		//Date today = new Date();
		//String date =  formatter.format(today);
		Date setDate = formatter.parse(date);
		
		Calendar cal = new GregorianCalendar(Locale.KOREA);
		cal.setTime(setDate);
		cal.add(Calendar.DATE, -1);
		return formatter.format(cal.getTime());
	}
	
	public static String getSevenDateTime() {
        Date today = new Date();
        Locale currentLocale = new Locale("KOREAN", "KOREA");
        String pattern = "yyyy/MM/dd HH:mm:ss";
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, currentLocale);
    	Calendar cal = Calendar.getInstance();	 
    	cal.setTime(today);	
    	cal.add(Calendar.DATE, 7);
        return formatter.format(cal.getTime());
    }
	
	public static String getSevenDay() throws Exception{
		return getSevenDateTime().substring(0, 10);
	}
}
