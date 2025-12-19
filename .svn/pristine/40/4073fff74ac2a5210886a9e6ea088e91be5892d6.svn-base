package com.vicurus.it.core.common.util;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;


/**
 * <p>
 * String Util.
 * </p>
 * @author YAME
 * @version $Revision: 001  $Date: 2013-07-01 
 */
public class StringUtil {
	private StringUtil() {
	}
	
	/**
	 * null�Ǵ� ���ڿ� ����
	 * @param s
	 * @return
	 */
	public static boolean isEmpty(String s) {
		return s==null || "".equals(s.trim()) ? true : false;
	}
	
	/**
	 * null���� blank�� ��ȯ
	 * @param s
	 * @return
	 */
	public static String toBlank(String s) {
		return s==null ? "" : s.trim();
	}
	
	/**
	 * ���ڿ��� ��ȯ�Ѵ�.
	 * @param text
	 * @param oldChar
	 * @param newChar
	 * @return
	 */
    public static String replaceAll(String text, String oldChar, String newChar) {
        String newText = text;
        if (text != null) {
            StringBuffer sb = new StringBuffer((int)(text.length() * 1.5));
            int index = 0;
            while ( (index = text.indexOf(oldChar)) > -1) {
                sb.append(text.substring(0, index));
                sb.append(newChar);
                if (index + oldChar.length() < text.length()) {
                    text = text.substring(index + oldChar.length());    
                } else {
                    text = "";
                    break;
                }
            }
            sb.append(text);
            newText = sb.toString();
            
        }
        return newText;
    }

	/**
	 * ���̸� �ʰ��ϴ� ���ڿ��� ���̸�ŭ �ڸ��� �������ڿ��� ���δ�.
	 * 
	 * @param source �� ���ڿ�
	 * @param length �ִ� ����
	 * @param tail �������ڿ�
	 * @param charset ���ڼ�
	 * @return ���̸�ŭ �߶��� ���ڿ�
	 */
	public static String crop(String source, int length, String tail, String charset) throws UnsupportedEncodingException {
		if (source == null) return null;
		String result = source;
		int sLength = 0;
		int bLength = 0;
		char c;
		
		if ( result.getBytes(charset).length > length) {
		    length = length - tail.length();
			while ( (bLength + 1) <= length) {
				c = result.charAt(sLength);
				bLength++;
				sLength++;
				if (c > 127) bLength++;
			}
			result = result.substring(0, sLength) + tail;
		}
		return result;
	}
	
	/**
	 * ���̸� �ʰ��ϴ� ���ڿ��� ���̸�ŭ �ڸ��� �������ڿ��� ���δ�.
	 * 
	 * @param source �� ���ڿ�
	 * @param length �ִ� ����
	 * @param tail �������ڿ�
	 * @return ���̸�ŭ �߶��� ���ڿ�
	 */
	public static String crop(String source, int length, String tail) {
		if (source == null) return null;
		
		String result = source;
		int sLength = 0;
		int bLength = 0;
		char c;
		
		if ( result.getBytes().length > length) {
		    length = length - tail.length();
			while ( (bLength + 1)  <= length) {
				c = result.charAt(sLength);
				bLength++;
				sLength++;
				if (c > 127) bLength++;
			}
			result = result.substring(0, sLength) + tail;
		}
		return result;
		
	}
	/**
	 * html�±׷� �̷���� ��� �±׸� ������ ���ڿ����� ���̸�ŭ �ڸ� �� �������ڿ��� ���δ�
	 * @param str
	 * @param length
	 * @param tail
	 * @return
	 */
	public static String htmlCrop(String str, int length, String tail) {
		StringBuffer result = new StringBuffer();

		int remain = length;
		int position = 0;
		int bIndex = -1;
		int eIndex = -1;
		String temp = str;
		
		while (position < temp.length()) {
			bIndex = temp.indexOf("<");
			eIndex = temp.indexOf(">", bIndex);
			
			if (bIndex > -1) {
				if (remain > 0) {
					result.append(crop(temp.substring(0, bIndex), remain, tail));
				}
				if (bIndex < eIndex) {
					position = eIndex + 1;
					result.append(temp.substring(bIndex, position));
					temp = temp.substring(position);
				} else {
					if (remain > 0) {
						result.append(crop(temp, remain, tail));
						temp = "";
					}
				}	
			} else {
				if (remain > 0) {
					result.append(crop(temp, remain, tail));
						temp = "";
				}
				position = temp.length();
			}
		}

		if (remain > 0) {
			result.append(crop(temp, remain, tail));
		}
		
		return result.toString();
	}
	
