/*
 * Copyright 2003 POSTCOREANET, Inc. All rights reserved.
 * 
 * �� ���α׷��� ����Ʈ�ڸ��Ƴ�(http://www.postcorea.net)���� �ۼ��Ǿ���ϴ�. 
 * ����Ʈ�ڸ��Ƴ��� �������, ������� �ϽǼ� ����ϴ�.
 * 
 * ������ : �谭��
 * ����� : ����Ʈ�ڸ��Ƴ� ����������
 * ���糯 : 2005. 07. 11.
 * 
 * [���߱��]
 *  1.0 - 2005. 07. 11. �谭�� 
 *      : ó�� ����
 *  
 */
package com.vicurus.it.core.common.util;

/**
 * <p>
 * Tokenizer.
 * </p>
 * @author YAME
 * @version $Revision: 001  $Date: 2013-07-01 
 */
public class Tokenizer  {
	
	private int currentPosition;
	private int maxPosition;
	private String str;
	private String delimiter;
	private int delimiterSize;
	
	private int countTokens	 = -1;	// Token�� ����
	
	public Tokenizer(String str) {
		this(str, " ");
	}

	/**
	 * 
	 * @param str
	 * @param delim
	 */
	public Tokenizer(String str, String delim) {
		this.str = str;
		this.delimiter = delim;
		currentPosition = 0;
		maxPosition = this.str.length();
		delimiterSize = this.delimiter.length(); 
		
	}	
	
	
	public boolean hasMoreTokens() {
		return ( (currentPosition <= maxPosition) || (str.indexOf(delimiter, currentPosition) > -1));
	}
	
	public String nextToken() {
		String result = null;
		int index = str.indexOf(delimiter, currentPosition);
		if (index > -1) {
			result = str.substring(currentPosition, index);
			currentPosition = index + delimiterSize;
		} else {
			result = str.substring(currentPosition);
			currentPosition = maxPosition + delimiterSize;
		}
		return result;
	}
	
	public int countTokens() {
		if (countTokens < 0) {
			int tCountTokens = 1;
			int cp = 0;
			int index = 0;
			while ((index = str.indexOf(delimiter, cp)) > -1) {
			    tCountTokens++;
				cp = index + delimiterSize;
			}
			countTokens = tCountTokens;
		}
		return countTokens;
	}
	
	public String[] toArray(int arraySize) {
	    String[] array = new String[arraySize];
	    for (int i = 0; i < arraySize && hasMoreTokens(); i++) {
	        array[i] = nextToken();
	    }
	    return array;
	}
	
	public String[] toArray() {
	    return toArray(countTokens());
	}
	
}
