package com.yp.sap;

import com.sap.conn.jco.ext.DestinationDataEventListener;
import com.sap.conn.jco.ext.DestinationDataProvider;
import java.util.Properties;

public class MyDestinationDataProvider
  implements DestinationDataProvider
{
  private DestinationDataEventListener eventListener;
  private Properties ABAP_AS_properties;
  
  public Properties getDestinationProperties(String arg0)
  {
    return this.ABAP_AS_properties;
  }
  
  public void setDestinationDataEventListener(DestinationDataEventListener eventListener)
  {
    this.eventListener = eventListener;
  }
  
  public boolean supportsEvents()
  {
    return true;
  }
  
  public void changePropertiesForABAP_AS(Properties properties)
  {
    if (properties == null)
    {
      this.eventListener.deleted("ABAP_AS_WITH_POOL");
      this.ABAP_AS_properties = null;
    }
    else
    {
      if ((this.ABAP_AS_properties != null) && (!this.ABAP_AS_properties.equals(properties))) {
        this.eventListener.updated("ABAP_AS_WITH_POOL");
      }
      this.ABAP_AS_properties = properties;
    }
  }
}