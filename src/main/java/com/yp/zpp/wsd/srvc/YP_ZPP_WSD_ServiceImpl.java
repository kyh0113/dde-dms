package com.yp.zpp.wsd.srvc;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.CollectionUtils;
import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoTable;
import com.vicurus.it.core.common.Util;
import com.yp.sap.SapJcoConnection;
import com.yp.util.DateUtil;
import org.springframework.transaction.annotation.Transactional;
import com.yp.zpp.wsd.srvc.intf.YP_ZPP_WSD_Service;

@Repository
public class YP_ZPP_WSD_ServiceImpl implements YP_ZPP_WSD_Service {

    // config.properties 에서 설정 정보 가져오기 시작
    @SuppressWarnings("unused")
    private static String NAMESPACE;

    @SuppressWarnings("static-access")
    @Value("#{config['db.vendor']}")
    public void setNAMESPACE(String value) {
        this.NAMESPACE = value + ".";
    }
    
    @SuppressWarnings("unused")
    private static String FILE_HOME_PATH;
    
    @SuppressWarnings("static-access")
    @Value("#{config['file.uploadDirResource']}")
    public void setFILE_HOME_PATH(String value) {
        this.FILE_HOME_PATH = value;
    }
    // config.properties 에서 설정 정보 가져오기 끝

    @Autowired
    @Resource(name = "sqlSession")
    private SqlSession query;

