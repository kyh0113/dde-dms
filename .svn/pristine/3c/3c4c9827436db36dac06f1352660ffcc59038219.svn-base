
package com.vicurus.it.core.common.util.bean;


/**
 * <p>
 * MethodKey.
 * </p>
 * @author YAME
 * @version $Revision: 001  $Date: 2013-07-01 
 */
public class MethodKey {
    @SuppressWarnings("rawtypes")
	private Class objectClass;
    private String propertyName;
    @SuppressWarnings("rawtypes")
	private Class parameterType;
    private int hashCode;
	
	@SuppressWarnings("rawtypes")
	public MethodKey(Class objectClass, String propertyName) {
	    this(objectClass, propertyName, null);
	}
	
	@SuppressWarnings("rawtypes")
	public MethodKey(Class objectClass, String propertyName, Class parameterType) {
	    this.objectClass = objectClass;
	    this.propertyName = propertyName;
	    this.parameterType = parameterType;
	    this.hashCode = propertyName.hashCode() + objectClass.hashCode()
	            + (null != parameterType ? parameterType.hashCode() : 0);
	}
	
	public boolean equals(Object obj) {
	    boolean result = false;
	    if (obj instanceof MethodKey) {
	        MethodKey other = (MethodKey) obj;
	        if (propertyName.equals(other.propertyName)
	                && objectClass.equals(other.objectClass)) {
	            if (parameterType == null) {
	                result = other.parameterType == null;
                } else if(parameterType.equals(other.parameterType)) {
                    result = true;
                }
	        }
	    }
	
	    return result;
	}
	
	public int hashCode() {
	    return hashCode;
	}
}
