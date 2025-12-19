package com.yp.sap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Properties;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.apache.commons.lang.SystemUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import com.sap.conn.jco.JCoContext;
import com.sap.conn.jco.JCoDestination;
import com.sap.conn.jco.JCoDestinationManager;
import com.sap.conn.jco.JCoException;
import com.sap.conn.jco.JCoField;
import com.sap.conn.jco.JCoFieldIterator;
import com.sap.conn.jco.JCoFunction;
import com.sap.conn.jco.JCoRepository;
import com.sap.conn.jco.JCoTable;
import com.sap.conn.jco.ext.Environment;
import com.vicurus.it.core.common.util.ContextPropUtil;

@Repository
public class SapJcoConnection {

	@Autowired
	@Resource(name = "prop")
	public ContextPropUtil prop;

	private Log logger = LogFactory.getLog(getClass());
	private static String SAP_SERVER = "ABAP_AS_WITH_POOL";
	private static Properties properties = null;
	private JCoRepository repository;
	private JCoDestination destination;
	private static SapJcoConfigure jcoConfig;
	
	@PostConstruct
	void init() {

		logger.info("## sap.hostip : " + prop.get("sap.hostip"));
		logger.info("## sap.systemnumber : " + prop.get("sap.systemnumber"));
		logger.info("## sap.client : " + prop.get("sap.client"));
		logger.info("## sap.user : " + prop.get("sap.user"));
		logger.info("## sap.password : " + prop.get("sap.password"));
		logger.info("## sap.poolCapacity : " + prop.get("sap.poolCapacity"));
		logger.info("## sap.peakLimit : " + prop.get("sap.peakLimit"));

		if (jcoConfig == null) {
			jcoConfig = new SapJcoConfigure();
		}

		jcoConfig.setHostIp(prop.get("sap.hostip"));
		jcoConfig.setSystemNumber(prop.get("sap.systemnumber"));
		jcoConfig.setClient(prop.get("sap.client"));
		jcoConfig.setUser(prop.get("sap.user"));
		jcoConfig.setPassword(prop.get("sap.password"));
		jcoConfig.setPoolCapacity(prop.get("sap.poolCapacity"));
		jcoConfig.setPeakLimit(prop.get("sap.peakLimit"));
		
		properties = new Properties();
		properties.setProperty("jco.client.ashost", jcoConfig.getHostIp());
		properties.setProperty("jco.client.sysnr", jcoConfig.getSystemNumber());
		properties.setProperty("jco.client.client", jcoConfig.getClient());
		properties.setProperty("jco.client.user", jcoConfig.getUser());
		properties.setProperty("jco.client.passwd", jcoConfig.getPassword());
		properties.setProperty("jco.client.lang", jcoConfig.getLang());
		properties.setProperty("jco.destination.pool_capacity", jcoConfig.getPoolCapacity());
		properties.setProperty("jco.destination.peak_limit", jcoConfig.getPeakLimit());
		
	}
	
