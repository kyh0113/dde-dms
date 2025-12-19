package com.vicurus.it.core.common.util;

/**
 * <p>
 * TypeConvertUtil.
 * </p>
 * @author YAME
 * @version $Revision: 001  $Date: 2013-07-01 
 */
public class TypeConvertUtil {
	
	private static Boolean defaultBoolean = Boolean.FALSE;
	private static Byte defaultByte = new Byte((byte) 0);
	private static Character defaultCharacter = new Character(' ');
	private static Double defaultDouble = new Double((double) 0.0);
	private static Float defaultFloat = new Float((float) 0.0);
	private static Integer defaultInteger = new Integer(0);
	private static Long defaultLong = new Long((long) 0);
	private static Short defaultShort = new Short((short) 0);

	/**
	 * <p>value ��ü�� String������ ��ȯ�� ��ȯ�Ѵ�.</p>
	 * <p>���� value �� null�� ���� null�� ��ȯ�Ѵ�.</p>
	 * 
	 * @param value ��ȯ�� ���ϴ� ��ü
	 * @return ��ȯ�� String ��ü
	 */
	public static String convert(Object value) {
		if (value == null) {
			return null;
		} else {
			return value.toString();
		}
	}

	/**
	 * String���� ���� Class Ÿ������ ��ȯ�� ��ȯ�Ѵ�<p>
	 * �����ϴ� Ÿ���� Integer, Boolean, Double, Short, Float, Long, Character, Byte�̰�, <p>
	 * �ش���� �ʴ� Ÿ���� ��쿡�� String ���� ��ȯ�Ѵ�.
	 * 
	 * @param value ��ȯ�� ��
	 * @param type ��ȯ�Ǵ� Ÿ��
	 * @return ��ȯ�� Ÿ���� ��ü
	 */
	@SuppressWarnings("rawtypes")
	public static Object convert(String value, Class type) {
		if (type == java.lang.String.class) {
			return value;
		} else if(type == java.lang.Integer.class || type == int.class) {
			return convertInteger(value, null);
		} else if(type == java.lang.Boolean.class || type == boolean.class) {
			return convertBoolean(value, null);
		} else if(type == java.lang.Double.class || type == double.class) {
			return convertDouble(value, null);
		} else if(type == java.lang.Short.class || type == short.class) {
			return convertShort(value, null);
		} else if(type == java.lang.Float.class || type == float.class) {
			return convertFloat(value, null);
		} else if(type == java.lang.Long.class || type == long.class) {
			return convertLong(value, null);
		} else if(type == java.lang.Character.class || type == char.class) {
			return convertCharacter(value, null);
		} else if(type == java.lang.Byte.class || type == byte.class) {						
			return convertByte(value, null);
		} else {
			if(value == null) {
				return null;
			} else {
				return value.toString();
			}
		}
	}
	
    /**
     * @param value
     * @param type
     * @param defaultValue
     * @return
     */
    @SuppressWarnings("rawtypes")
	public static Object convert(String value, Class type, Object defaultValue) {
		if (type == java.lang.String.class) {
			return value;
		} else if(type == java.lang.Integer.class || type == int.class) {
			return (defaultValue == null) ? convertInteger(value, null) : convertInteger(value, (Integer)defaultValue);
		} else if(type == java.lang.Boolean.class || type == boolean.class) {
		    return (defaultValue == null) ? convertBoolean(value, null) : convertBoolean(value, (Boolean)defaultValue);
		} else if(type == java.lang.Double.class || type == double.class) {
		    return (defaultValue == null) ? convertDouble(value, null) : convertDouble(value, (Double)defaultValue);
		} else if(type == java.lang.Short.class || type == short.class) {
		    return (defaultValue == null) ? convertShort(value, null) : convertShort(value, (Short)defaultValue);
		} else if(type == java.lang.Float.class || type == float.class) {
			return (defaultValue == null) ? convertFloat(value, null) : convertFloat(value, (Float)defaultValue);
		} else if(type == java.lang.Long.class || type == long.class) {
			return (defaultValue == null) ? convertLong(value, null) : convertLong(value, (Long)defaultValue);
		} else if(type == java.lang.Character.class || type == char.class) {
		    return (defaultValue == null) ?  convertCharacter(value, null) : convertCharacter(value, (Character)defaultValue);
		} else if(type == java.lang.Byte.class || type == byte.class) {						
		    return (defaultValue == null) ?  convertByte(value, null) : convertByte(value, (Byte)defaultValue);
		} else {
			if(value == null) {
				return defaultValue;
			} else {
				return value.toString();
			}
		}
    }	

