package com.yp.zwc.mst.srvc.intf;

import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZWC_MST_Service {
	public List<HashMap<String, Object>> select_cb_enterprice_gubun(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int zwc_mst_save(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int zwc_mst_delete(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