	/**
	 * �����ڷ� ������ ���ڿ��� ���ڹ迭�� ��ȯ�Ѵ�.
	 * 
	 * @param str ���ڿ�
	 * @param delimiter ������
	 */
	public static String[] toStringArray(String str, String delimiter) {
        String[] result = null;
        if (str != null) {
            Tokenizer t = new Tokenizer(str, delimiter);
            result = new String[t.countTokens()];
            for( int i = 0; t.hasMoreTokens(); i++) {
                result[i] = t.nextToken();
            }            
        }
		return result;
	}
	
	/**
	 * �����ڷ� ������ ���ڿ��� ����(int)�迭�� ��ȯ�Ѵ�.<p>
	 * �߸�� ������ ��� �⺻������ ��ȯ�ȴ�.
	 * 
	 * @param str ���ڿ�
	 * @param delimiter ������
	 * @param defaultIntValue �⺻��
	 * @return
	 */
	public static int[] toIntArray(String str, String delimiter, int defaultIntValue) {
		Tokenizer t = new Tokenizer(str, delimiter);
		int[] result = new int[t.countTokens()];
		for( int i = 0; t.hasMoreTokens(); i++) {
			result[i] = TypeConvertUtil.convertInt(t.nextToken(), defaultIntValue);
		}
		return result;
	}
	
	
	/**
	 * ���ڿ��� charset���� ���ڵ�
	 * @param s ��� ���ڿ�
	 * @param curCharset s�� charset
	 * @param toCharset ��ȯ�� charset
	 * @return
	 */
	public static String encode(String s, String curCharset, String toCharset) {
		if (curCharset == null || toCharset==null) return s;
		String out = null;
		if (s == null ) return null;
		
		try { 
			out = new String(s.getBytes(curCharset), toCharset);
		} 	catch(UnsupportedEncodingException ue) {
			out = new String(s);
		}
		return out;
	}
	


	/**
	 * ���ڿ�(8859_1)�� ������ character encoding ���� ��ȯ�Ѵ�.
	 * @param s ��� ���ڿ�
	 * @param charset encoding charset
	 */
	public static String encode(String s, String charset) 	{
		if (charset == null || "8859_1".equals(charset)) return s;
		String out = null;
		if (s == null ) return null;
		
		try { 
			out = new String(s.getBytes("8859_1"), charset);
		} 	catch(UnsupportedEncodingException ue) {
			out = new String(s);
		}
		return out;
	}	

	

	/**
	 * ���ڿ��� 8859_1�� ���ڵ��Ѵ�.
	 * @param s ��� ���ڿ�
	 * @param charset
	 * @return
	 */
	public static String decode(String s, String charset) 	{
		if (charset == null || "8859_1".equals(charset)) return s;
		String out = null;
		if (s == null ) return null;
		try { 
			out = new String(s.getBytes(charset), "8859_1");
		} 	catch(UnsupportedEncodingException ue) {
			out = new String(s);
		}
		return out;
	}

	
	/**
	 * 
	 * ex)
	 * formatNumber("4", "00"); // 04
	 * @param n
	 * @param formatString
	 * @return
	 */
	public static String formatNumber(String n, String formatString) {
		return formatNumber(TypeConvertUtil.convertInteger(n,0), formatString);
	}
	/**
	 *
	 * ex)
	 * formatNumber(4, "00"); // 04
	 * @param n
	 * @param formatString
	 * @return
	 */
	public static String formatNumber(int n, String formatString) {
		DecimalFormat form = new DecimalFormat(formatString);
		return form.format(n);
	}

    /**
     * ���ڿ� �տ� ���ڸ� ä���
     * 
     * @param s
     * @param chr
     *            null�̸� "0"���� ����
     * @param len
     * @return
     */
    public static String leftPad(String s, int len, String chr) {
        if (s == null || "".equals(s))
            return "";
        if (chr == null || "".equals(chr))
            chr = "0";
        if (s.length() >= len)
            return s.substring(0, len);

        for (int i = s.length(); i < len; i++) {
            s = chr + s;
        }
        return s;
    }

    /**
     * �־��� ���ڷ� ���̸�ŭ ä�� �� �����ش�.
     * 
     * @param i ����
     * @param chr ä�� ���ڿ�
     *            null�̸� "0"���� ����
     * @param len ä�� ����
     * @return
     */
    public static String leftPad(int i, int len, String chr) {
        return leftPad(i + "", len, chr);
    }

    /**
     * �־��� ���ڷ� ���̸�ŭ "0"���� ä�� �� �����ش�.
     * 
     * @param s
     * @param len ä�� ����
     * @return
     */
    public static String leftPad(String s, int len) {
        return leftPad(s, len, null);
    }

    /**
     * �־��� ���ڷ� ���̸�ŭ "0"���� ä�� �� �����ش�.
     * 
     * @param i
     * @param len ä�� ����
     * @return
     */
    public static String leftPad(int i, int len) {
        return leftPad(i + "", len, null);
    }

}
