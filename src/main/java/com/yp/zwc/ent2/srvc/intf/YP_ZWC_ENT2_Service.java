package com.yp.zwc.ent2.srvc.intf;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZWC_ENT2_Service {
	public ArrayList<HashMap<String, String>> xls_zwc_ent2_data_search(HashMap paramMap) throws Exception;
}
