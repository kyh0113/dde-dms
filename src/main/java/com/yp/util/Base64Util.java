package com.yp.util;

public class Base64Util
{
  public static String encode(String s)
  {
    return encode(s, "utf-8");
  }
  
  public static String encode(byte[] s)
  {
    try
    {
      byte[] bytes = org.apache.commons.codec.binary.Base64.encodeBase64(s);
      return new String(bytes, "UTF-8");
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
  }
  
  public static String encode(String s, String encoding)
  {
    try
    {
      byte[] bytes = org.apache.commons.codec.binary.Base64.encodeBase64(s.getBytes(encoding));
      return new String(bytes, "UTF-8");
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
  }
  
  public static byte[] encode2(String s, String encoding)
  {
    try
    {
      return org.apache.commons.codec.binary.Base64.encodeBase64(s.getBytes(encoding));
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
  }
  
  public static byte[] encode2(String s)
  {
    return encode2(s, "utf-8");
  }
  
  public static String decode(String s)
  {
    return decode(s, "utf-8");
  }
  
  public static String decode(byte[] s)
  {
    try
    {
      byte[] encoded = org.apache.commons.codec.binary.Base64.decodeBase64(s);
      return new String(encoded, "UTF-8");
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
  }
  
  public static byte[] decode2(String s, String encoding)
  {
    try
    {
      return org.apache.commons.codec.binary.Base64.decodeBase64(s.getBytes(encoding));
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
  }
  
  public static byte[] decode2(String s)
  {
    return decode2(s, "utf-8");
  }
  
  public static String decode(String s, String encoding)
  {
    try
    {
      return new String(org.apache.commons.codec.binary.Base64.decodeBase64(s.getBytes(encoding)));
    }
    catch (Exception e)
    {
      throw new RuntimeException(e);
    }
  }
}

