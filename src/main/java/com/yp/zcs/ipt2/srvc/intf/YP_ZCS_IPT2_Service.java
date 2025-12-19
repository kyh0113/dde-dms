package com.yp.zcs.ipt2.srvc.intf;

import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface YP_ZCS_IPT2_Service {
	public HashMap<String, Object> select_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int delete_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int merge_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int pre_select_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_confirm_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_cancel_zcs_ipt2_daily_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public HashMap<String, Object> select_zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_aprv_zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_reject_zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int lock_zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int release_zcs_ipt2_daily_aprv1(HttpServletRequest request, HttpServletResponse response) throws Exception;

	public HashMap<String, Object> select_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int delete_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int delete_zcs_ipt2_daily_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int merge_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int merge_zcs_ipt2_daily_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int pre_select_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int pre_select_zcs_ipt2_daily_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_confirm_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_cancel_zcs_ipt2_daily_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_confirm_zcs_ipt2_daily_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_cancel_zcs_ipt2_daily_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public HashMap<String, Object> select_zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_aprv_zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_reject_zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_aprv_zcs_ipt2_daily_aprv2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_reject_zcs_ipt2_daily_aprv2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int lock_zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int release_zcs_ipt2_daily_aprv2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int lock_zcs_ipt2_daily_aprv2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int release_zcs_ipt2_daily_aprv2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception;

	public HashMap<String, Object> select_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int delete_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int merge_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int pre_select_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_confirm_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_cancel_zcs_ipt2_daily_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public HashMap<String, Object> select_zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_aprv_zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int update_reject_zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int lock_zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int release_zcs_ipt2_daily_aprv3(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public HashMap<String, Object> select_zcs_ipt2_month_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int delete_zcs_ipt2_month_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int merge_zcs_ipt2_month_rpt1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public HashMap<String, Object> select_zcs_ipt2_month_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int delete_zcs_ipt2_month_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int delete_zcs_ipt2_month_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int merge_zcs_ipt2_month_rpt2(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int merge_zcs_ipt2_month_rpt2_tag(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	public HashMap<String, Object> select_zcs_ipt2_month_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int delete_zcs_ipt2_month_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception;
	public int merge_zcs_ipt2_month_rpt3(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