	/**
	 * 사용하지 않는 오버로딩 
	 * SapJcoConnection(SapJcoConfigure sapJcoConConfig) 메서드는  deprecated
	 * */ 
	// public SapJcoConnection(SapJcoConfigure sapJcoConConfig) {
	// properties = new Properties();
	// try {
	// properties.setProperty("jco.client.ashost", sapJcoConConfig.getHostIp());
	// properties.setProperty("jco.client.sysnr", sapJcoConConfig.getSystemNumber());
	// properties.setProperty("jco.client.client", sapJcoConConfig.getClient());
	// properties.setProperty("jco.client.user", sapJcoConConfig.getUser());
	// properties.setProperty("jco.client.passwd", sapJcoConConfig.getPassword());
	// properties.setProperty("jco.client.lang", sapJcoConConfig.getLang());
	// properties.setProperty("jco.destination.pool_capacity", sapJcoConConfig.getPoolCapacity());
	// properties.setProperty("jco.destination.peak_limit", sapJcoConConfig.getPeakLimit());
	//
	// MyDestinationDataProvider myProvider = new MyDestinationDataProvider();
	// myProvider.changePropertiesForABAP_AS(properties);
	// if (!Environment.isDestinationDataProviderRegistered()) {
	// Environment.registerDestinationDataProvider(myProvider);
	// }
	// this.destination = JCoDestinationManager.getDestination(SAP_SERVER);
	// this.repository = this.destination.getRepository();
	// } catch (JCoException e) {
	// throw new RuntimeException(e);
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }

	public SapJcoConnection() {

		logger.info("## SapJcoConnection ##");
		
		// @PRD sap 운영
		// jcoConfig.setHostIp("211.35.173.43");
		// jcoConfig.setSystemNumber("00");
		// jcoConfig.setClient("100");
		// jcoConfig.setUser("IFGW01");
		// jcoConfig.setPassword("123456");
		// jcoConfig.setLang("ko");

		
		//10/31 주석
		// @DEV sap 개발
//		 jcoConfig.setHostIp("211.35.173.42");
//		 jcoConfig.setSystemNumber("00");
//		 jcoConfig.setClient("700");
//		 jcoConfig.setUser("IFGW01");//IFGW01
//		 jcoConfig.setPassword("123456");//123456
//		 jcoConfig.setLang("ko");

//		 jcoConfig = new SapJcoConfigure();
//		
//		 jcoConfig.setHostIp(prop.get("sap.hostip"));
//		 jcoConfig.setSystemNumber(prop.get("sap.systemnumber"));
//		 jcoConfig.setClient(prop.get("sap.client"));
//		 jcoConfig.setUser(prop.get("sap.user"));
//		 jcoConfig.setPassword(prop.get("sap.password"));
//		 jcoConfig.setPoolCapacity(prop.get("sap.poolCapacity"));
//		 jcoConfig.setPeakLimit(prop.get("sap.peakLimit"));

		if(properties != null){
			try {
				MyDestinationDataProvider myProvider = new MyDestinationDataProvider();
				myProvider.changePropertiesForABAP_AS(properties);
				if (!Environment.isDestinationDataProviderRegistered()) {
					Environment.registerDestinationDataProvider(myProvider);
				}
				this.destination = JCoDestinationManager.getDestination(SAP_SERVER);
				this.repository = this.destination.getRepository();
			} catch (JCoException e) {
				throw new RuntimeException(e);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		
		
	}

	public ArrayList<HashMap<String, String>> createSapList(JCoTable table) {
		ArrayList<HashMap<String, String>> list = new ArrayList();
		HashMap<String, String> row = null;
		if ((table != null) && (table.getNumRows() > 0)) {
			for (int i = 0; i < table.getNumRows(); i++) {
				row = new HashMap();
				table.setRow(i);
				for (JCoFieldIterator e = table.getFieldIterator(); e.hasNextField();) {
					JCoField field = e.nextField();
					// row.put(field.getName(), field.getValue().toString());
					row.put(field.getName(), field.getValue() == null ? "" : field.getValue().toString());
				}
				list.add(row);
			}
		}
		return list;
	}

	public JCoFunction getFunction(String functionName) {
		JCoFunction function = null;
		try {
			function = this.repository.getFunction(functionName);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("Problem retrieving JCO.Function object.");
		}
		if (function == null) {
			throw new RuntimeException("Not possible to receive function. ");
		}
		return function;
	}

	public void execute(JCoFunction function) throws Exception {
		JCoContext.begin(this.destination);
		try {
			function.execute(this.destination);
			if (SystemUtils.IS_OS_WINDOWS) {
				// this.logger.info(function.toXML());
			} else {
				// this.logger.info(function.toXML());
			}
		} catch (Exception e) {
			throw e;
		} finally {
			this.logger.info("RFC END!");
			JCoContext.end(this.destination);
		}
	}
}