    private static final Logger logger = LoggerFactory.getLogger(YP_ZPP_WSD_ServiceImpl.class);


    
    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    public HashMap<String, String> zpp_wsd_list(HashMap paramMap) throws Exception{
        HashMap<String, String> result = query.selectOne(NAMESPACE+"yp_zpp.select_zpp_wsd_list", paramMap);
        return result;
    }
    
    
    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    @Transactional
    public String zpp_wsd_create_save(HashMap<String, String> paramMap) throws Exception {
//      ConvertPDF pdf = new ConvertPDF();
//      String fileurl = paramMap.get("uploadPath") + paramMap.get("fileName");
//      HashMap<String,String> result = pdf.Excel2Pdf(fileurl);
//      HashMap<String,String> result = pdf.Excel2Img(fileurl);

        //ConvertPDF2 pdf2 = new ConvertPDF2();
        //HashMap<String,String> result = pdf2.ExcelToPdfByGe(fileurl);
        
        paramMap.put("file_url", paramMap.get("uploadPath").replace(FILE_HOME_PATH, "/uploadFiles/"));
        paramMap.put("file_name", paramMap.get("fileName"));
        paramMap.put("doc_ver", "1.0");
        paramMap.put("pdf_url", paramMap.get("pdf_url").replace(FILE_HOME_PATH, "/uploadFiles/"));
        paramMap.put("pdf_name", paramMap.get("pdf_name"));
        paramMap.put("img_count", paramMap.get("file_count"));
        logger.debug("zpp_wsd_create_save.paramMap="+paramMap);
        
        int rows = query.insert(NAMESPACE+"yp_zpp.zpp_wsd_create_save", paramMap);
        if(rows > 0){
            query.insert(NAMESPACE+"yp_zpp.zpp_wsd_create_version_save", paramMap);
        }
        return "OK";
    }
    
    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    @Transactional
    public String zpp_wsd_update_save(HashMap<String, String> paramMap) throws Exception {
//      ConvertPDF pdf = new ConvertPDF();
//      String fileurl = paramMap.get("uploadPath") + paramMap.get("fileName");
//      HashMap<String,String> result = pdf.Excel2Pdf(fileurl);
//      HashMap<String,String> result = pdf.Excel2Img(fileurl);
        
        paramMap.put("file_url", paramMap.get("uploadPath").replace(FILE_HOME_PATH, "/uploadFiles/"));
        paramMap.put("file_name", paramMap.get("fileName"));
        paramMap.put("doc_ver", paramMap.get("version").replace("Rev.", ""));
        paramMap.put("pdf_url", paramMap.get("pdf_url").replace(FILE_HOME_PATH, "/uploadFiles/"));
        paramMap.put("pdf_name", paramMap.get("pdf_name"));
        paramMap.put("img_count", paramMap.get("file_count"));
        logger.debug("zpp_wsd_update_save.paramMap="+paramMap);
        
        int rows = query.update(NAMESPACE+"yp_zpp.zpp_wsd_update_save", paramMap);
        if(rows > 0){
            query.insert(NAMESPACE+"yp_zpp.zpp_wsd_create_version_save", paramMap);
        }
        return "OK";
    }
    
    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    public List<HashMap<String, String>> zpp_wsd_version_list(HashMap<String, String> paramMap) throws Exception{
        List<HashMap<String, String>> result = query.selectList(NAMESPACE+"yp_zpp.zpp_wsd_version_list", paramMap);
        return result;
    }
    
    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    public HashMap<String, String> zpp_wsd_link(HashMap paramMap) throws Exception{
        HashMap<String, String> result = query.selectOne(NAMESPACE+"yp_zpp.zpp_wsd_link", paramMap);
        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List wsd_edoc_write(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Util util = new Util();
        Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
        logger.debug("@@"+paramMap);
        return query.selectList(NAMESPACE + "yp_zpp.wsd_edoc_write", paramMap);
    }
    
    @SuppressWarnings("rawtypes")
    @Override
    public List wsd_edoc_status(HttpServletRequest request, HttpServletResponse response) throws Exception{
        Util util = new Util();
        Map paramMap = util.getParamToMap(request, true); // 폼에서 날아오는 모든 파라메터 담음(싱글)
        logger.debug("@@"+paramMap);
        return query.selectList(NAMESPACE + "yp_zpp.zpp_wsd_update_status", paramMap);
    }

    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    @Transactional
    public String zpp_ctd_insert_master(HashMap<String, String> paramMap) throws Exception {
        query.insert(NAMESPACE+"yp_zpp.zpp_ctd_insert_master", paramMap);

        return "OK";
    }
    
    @SuppressWarnings("rawtypes")
    @Override
    public List<HashMap<String, String>> zpp_ctd_cathode_list(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ctd_cathode_list");
        logger.debug("@@"+paramMap);

        List<HashMap<String, String>> result = query.selectList(NAMESPACE+"yp_zpp.zpp_ctd_cathode_list", paramMap);
        logger.debug("{}", result.size());

        return result;
    }

    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    public HashMap<String, String> zpp_ctd_envdata(HashMap paramMap) throws Exception{
        HashMap<String, String> result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ctd_envdata", paramMap);
        logger.debug("{}", result);
        return result;
    }

    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    @Transactional
    public String zpp_ctd_insert_envdata(HashMap<String, String> paramMap) throws Exception {
        query.insert(NAMESPACE+"yp_zpp.zpp_ctd_insert_envdata", paramMap);

        return "OK";
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List<HashMap<String, String>> zpp_ctd_graph_list(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ctd_graph_list");
        logger.debug("@@"+paramMap);

        List<HashMap<String, String>> result = query.selectList(NAMESPACE+"yp_zpp.zpp_ctd_graph_list", paramMap);
        logger.debug("{}", result.size());

        return result;
    }

    @Override
    public List<HashMap<String, String>> zpp_wsd_auth_dept_map_code_list(HashMap paramMap) throws Exception {
        return query.selectList(NAMESPACE+"yp_zpp.zpp_wsd_auth_dept_map_code_list", paramMap);
    }

    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    @Transactional
    public String zpp_ore_insert_bl_info(HashMap<String, String> paramMap) throws Exception {
        query.insert(NAMESPACE+"yp_zpp.zpp_ore_insert_bl_info", paramMap);

        return "OK";
    }

    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    @Transactional
    public String zpp_ore_insert_master_info(HashMap<String, String> paramMap) throws Exception {
        query.insert(NAMESPACE+"yp_zpp.zpp_ore_insert_master_info", paramMap);

        return "OK";
    }

    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    @Transactional
    public String zpp_ore_update_bl_info(HashMap<String, String> paramMap) throws Exception {
        query.insert(NAMESPACE+"yp_zpp.zpp_ore_update_bl_info", paramMap);

        return "OK";
    }

    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    @Transactional
    public String zpp_ore_update_master_info(HashMap<String, String> paramMap) throws Exception {
        query.insert(NAMESPACE+"yp_zpp.zpp_ore_update_master_info", paramMap);

        return "OK";
    }

    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    @Transactional
    public String zpp_ore_insert_analysis_result(HashMap<String, String> paramMap) throws Exception {
        query.insert(NAMESPACE+"yp_zpp.zpp_ore_insert_analysis_result", paramMap);

        return "OK";
    }

    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    @Transactional
    public String zpp_ore_update_analysis_result(HashMap<String, String> paramMap) throws Exception {
        query.update(NAMESPACE+"yp_zpp.zpp_ore_update_analysis_result", paramMap);

        return "OK";
    }

    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    @Transactional
    public String zpp_ore_update_state(HashMap<String, String> paramMap) throws Exception {
        query.update(NAMESPACE+"yp_zpp.zpp_ore_update_state", paramMap);

        return "OK";
    }

    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    @Transactional
    public String zpp_ore_insert_init_value(HashMap<String, String> paramMap) throws Exception {
        query.insert(NAMESPACE+"yp_zpp.zpp_ore_insert_init_value", paramMap);

        return "OK";
    }

    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    @Transactional
    public String zpp_ore_update_init_value(HashMap<String, String> paramMap) throws Exception {
        query.update(NAMESPACE+"yp_zpp.zpp_ore_update_init_value", paramMap);

        return "OK";
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List<HashMap<String, String>> zpp_ore_get_init_value(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_get_init_value");
        logger.debug("@@"+paramMap);

        List<HashMap<String, String>> result = query.selectList(NAMESPACE+"yp_zpp.zpp_ore_get_init_value", paramMap);
        logger.debug("{}", result.size());

        return result;
    }
    
    @SuppressWarnings({"unused", "rawtypes"})
    @Override
    @Transactional
    public String zpp_ore_update_adjust_value(HashMap<String, String> paramMap) throws Exception {
        query.update(NAMESPACE+"yp_zpp.zpp_ore_update_adjust_value", paramMap);

        return "OK";
    }

    @SuppressWarnings("rawtypes")
    @Override
    public HashMap<String, String> zpp_ore_get_fixed_value(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_get_fixed_value");
        logger.debug("@@"+paramMap);

        HashMap<String, String> result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_fixed_value", paramMap);
        logger.debug("{}", result.size());

        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int zpp_ore_mt_info_count(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_mt_info_count");
        logger.debug("@@"+paramMap);

        int result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_mt_info_count", paramMap);
        logger.debug("{}", result);

        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public HashMap<String, String> zpp_ore_load_mt_info(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_load_mt_info");
        logger.debug("@@"+paramMap);

        HashMap<String, String> result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_load_mt_info", paramMap);
        logger.debug("{}", result.size());

        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int zpp_ore_component_analysis_info_count(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_component_analysis_info_count");
        logger.debug("@@"+paramMap);

        int result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_component_analysis_info_count", paramMap);
        logger.debug("{}", result);

        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public HashMap<String, String> zpp_ore_load_component_analysis_info(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_load_component_analysis_info");
        logger.debug("@@"+paramMap);

        HashMap<String, String> result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_load_component_analysis_info", paramMap);
        logger.debug("{}", result.size());

        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int zpp_ore_bl_info_count(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_bl_info_count");
        logger.debug("@@"+paramMap);

        int result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_bl_info_count", paramMap);
        logger.debug("{}", result);

        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int zpp_ore_master_info_count(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_master_info_count");
        logger.debug("@@"+paramMap);

        int result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_master_info_count", paramMap);
        logger.debug("{}", result);

        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public HashMap<String, String> zpp_ore_load_bl_info(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_load_bl_info");
        logger.debug("@@"+paramMap);

        HashMap<String, String> result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_load_bl_info", paramMap);
        logger.debug("{}", result.size());

        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int zpp_ore_get_lot_count(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_get_lot_count");
        logger.debug("@@"+paramMap);

        int result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_lot_count", paramMap);
        logger.debug("{}", result);

        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List<HashMap<String, String>> zpp_ore_req_bl_list(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_req_bl_list");
        logger.debug("@@"+paramMap);

        List<HashMap<String, String>> result = query.selectList(NAMESPACE+"yp_zpp.zpp_ore_req_bl_list", paramMap);
        logger.debug("{}", result.size());

        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int zpp_ore_insert_analysis_dmt(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_insert_analysis_dmt");
        logger.debug("@@"+paramMap);
        query.insert(NAMESPACE+"yp_zpp.zpp_ore_insert_analysis_dmt", paramMap);

        return 1;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int zpp_ore_update_analysis_dmt(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_update_analysis_dmt");
        logger.debug("@@"+paramMap);
        query.update(NAMESPACE+"yp_zpp.zpp_ore_update_analysis_dmt", paramMap);

        return 1;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int zpp_ore_update_analysis_yp(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_update_analysis_yp");
        logger.debug("@@"+paramMap);
        query.update(NAMESPACE+"yp_zpp.zpp_ore_update_analysis_yp", paramMap);

        return 1;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public double zpp_ore_get_seller_value(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_get_seller_value");
        logger.debug("@@"+paramMap);

        double res = 0.0;

        try
        {
            res = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_seller_value", paramMap);
        }
        catch (NullPointerException e) {
            res = 0.0;
        }

        return res;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int zpp_ore_set_seller_value(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_set_seller_value");
        logger.debug("@@"+paramMap);
        query.update(NAMESPACE+"yp_zpp.zpp_ore_set_seller_value", paramMap);

        return 1;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public double zpp_ore_get_yp_value(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_get_yp_value");
        logger.debug("@@"+paramMap);

        double res = 0.0;

        try
        {
            res = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_yp_value", paramMap);
        }
        catch (NullPointerException e) {
            res = 0.0;
        }

        return res;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public double zpp_ore_get_dmt_value(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_get_dmt_value");
        logger.debug("@@"+paramMap);

        double res = 0.0;

        try
        {
            res = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_dmt_value", paramMap);
        }
        catch (NullPointerException e) {
            res = 0.0;
        }

        return res;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int zpp_ore_set_yp_action(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_set_yp_action");
        logger.debug("@@"+paramMap);
        query.update(NAMESPACE+"yp_zpp.zpp_ore_set_yp_action", paramMap);

        return 1;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int zpp_ore_set_seller_action(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_set_seller_action");
        logger.debug("@@"+paramMap);
        query.update(NAMESPACE+"yp_zpp.zpp_ore_set_seller_action", paramMap);

        return 1;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String zpp_ore_get_yp_action(HashMap paramMap) throws Exception{
        logger.debug("on zpp_ore_get_yp_action");
        logger.debug("@@"+paramMap);
        String res = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_yp_action", paramMap);

        return res;

    }

    @SuppressWarnings("rawtypes")
    @Override
    public String zpp_ore_get_seller_action(HashMap paramMap) throws Exception{
        logger.debug("on zpp_ore_get_seller_action");
        logger.debug("@@"+paramMap);
        String res = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_seller_action", paramMap);

        return res;

    }

    @SuppressWarnings("rawtypes")
    @Override
    public double zpp_ore_get_settle_value(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_get_settle_value");
        logger.debug("@@"+paramMap);
        double res = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_settle_value", paramMap);

        return res;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public double zpp_ore_get_umpire_value(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_get_umpire_value");
        logger.debug("@@"+paramMap);
        double res = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_umpire_value", paramMap);

        return res;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public double zpp_ore_get_state_value(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_get_state_value");
        logger.debug("@@"+paramMap);
        double res = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_state_value", paramMap);

        return res;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public HashMap<String, String> zpp_ore_get_ar_value(HashMap paramMap) throws Exception {
        HashMap<String, String> result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_ar_value", paramMap);

        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int zpp_ore_set_settle_umpire_value(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_set_settle_umpire_value");
        logger.debug("@@"+paramMap);
        query.update(NAMESPACE+"yp_zpp.zpp_ore_set_settle_umpire_value", paramMap);

        return 1;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int zpp_ore_set_master_split_umpire(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_set_master_split_umpire");
        logger.debug("@@"+paramMap);
        query.update(NAMESPACE+"yp_zpp.zpp_ore_set_master_split_umpire", paramMap);

        return 1;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int zpp_ore_set_master_win_fail(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_set_master_win_fail");
        logger.debug("@@"+paramMap);
        query.update(NAMESPACE+"yp_zpp.zpp_ore_set_master_win_fail", paramMap);

        return 1;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int zpp_ore_update_master_lot_count(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_update_master_lot_count");
        logger.debug("@@"+paramMap);
        query.update(NAMESPACE+"yp_zpp.zpp_ore_update_master_lot_count", paramMap);

        return 1;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List<HashMap<String, String>> zpp_ore_req_master_list(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_req_master_list");
        logger.debug("@@"+paramMap);

        List<HashMap<String, String>> result = query.selectList(NAMESPACE+"yp_zpp.zpp_ore_req_master_list", paramMap);
        logger.debug("{}", result.size());

        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public double zpp_ore_get_ig_avg(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_get_ig_avg");
        logger.debug("@@"+paramMap);
        double res = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_ig_avg", paramMap);

        return res;
    }

    @SuppressWarnings("rawtypes")
	@Override
    public HashMap<String, String> zpp_ore_get_lbl_ig(HashMap paramMap) throws Exception {
		logger.debug("on zpp_ore_get_lbl_ig");
        logger.debug("@@"+paramMap);

        HashMap<String, String> result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_lbl_ig", paramMap);
        logger.debug("{}", result.size());

        return result;
    }

    @SuppressWarnings("rawtypes")
	@Override
    public HashMap<String, String> zpp_ore_get_cps_ig(HashMap paramMap) throws Exception {
		logger.debug("on zpp_ore_get_cpg_ig");
        logger.debug("@@"+paramMap);

        HashMap<String, String> result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_cps_ig", paramMap);
        if(result == null)
        {
        	HashMap<String, String> result2 = new HashMap<String, String>();
        	return result2;
        }
        else
        {
        	logger.debug("{}", result.size());
        	return result;
        }
    }

    @SuppressWarnings("rawtypes")
	@Override
    public String zpp_ore_get_ingredient_name(HashMap paramMap) throws Exception {
		logger.debug("on zpp_ore_get_ingredient_name");
        logger.debug("@@"+paramMap);

        String result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_ingredient_name", paramMap);
        logger.debug("{}", result);

        return result;
    }

    @SuppressWarnings("rawtypes")
	@Override
    public HashMap<String, String> zpp_ore_load_analysis_master(HashMap paramMap) throws Exception {
        logger.debug("on zpp_ore_load_analysis_master");
        logger.debug("@@"+paramMap);

        HashMap<String, String> result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_load_analysis_master", paramMap);
        logger.debug("{}", result.size());

        return result;
    }

    @SuppressWarnings("rawtypes")
	@Override
	public int zpp_ore_delete_analysis_master(HashMap paramMap) throws Exception {
        query.delete(NAMESPACE+"yp_zpp.zpp_ore_delete_analysis_master", paramMap);
        return 1;
    }

    @SuppressWarnings("rawtypes")
	@Override
	public int zpp_ore_delete_analysis_result(HashMap paramMap) throws Exception {
        query.delete(NAMESPACE+"yp_zpp.zpp_ore_delete_analysis_result", paramMap);
        return 1;
    }

    @SuppressWarnings("rawtypes")
	@Override
	public int zpp_ore_delete_bl_info(HashMap paramMap) throws Exception {
        query.delete(NAMESPACE+"yp_zpp.zpp_ore_delete_bl_info", paramMap);
        return 1;
    }

    @SuppressWarnings("rawtypes")
	@Override
	public int zpp_ore_delete_component_analysis(HashMap paramMap) throws Exception {
        query.delete(NAMESPACE+"yp_zpp.zpp_ore_delete_component_analysis", paramMap);
        return 1;
    }

    @SuppressWarnings("rawtypes")
	@Override
	public int zpp_ore_delete_mt_info(HashMap paramMap) throws Exception {
        query.delete(NAMESPACE+"yp_zpp.zpp_ore_delete_mt_info", paramMap);
        return 1;
    }

    @SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, String>> zpp_ore_get_master_list_xls(HashMap paramMap) throws Exception {
        List<HashMap<String, String>> result = query.selectList(NAMESPACE+"yp_zpp.zpp_ore_get_master_list_xls", paramMap);
        return result;
    }

    @SuppressWarnings("rawtypes")
	@Override
    public String zpp_ore_get_material_name(HashMap paramMap) throws Exception {
        String result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_material_name", paramMap);
        return result;
    }

    @SuppressWarnings("rawtypes")
	@Override
    public String zpp_ore_get_seller_name(HashMap paramMap) throws Exception {
        String result = query.selectOne(NAMESPACE+"yp_zpp.zpp_ore_get_seller_name", paramMap);
        return result;
    }

    @SuppressWarnings("rawtypes")
	@Override
	public List<HashMap<String, String>> zpp_ore_req_bl_list_xls(HashMap paramMap) throws Exception {
        List<HashMap<String, String>> result = query.selectList(NAMESPACE+"yp_zpp.zpp_ore_req_bl_list_xls", paramMap);
        return result;
    }

    @SuppressWarnings("rawtypes")
	@Override
    public List<HashMap<String, String>> zpp_ore_get_material_list(HashMap paramMap) throws Exception
    {
        List<HashMap<String, String>> result = query.selectList(NAMESPACE+"yp_zpp.zpp_ore_get_material_list", paramMap);
        return result;
    }

    @SuppressWarnings("rawtypes")
	@Override
    public List<HashMap<String, String>> zpp_ore_get_seller_list(HashMap paramMap) throws Exception
    {
        List<HashMap<String, String>> result = query.selectList(NAMESPACE+"yp_zpp.zpp_ore_get_seller_list", paramMap);
        return result;
    }

    @SuppressWarnings("rawtypes")
	@Override
    public List<HashMap<String, String>> zpp_ore_get_ingredient_list(HashMap paramMap) throws Exception
    {
        List<HashMap<String, String>> result = query.selectList(NAMESPACE+"yp_zpp.zpp_ore_get_ingredient_list", paramMap);
        return result;
    }
}
