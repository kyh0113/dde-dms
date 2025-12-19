package com.vicurus.it.core.viewResolver;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.view.AbstractView;

import com.vicurus.it.core.common.Util;


/**
 * <p>GridToJSON.</p>
 */
public class GridToJSON extends AbstractView {
	private static final Logger logger = LoggerFactory.getLogger(GridToJSON.class);
	private PrintWriter out;
	
	@Override
	protected void renderMergedOutputModel(Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			Util util = new Util();
			response.setContentType("text/plain;charset=UTF-8");//json
			out = response.getWriter();
			String createjson = createJson((HashMap<String, Object>)map); 
			
			//20191026_khj XSS 필터적용
			createjson = util.XSSFilter(createjson);
			
//			logger.debug("GridJSONPasing: {}", createjson);
			out.println(createjson);
		} catch(Throwable e) {
			logger.error(e.getMessage());
			e.printStackTrace();
		}finally{
			out.flush();
			out.close();
		}
	}
	
	//데이터를 JSON으로 파싱하여 내보낸다 JSON 규칙은 아래 사이트 참조
	//http://ashwinrayaprolu.wordpress.com/2011/05/24/struts2-json-jqgrid-with-annotations/
	//JSON 라이브 러리를 사용할 수 없는 이유는 jqGrid 형식대로 json 데이터를 만들려면 커스텀 해서 만들어 내야 한다..	
	private String createJson(HashMap<String, Object> map) throws Exception{
		StringBuilder sb  = new StringBuilder();
		sb.append("{");
			sb.append("\"").append("page").append("\"").append(":").append("\"").append(map.get("page").toString()).append("\",");
			sb.append("\"").append("total").append("\"").append(":").append("\"").append(map.get("total_page").toString()).append("\",");
			sb.append("\"").append("records").append("\"").append(":").append("\"").append(map.get("count").toString()).append("\",");
			sb.append("\"").append("rows").append("\"").append(":").append("[").append(createBodyJSON(map)).append("]");
		sb.append("}");
		return sb.toString();
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private String createBodyJSON(HashMap<String, Object> map) throws Exception {
		StringBuilder sb = new StringBuilder();
		ArrayList<HashMap> dataList = (ArrayList<HashMap>)map.get("dataList");
		int maxSize = dataList.size();
		for(int i = 0; i < maxSize; i++){
			sb.append("{");
					//sb.append("'id'").append(":'").append(i).append("','cell':[");
					////여기서 부터 데이터를 파싱해서 넣어줘야 한다..
					HashMap mapData = dataList.get(i);//데이터를 추출해온다
					Iterator<String> iter = mapData.keySet().iterator();
					while(iter.hasNext()){
						//HashMap에 들어있는 키값과 Value 값을 가지고 JSON 데이터로 파싱
						String key = iter.next();
						String value = "";
						if(mapData.get(key) != null){
							value = mapData.get(key).toString(); // 원코딩
							value = mapData.get(key).toString().replaceAll("\"", "\\\\\""); // double quote 데이타 들어올때.
							//System.out.println("JSON2 결과?"+value);
						}
						/*
						if(iter.hasNext() == true){
							sb.append("'").append(value).append("',");
						}else{
							sb.append("'").append(value).append("'");
						}
						*/
						sb.append("\"").append(key).append("\":");
						if(iter.hasNext() == true){
							sb.append("\"").append(value).append("\",");
						}else{
							sb.append("\"").append(value).append("\"");
						}
					}
					//sb.append("]");
			if(i != (maxSize-1)){
				sb.append("},");
			}else{
				sb.append("}");
			}
		}
		return sb.toString();
	}
}