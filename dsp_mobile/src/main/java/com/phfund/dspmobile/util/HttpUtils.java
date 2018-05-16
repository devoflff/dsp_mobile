package com.phfund.dspmobile.util;

import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.StatusLine;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


import org.apache.commons.lang3.ArrayUtils;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class HttpUtils {
	private static Logger logger = LoggerFactory.getLogger(HttpUtils.class);

	//get接口掉方法
	public static String doget(String url) {
		// get请求返回结果
		String strResult = null;
		try {
			HttpClient client = new DefaultHttpClient();
			;
			// 发送get请求
			HttpGet request = new HttpGet(url);
			HttpResponse response = client.execute(request);

			/** 请求发送成功，并得到响应 **/
			if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
				/** 读取服务器返回过来的json格式字符串数据 **/
				HttpEntity entity = response.getEntity();
				strResult = EntityUtils.toString(entity, "UTF-8");
			} else {
				logger.error("get请求提交失败:" + url);
			}
		} catch (IOException e) {
			logger.error("get请求提交失败:" + url, e);
		}
		return strResult;
	}

	/**
	 * post请求（用于请求json格式的参数）
	 * 
	 * @param url
	 * @param params
	 * @return
	 */
	public static String doPost(String url) throws Exception {

		CloseableHttpClient httpclient = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(url);// 创建httpPost
		httpPost.setHeader("Accept", "application/json");
		httpPost.setHeader("Content-Type", "application/json");
		String charSet = "UTF-8";
		StringEntity entity = new StringEntity(charSet);
		httpPost.setEntity(entity);
		CloseableHttpResponse response = null;

		try {

			response = httpclient.execute(httpPost);
			StatusLine status = response.getStatusLine();
			int state = status.getStatusCode();
			if (state == HttpStatus.SC_OK) {
				HttpEntity responseEntity = response.getEntity();
				String jsonString = EntityUtils.toString(responseEntity, "UTF-8");
				System.out.println("Response content length: " + entity.getContentLength());
				return jsonString;
			} else {
				logger.error("请求返回:" + state + "(" + url + ")");
			}
		} finally {
			if (response != null) {
				try {
					response.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			try {
				httpclient.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	public static JSONObject toJSONObject(JSONArray jsonArray, String key) {
		JSONObject jsonObject = new JSONObject();
		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject temp = jsonArray.getJSONObject(i);
			String[] keyValues = ArrayUtils.toArray(key);
			if (keyValues != null) {
				for (String item : keyValues) {
					String[] k = item.split(":");
					String[] keys = k[0].split("&");
					String keyName = k[0];
					if (keys.length == 2) {
						keyName = keys[0];
					}
					String jsonKeyName = temp.getString(keyName);
					if (keys.length == 2) {
						jsonKeyName += "_" + keys[1];
					}
					jsonObject.put(jsonKeyName, temp.getString(k[1]));
				}
			}
		}
		return jsonObject;
	}
	
	public  static Map<String, Object> json2Map(JSONObject jsonObject) {  
        Map<String, Object> resultMap = new HashMap<String, Object>();  
        Iterator<?> iterator = jsonObject.keys();  
  
        while (iterator.hasNext()) {  
            String key = (String) iterator.next();  
            Object value = jsonObject.get(key);  
  
            if (value instanceof JSONObject) {  
                value = json2Map((JSONObject) value);  
                resultMap.put(key, value);  
            } else {  
                resultMap.put(key, jsonObject.getString(key));  
            }  
        }  
        return resultMap;  
    }  
	
}