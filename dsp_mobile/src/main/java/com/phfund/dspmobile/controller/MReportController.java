package com.phfund.dspmobile.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.phfund.dspmobile.util.HttpUtils;


/**
 * 移动OA报表查询接口
 * @author x_liufangfang
 *
 */

@Controller
@RequestMapping("/mobile")
public class MReportController {
	private static Logger logger = LoggerFactory.getLogger(MReportController.class);

	private ObjectMapper mapper = new ObjectMapper();

	/**
	 * 查询手机端报表	           
	 * @param request,response
	 * @return list
	 */
	@ResponseBody
	@RequestMapping(value = "/reportList",method = RequestMethod.GET,produces="application/json"+";charset=utf-8")
	public String reportList(HttpServletResponse response, HttpServletRequest request) {
		String url_list = "http://172.18.187.102:8080/dsp/mReport/getMReportList.do";
		String result= HttpUtils.doget(url_list);
		return  result;
	}
	
	/**
	 * 跳转查看页面
	 * @param page
	 * @param rows
	 * @param reportId
	 * @return
	 */
	@RequestMapping(value ="/getRunLog")
	public ModelAndView getReportRunLog(String reportId,String reportName,HttpServletRequest request) {
		Map<String, Object>  model = new HashMap<>(); 
		String r_name=null;
		try {
			//处理参数乱码问题
			r_name = new String(reportName.getBytes("iso8859-1"),"utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
  		model.put("reportId", reportId);
   		model.put("reportName", r_name);
		return new ModelAndView("ops/reportRunLogPage", model);
   	}
	
	/**
	 * 查询图表页面	           
	 * @param request,response
	 * @return list
	 */
	@ResponseBody
	@RequestMapping(value = "/getMrData",method = RequestMethod.GET,produces="application/json"+";charset=utf-8")
	public static String getMrData(String reportId) {
		String url_runlog = "http://172.18.187.102:8080/dsp/mReport/getMrData/";
		String url_new=url_runlog+reportId+".do";
		String result= HttpUtils.doget(url_new);		
		return  result;
	}
	
}
