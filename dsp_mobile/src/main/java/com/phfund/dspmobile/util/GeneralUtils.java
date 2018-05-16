package com.phfund.dspmobile.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;

import com.fasterxml.jackson.databind.ObjectMapper;

public class GeneralUtils {
	
	private static ObjectMapper mapper = new ObjectMapper();
	
	/**
	 * 获取用户真实IP地址，不使用request.getRemoteAddr();的原因是有可能用户使用了代理软件方式避免真实IP地址, 参考文章：
	 * http://developer.51cto.com/art/201111/305181.htm
	 * 
	 * 可是，如果通过了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串IP值，究竟哪个才是真正的用户端的真实IP呢？
	 * 答案是取X-Forwarded-For中第一个非unknown的有效IP字符串。
	 * 
	 * 如：X-Forwarded-For：192.168.1.110, 192.168.1.120, 192.168.1.130,
	 * 192.168.1.100
	 * 
	 * 用户真实IP为： 192.168.1.110
	 * 
	 * @param request
	 * @return
	 */
	public static String getIpAddress(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	/**
	 * 判断是否为日期类型
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isDate(String str) {
		if (str == null) {
			return false;
		}
		int lenght = str.length();
		if (lenght != 10) {
			return false;
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
			format.parse(str);
		} catch (Exception e) {
			return false;
		}
		return true;
	}

	/**
	 * 添加千分位保留四位小数
	 * 
	 * @param data
	 * @return
	 */
	public static String thousandsFormat(Double data) {
		DecimalFormat dformat = new DecimalFormat("#,##0.0000;(#)");
		if (data != null) {
			return dformat.format(data);
		}
		return "";
	}

	/**
	 * 转化为百分率并保留四分小数添加%
	 * 
	 * @param data
	 * @return
	 */
	public static String toPercentage(Double data) {
		DecimalFormat dformat = new DecimalFormat("0.0000");
		if (data != null) {
			return dformat.format(data * 100) + "%";
		}
		return "";
	}
	
	/**
	 * 转化为百分率并保留四位小数
	 * @param data
	 * @return
	 */
	public static Double toPercentage1(Double data) {
		DecimalFormat dformat = new DecimalFormat("0.0000");
		if (data != null) {
			return Double.parseDouble(dformat.format(data * 100));
		}
		return null;
	}
	
	/**
	 * 保留4位小数
	 * 
	 * @param data
	 * @return
	 */
	public static String toDecimal(Double data) {
		DecimalFormat dformat = new DecimalFormat("0.0000");
		if (data != null) {
			return dformat.format(data);
		}
		return "";
	}
	
	/**
	 * 保留4位小数
	 * 
	 * @param data
	 * @return
	 */
	public static Double toDecimal1(Double data) {
		DecimalFormat dformat = new DecimalFormat("0.0000");
		if (data != null) {
			return Double.parseDouble(dformat.format(data));
		}
		return null;
	}

	/**
	 * 如果为空字符串则返回null
	 * 
	 * @param str
	 * @return
	 */
	public static String trimStr(String str) {
		if ("".equals(str)) {
			return null;
		} else {
			return str;
		}
	}

	/**
	 * 判断字符串是否为空或""
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isVal(String str) {
		if (str == null || "".equals(str)) {
			return false;
		} else {
			return true;
		}
	}

	
	
	/**
	 * 拼接调度者ID
	 * @param userId
	 * @return
	 */
	public static String getCallId(String userId){
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String str = format.format(date);
		int i=(int)(Math.random()*900)+100;
		String string = userId+"_"+str+"_"+i;
		return string;
	}
	
	/**
	 * 获取UUUID
	 * @return
	 */
	public static String getUUUID() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
	/**
	 * 拆分日期
	 * @param date
	 * @return
	 */
	public static String splitDate(String date){
		String earlyDate = "";
		String lastDate = "";
		if(date.contains("Q")){
			String str1 =date.substring(0,4);
			int int1 = Integer.parseInt(date.substring(5));
			int int2 = Integer.parseInt(str1);
			 switch(int1){
			    case 1:
			    	earlyDate = str1+"0101";
			    	lastDate = str1+"0401";
			    	break;
			    case 2:
			    	earlyDate = str1+"0401";
			    	lastDate = str1+"0701";
			    	break;
			    case 3:
			    	earlyDate = str1+"0701";
			    	lastDate = str1+"1001";
			        break;
			    case 4:
			    	earlyDate = str1+"1001";
			    	int2=int2+1;
			    	lastDate = ""+int2+"0101";
			    	break;
			    default:
			        break;
			}
		}else{
			earlyDate = date+"01";
			String str1 = date.substring(0,4);
			String str2 = date.substring(4);
			int int1 = Integer.parseInt(str1);
			int int2 = Integer.parseInt(str2);
			if(int2==12){
				int1=int1+1;
				int2=1;
			}else{
				int2=int2+1;
			}
			if(int2>=10){
				lastDate =""+int1+int2+"01";
			}else{
				lastDate =""+int1+"0"+int2+"01";
			}
		}
		return earlyDate+","+lastDate;
	}
	
	public static String getFileNameByType(HttpServletRequest request, String filename) throws UnsupportedEncodingException
			{
		final String userAgent = request.getHeader("USER-AGENT");
		if(StringUtils.contains(userAgent, "MSIE")){//IE浏览器
			filename = URLEncoder.encode(filename,"UTF-8");
		}else if(StringUtils.contains(userAgent, "Mozilla")){//google,火狐浏览器
			filename = new String(filename.getBytes(), "ISO8859-1");
		}else{
			filename = URLEncoder.encode(filename,"UTF-8");//其他浏览器
		}
		return filename;
	}
	
	/**
	 * 数组去重
	 * @param arr
	 * @return
	 */
	public static String[] rmRepeat(String[] arr){
		HashSet<String> set = new HashSet<>();
		for(int i=0;i<arr.length;i++){  
	        set.add(arr[i]);  
	    }
		String[] arr1 = set.toArray(new String[set.size()]);
		return arr1;
	}
	
	
	
	//关闭输入流
	public static void ioClose(InputStream is){
		try {
			if(is!=null){
				is.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//关闭输出流
	public static void ioClose(OutputStream os){
		try {
			if(os!=null){
				os.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	//判断ip是否在白名单里
	public static boolean isIpPass(String ip) {
		System.out.println(ip);
 		String[] strIp =  {"172.18.220.114","172.17.120.87","172.22.32.41","172.18.120.41"};
 		for (String string : strIp) {
 			if(ip.equals(string)) {
 				return true;
 			}
 		}
 		return false;
 	}
}
