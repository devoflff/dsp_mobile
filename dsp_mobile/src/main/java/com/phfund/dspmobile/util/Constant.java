package com.phfund.dspmobile.util;

/**
 * 常量类
 * @author x_liufangfang
 *
 */
public class Constant {
	public final static String RUNNING = "RUNNING";//运行中
	public final static String ERROR = "ERROR"; //失败
	public final static String FINISHED = "FINISHED"; //完成
	public final static String UNREADY = "UNREADY"; //未完成
	public final static String READY = "READY"; //待发送
	public final static String SENDING = "SENDING"; //发送中
	
	/*
	 * 定时任务配置模板中参数
	 * POST_METHOD_KEY   报表结果发送方式
	 * POST_DAY_TYPE     发送日类型
	 * POST_DAY_TYPE_ALL 每天  
	 * POST_DAY_TYPE_TD  交易日
	 * COPY_TO_FILE_PATH 报表结果拷贝到的目标路径
	 * **/
	public static final String POST_METHOD_KEY="POST_METHOD";
	public static final String POST_DAY_TYPE="POST_DAY_TYPE";
	public static final String POST_DAY_TYPE_ALL="ALL";
	public static final String POST_DAY_TYPE_TD="TRADE_DAY";
	public static final String COPY_TO_FILE_PATH="COPY_TO_FILE_PATH";
}