	@SuppressWarnings({ "rawtypes", "unused" })
	public static Object convert(String values[], Class clazz) {
		Class type = clazz.getComponentType();
		if(type == java.lang.String.class) {
			if(values == null) {
				return null;
			} else {
				return values;
			}
		}
	
		int length = values.length;
		if(type == java.lang.Integer.class) {
			int[] array = new int[length];
			for(int i = 0; i < length; i++) {
				array[i] = convertInteger(values[i], defaultInteger).intValue();
			}
			return array;
		} else if(type == java.lang.Boolean.class) {
			boolean[] array = new boolean[length];
			for(int i = 0; i < length; i++) {
				array[i] = convertBoolean(values[i], defaultBoolean).booleanValue();
			}
			return array;
		} else if(type == java.lang.Double.class) {
			double[] array = new double[length];
			for(int i = 0; i < length; i++) {
				array[i] = convertDouble(values[i], defaultDouble).doubleValue();
			}
			return array;
		} else if(type == java.lang.Short.class) {
			short[] array = new short[length];
			for(int i = 0; i < length; i++) {
				array[i] = convertShort(values[i], defaultShort).shortValue();
			}
			return array;
		} else if(type == java.lang.Float.class) {
			float[] array = new float[length];
			for(int i = 0; i < length; i++) {
				array[i] = convertFloat(values[i], defaultFloat).floatValue();
			}
			return array;
		} else if(type == java.lang.Long.class) {
			long[] array = new long[length];
			for(int i = 0; i < length; i++) {
				array[i] = convertLong(values[i], defaultLong).longValue();
			}
			return array;
		} else if(type == java.lang.Character.class) {
			char[] array = new char[length];
			for(int i = 0; i < length; i++) {
				array[i] = convertCharacter(values[i], defaultCharacter).charValue();
			}
			return array;
		} else if(type == java.lang.Byte.class) {						
			byte[] array = new byte[length];
			for(int i = 0; i < length; i++) {
				array[i] = convertByte(values[i], defaultByte).byteValue();
			}
			return array;
		} else {
			if(values == null) {
				return null;
			} else {
				String[] array = new String[length];
				for(int i = 0; i < length; i++) {
					array[i] = values[i].toString();
				}
				return array;
			}
		}		
	}

	

	/**
	 * Boolean -> String
	 * @param value
	 * @return
	 */
	public static String convertString(Boolean value) {
		return convertString(value.booleanValue());
	}

	/**
	 * boolean -> String
	 * @param value
	 * @return
	 */
	public static String convertString(boolean value) {
		return convertString(value, "Y", "N");
	}

	/**
	 *  boolean���� ���� String������ ��ȯ�Ѵ�
	 * 
	 * @param value boolean���� ��
	 * @param trueValue true�϶� ��ȯ�� String ��
	 * @param falseValue false�ϴ� ��ȯ�� String ��
	 * @return �ش��ϴ� boolean���� String���� ��ȯ�Ѵ٤� 
	 */
	public static String convertString(boolean value, String trueValue, String falseValue) {
		if (value) {
			return trueValue;
		} 
		return falseValue;
	}






	//

	/**
	 * String ���� boolean������ ��ȯ�� ��ȯ�Ѵ�.
	 */
	public static boolean convertBoolean(String value, boolean defaultValue) {
		return convertBoolean(value, new Boolean(defaultValue)).booleanValue();
	}

	/**
	 * String ���� boolean������ ��ȯ�� ��ȯ�Ѵ�.
	 */
	public static boolean convertBoolean(String value, boolean defaultValue, String trueString) {
		return convertBoolean(value, new Boolean(defaultValue), trueString).booleanValue();
	}
	
	/**
	 * String ���� Boolean������ ��ȯ�� ��ȯ�Ѵ�.<p>
	 * ���� String ���� yes, true, on, y�϶��� true������,<p>
	 * no, false, off, n�϶��� false������ ��ȯ�ȴ�.<p>
	 * �� ���� �� �ش���� �������� �⺻������ ��ȯ�ȴ�.
	 * 
	 * @param value �� ��
	 * @param defaultValue �⺻��
	 * @return Boolean ��
	 */
	public static Boolean convertBoolean(String value, Boolean defaultValue) {
		if (value == null) 	{
			return defaultValue;
		} else if (value.equalsIgnoreCase("yes") ||
						value.equalsIgnoreCase("true") ||
						value.equalsIgnoreCase("on") ||
						value.equalsIgnoreCase("y") ) {
			return Boolean.TRUE;
		} else if(value.equalsIgnoreCase("no") ||
						value.equalsIgnoreCase("false") ||
						value.equalsIgnoreCase("off") ||
						value.equalsIgnoreCase("n") ) {
			return Boolean.FALSE;
		} else {
			return defaultValue;
		}
	}

