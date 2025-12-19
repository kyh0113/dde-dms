package com.vicurus.it.core.common.util;

import java.beans.BeanInfo;
import java.beans.IntrospectionException;
import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import com.vicurus.it.core.common.util.bean.MethodKey;

/**
 * <p>
 * BeanUtil.
 * </p>
 * @author YAME
 * @version $Revision: 001  $Date: 2013-07-01 
 */
public class BeanUtil {

    @SuppressWarnings("rawtypes")
	private static Map writeMethodMap = new HashMap();
    @SuppressWarnings("rawtypes")
	private static Map readMethodMap = new HashMap();

	
	@SuppressWarnings("rawtypes")
	public static void setDeclaredFieldValue(Object object, String name, String value) throws SecurityException, IllegalArgumentException, NoSuchFieldException, IllegalAccessException {
		Class clazz = object.getClass();
		Field field = clazz.getDeclaredField(name);
		Class type = field.getType();
		if (type == boolean.class) {
			field.setBoolean(object, TypeConvertUtil.convertBoolean(value, false));
		} else if (type == byte.class) {
			field.setByte(object, TypeConvertUtil.convertByte(value, (byte)0));
		} else if (type == char.class) {
			field.setChar(object, TypeConvertUtil.convertChar(value, ' '));
		} else if (type == double.class) {
			field.setDouble(object, TypeConvertUtil.convertDouble(value, 0));
		} else if (type == float.class) {
			field.setFloat(object, TypeConvertUtil.convertFloat(value, 0));
		} else if (type == int.class) {
			field.setInt(object, TypeConvertUtil.convertInt(value, 0));
		} else if (type == long.class) {
			field.setLong(object, TypeConvertUtil.convertLong(value, 0));
		} else if (type == short.class) {
			field.setShort(object, TypeConvertUtil.convertShort(value, (short)0));
		} else {
			field.set(object, value);
		}
	}
	

	@SuppressWarnings("rawtypes")
	public static void setDeclaredFieldValue(Object object, String name, Object value) throws SecurityException, IllegalArgumentException, NoSuchFieldException, IllegalAccessException {
		Class clazz = object.getClass();
		Field field = clazz.getDeclaredField(name);
		field.set(object, value);
	}


	@SuppressWarnings("rawtypes")
	public static void setFieldValue(Object object, String name, Object value) throws SecurityException, IllegalArgumentException, NoSuchFieldException, IllegalAccessException {
		Class clazz = object.getClass();
		Field field = clazz.getField(name);
		field.set(object, value);
	}

	

