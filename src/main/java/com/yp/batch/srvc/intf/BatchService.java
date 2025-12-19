package com.yp.batch.srvc.intf;


public interface BatchService {
	
	public void retrieveSalary(String sabun, String yyyymm) throws Exception;
	
	public void batchSAP() throws Exception;

	public void batchSyncTimecard(String yesterday) throws Exception;

	public void batchSeokpoSoneData(String today) throws Exception;
	
	public void batchBonsaCapsData(String today) throws Exception;
	
	public void batchAnsanCapsData(String today) throws Exception;

	public void batchWorkingBIData(String yesterday) throws Exception;
	
	public void sapTransferEmoInfo() throws Exception;

	/** 
	 * YPWEBPOTAL-27 ENT_CODE 코드 앞의 0삭제 건
	 * 배치 > TBL_WEIGHT_DATA 의 ENT_CODE 필드의 코드 변경
	 * 
	 * 10자리일경우에 6자리로 변경하는데 앞에 0이 포함되어있을경우에만 해당한다.
	 * 
	 * 05:00 (매일 1회)
	 */
	public void setWeightTableEntCodeFieldReplaceData() throws Exception;
	
	public void batchMSSQLData() throws Exception;

	public void batchInsertDate() throws Exception;
	
}