	/**
	 * String -> Boolean
	 * @param value
	 * @param defaultValue
	 * @param trueString
	 * @return
	 */
	public static Boolean convertBoolean(String value, Boolean defaultValue, String trueString) {
		if (value == null) 	{
			return defaultValue;
		} else if (value.equalsIgnoreCase(trueString)) {
			return Boolean.TRUE;
		} else {
			return defaultValue;
		}
	}
	/**
	 * String -> byte
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static byte convertByte(String value, byte defaultValue) {
		return convertByte(value, new Byte(defaultValue)).byteValue();
	}

	/**
	 * String -> Byte
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static Byte convertByte(String value, Byte defaultValue) {
		try {
			return new Byte(value);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
	/**
	 * String -> char
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static char convertChar(String value, char defaultValue) {
		return convertCharacter(value, new Character(defaultValue)).charValue();		
	}

	/**
	 * String -> char
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static char convertCharacter(String value, char defaultValue) {
		return convertChar(value, defaultValue);
	}

	/**
	 * String -> Character
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static Character convertCharacter(String value, Character defaultValue) {
		if(value == null || value.length() == 0) {
			return defaultValue;
		} else {
			return new Character(value.charAt(0));
		}
	}

	/**
	 * String -> int
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static int convertInt(String value, int defaultValue) {
		return convertInteger(value, new Integer(defaultValue)).intValue();
	}
	/**
	 * Object -> int
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static int convertInt(Object value, int defaultValue) {
	    int result = defaultValue;
	    if (value != null) {
		    if (value instanceof Integer) {
		        result = ((Integer)value).intValue();
		    } else {
		        result = convertInteger(value.toString(), new Integer(defaultValue)).intValue();
		    }	        
	    }
		return result;
	}
	/**
	 * String[] -> int[]
	 * @param valueArray
	 * @param defaultValue
	 * @return
	 */
	public static int[] convertInt(String[] valueArray, int defaultValue) {
	    int[] result = null;
	    if (valueArray != null) {
	        result = new int[valueArray.length];
	        for (int i = 0; i < valueArray.length; i++) {
	            result[i] = convertInteger(valueArray[i], new Integer(defaultValue)).intValue();
	        }
	    }
		return result;
	}

	/**
	 * String -> int
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static int convertInteger(String value, int defaultValue) {
		return convertInt(value, defaultValue);
	}

	/**
	 * String -> Integer
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static Integer convertInteger(String value, Integer defaultValue) {
        if (value == null) {
            return defaultValue;
        }
		try {
			return new Integer(value);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}

	/**
	 * String -> double
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static double convertDouble(String value, double defaultValue) {
		return convertDouble(value, new Double(defaultValue)).doubleValue();
	}
	/**
	 * String -> Double
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static Double convertDouble(String value, Double defaultValue) {
        if (value == null) {
            return defaultValue;
        }
		try {
			return new Double(value);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
	/**
	 * String -> float
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static float convertFloat(String value, float defaultValue) {
		return convertFloat(value, new Float(defaultValue)).floatValue();
	}
	/**
	 * String -> Float
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static Float convertFloat(String value, Float defaultValue) {
        if (value == null) {
            return defaultValue;
        }
		try {
			return new Float(value);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}
	/**
	 * String -> long
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static long convertLong(String value, long defaultValue) {
		return convertLong(value, new Long(defaultValue)).longValue();
	}
	/**
	 * String -> Long
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static Long convertLong(String value, Long defaultValue) {
        if (value == null) {
            return defaultValue;
        }
		try {
			return new Long(value);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}	
	/**
	 * String -> short
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static short convertShort(String value, short defaultValue) {
		return convertShort(value, new Short(defaultValue)).shortValue();
	}

	/**
	 * String -> Short
	 * @param value
	 * @param defaultValue
	 * @return
	 */
	public static Short convertShort(String value, Short defaultValue) {
        if (value == null) {
            return defaultValue;
        }
		try {
			return new Short(value);
		} catch (NumberFormatException e) {
			return defaultValue;
		}
	}



}