    @SuppressWarnings("rawtypes")
	public static boolean isEquals(Class[] types0, Class[] types1) {
        boolean result = false;
        if (types0 == null) {
            if (types1 == null) {
                result = true;
            }
        } else {
            if (types1 != null && types0.length == types1.length) {
                result = true;
                for (int i = 0; i < types0.length; i++) {
                    if (!types0[i].equals(types1[i])) {
                        result = false;
                        break;
                    }
                }
            }
        }
        return result;
    }

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static Method getWriteMethod(Class objectClass, String propertyName) throws IntrospectionException, NoSuchMethodException {
	    Method method = null;
	    MethodKey key = new MethodKey(objectClass, propertyName);
	    method = (Method)writeMethodMap.get(key);
	    if (method == null) {
	        BeanInfo info = Introspector.getBeanInfo(objectClass);
	        PropertyDescriptor[] pd = info.getPropertyDescriptors();
	        if (pd != null) {
	            for (int i = 0; i < pd.length; i++) {
                    if (propertyName.equals(pd[i].getName())) {
                        method = pd[i].getWriteMethod();
                        break;
                    } else {
                        String tName = new StringBuffer().append(propertyName.substring(0, 1).toUpperCase()).append(propertyName.substring(1)).toString();
                        if (tName.equals(pd[i].getName())) {
                            method = pd[i].getWriteMethod();
                            break;                            
                        }
                    }
	            }
	        }
	        if (method == null) {
	            String methodName = new StringBuffer("set").append(propertyName.substring(0, 1).toUpperCase()).append(propertyName.substring(1)).toString(); 
	            method = objectClass.getMethod(methodName, null);
	        }
	        if (method == null) {
	            throw new NoSuchMethodException(new StringBuffer(objectClass.getName()).append("Ŭ������ set").append(propertyName.substring(0, 1).toUpperCase()).append(propertyName.substring(1)).append(" �޼ҵ带 ã�� �� ����ϴ�.").toString());
	        }
	        writeMethodMap.put(key, method);
	        
	    }
	    return method;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static Method getReadMethod(Class objectClass, String propertyName) throws IntrospectionException, NoSuchMethodException {
	    Method method = null;
	    MethodKey key = new MethodKey(objectClass, propertyName);
	    method = (Method)readMethodMap.get(key);
	    if (method == null) {
	        BeanInfo info = Introspector.getBeanInfo(objectClass);
	        PropertyDescriptor[] pd = info.getPropertyDescriptors();
	        if (pd != null) {
	            for (int i = 0; i < pd.length; i++) {
                    if (propertyName.equals(pd[i].getName())) {
                        method = pd[i].getReadMethod();
                        break;
                    }
	            }
	        }
	        if (method == null) {
	            String methodName = new StringBuffer("get").append(propertyName.substring(0, 1).toUpperCase()).append(propertyName.substring(1)).toString(); 
	            method = objectClass.getMethod(methodName, null);
		        if (method == null) {
		            methodName = new StringBuffer("is").append(propertyName.substring(0, 1).toUpperCase()).append(propertyName.substring(1)).toString(); 
		            method = objectClass.getMethod(methodName, null);
		        }
	        }
	        if (method == null) {
	            throw new NoSuchMethodException(new StringBuffer(objectClass.getName()).append("Ŭ������ get").append(propertyName.substring(0, 1).toUpperCase()).append(propertyName.substring(1)).append(" �޼ҵ带 ã�� �� ����ϴ�.").toString());
	        }
	        readMethodMap.put(key, method);
	        
	    }
	    return method;
	}

	public static void setMethodValue(Object object, String propertyName, Object value) throws IllegalArgumentException, IntrospectionException, NoSuchMethodException, IllegalAccessException, InvocationTargetException {
        Method setter = getWriteMethod(object.getClass(), propertyName);
        if(setter != null) {
            setter.invoke(object, new Object[] { value });    
        }
	}

	public static void setMethodValue(Object object, String propertyName, Object[] values) throws NoSuchFieldException, NoSuchMethodException, IllegalArgumentException, IntrospectionException, IllegalAccessException, InvocationTargetException {
		Method setter = getWriteMethod(object.getClass(), propertyName);
		if(setter != null) {
			setter.invoke(object, values);			
		}
	}

	public static Object getMethodValue(Object object, String propertyName) throws IllegalArgumentException, IntrospectionException, NoSuchMethodException, IllegalAccessException, InvocationTargetException {
		Object result = null;
        
        if (object != null) {
            int dotIndex = propertyName.indexOf('.');
            if (dotIndex > -1) {
                String varName1 = propertyName.substring(0, dotIndex);
                String varName2 = propertyName.substring(dotIndex+1);
                
                Method getter = getReadMethod(object.getClass(), varName1);
                if(getter != null) {
                    Object value1 =  getter.invoke(object, null);
                    result = getMethodValue(value1, varName2);  
                }            
            } else {
                Method getter = getReadMethod(object.getClass(), propertyName);
                if(getter != null) {
                    result =  getter.invoke(object, null);          
                }            
            } 
        }

		return result;		
	}

	@SuppressWarnings("rawtypes")
	public static Class getType(Object object, String propertyName) throws SecurityException, NoSuchFieldException {
		Class result = null;
		Field field = object.getClass().getDeclaredField(propertyName);
		result = field.getType();
		return result;		
	}	

	@SuppressWarnings("rawtypes")
	public static Object newInstance(String className) throws ClassNotFoundException, InstantiationException, IllegalAccessException {
		Class clazz = Class.forName(className);
		return clazz.newInstance();
	}	

}
