package org.apache.jsp.jsp.ops;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class reportRunLogPage_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(2);
    _jspx_dependants.add("/WEB-INF/taglibs/c.tld");
    _jspx_dependants.add("/WEB-INF/taglibs/fmt.tld");
  }

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<style>\r\n");
      out.write("* {\r\n");
      out.write("\tpadding: 0;\r\n");
      out.write("\tmargin: 0;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("body, html {\r\n");
      out.write("\tfont-size: 14px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("#div1 {\r\n");
      out.write("\tpadding-top: 10px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("ul, li {\r\n");
      out.write("\tlist-style: none;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".title {\r\n");
      out.write("\theight: 30px;\r\n");
      out.write("\twidth: 100%;\r\n");
      out.write("\tborder-top: 1px solid #DDDDDD;\r\n");
      out.write("\tmargin-bottom: 2px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".title li {\r\n");
      out.write("\tfloat: left;\r\n");
      out.write("\twidth: 25%;\r\n");
      out.write("\tline-height: 30px;\r\n");
      out.write("\tbox-sizing: border-box;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("#tb1 {\r\n");
      out.write("\tborder: 0;\r\n");
      out.write("\tborder-collapse: collapse;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("#tb1 .c1 {\r\n");
      out.write("\theight: 60px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("#table1 tbody tr td {\r\n");
      out.write("\tborder: 1px solid #DDDDDD;\r\n");
      out.write("\theight: 30px;\r\n");
      out.write("\tpadding: 10px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("#table1 thead tr th {\r\n");
      out.write("\tborder: 1px solid #DDDDDD;\r\n");
      out.write("\tpadding: 10px;\r\n");
      out.write("\theight: 30px;\r\n");
      out.write("}\r\n");
      out.write("</style>\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"utf-8\">\r\n");
      out.write("<title>报表运行记录耗时图</title>\r\n");
      out.write("<link type=\"text/css\" rel=\"stylesheet\"\r\n");
      out.write("\thref=\"/dsp_mobile/css/bootstrap/bootstrap.min.css\" />\r\n");
      out.write("<script type=\"application/javascript\"\r\n");
      out.write("\tsrc=\"/dsp_mobile/js/common/jquery-3.2.1.min.js\"></script>\r\n");
      out.write("<script type=\"application/javascript\"\r\n");
      out.write("\tsrc=\"/dsp_mobile/js/common/bootstrap.min.js\"></script>\r\n");
      out.write("<script type=\"application/javascript\"\r\n");
      out.write("\tsrc=\"/dsp_mobile/js/common/bootstrap-select.js\"></script>\r\n");
      out.write("<script type=\"application/javascript\"\r\n");
      out.write("\tsrc=\"/dsp_mobile/js/common/jquery.ba-resize.js\"></script>\t\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("      $(function(){\r\n");
      out.write("    \tvar reportId=$('#reportId').val();\r\n");
      out.write("    \tvar reportName=$(\"#reportName\").val();\r\n");
      out.write("      \topenView(reportId,reportName);\r\n");
      out.write("     });\r\n");
      out.write(" \t\t\r\n");
      out.write("    function openView(reportId,reportName){\r\n");
      out.write("    \trequire.config({\r\n");
      out.write("            paths: {\r\n");
      out.write("                echarts: '/dsp_mobile/js/echart'\r\n");
      out.write("            }\r\n");
      out.write("        });\r\n");
      out.write("        require(\r\n");
      out.write("            [\r\n");
      out.write("                'echarts',\r\n");
      out.write(" \t\t\t\t'echarts/chart/line'\r\n");
      out.write("            ],\r\n");
      out.write("            function (ec) {\r\n");
      out.write("                var myChart = ec.init(document.getElementById('main')); \r\n");
      out.write("                \r\n");
      out.write("            \t//ajax后台交互\r\n");
      out.write("                var xtime=[];\r\n");
      out.write("                var ytime=[];\r\n");
      out.write("                   $.ajax({\r\n");
      out.write("                 \ttype : \"GET\",\r\n");
      out.write("                \tasync : false, //同步执行\r\n");
      out.write("                \turl : \" /dsp_mobile/mobile/getMrData.do\",\r\n");
      out.write("                \tdata : {\"reportId\":reportId}, \r\n");
      out.write("                \tdataType : \"json\",\r\n");
      out.write("                \tsuccess:function(date){\r\n");
      out.write("                \t\t\r\n");
      out.write("                \t\t//赋值\r\n");
      out.write("                \t\txtime=date.xtime;\r\n");
      out.write("                \t\tytime=date.ytime;\r\n");
      out.write("                  \t\tvar option={\r\n");
      out.write("                \t\t\t\ttitle : {\r\n");
      out.write("            \t\t\t\t        text: reportName+'(最近六个月)运行记录耗时图',\r\n");
      out.write("            \t\t\t\t        subtext: '仅供参考',\r\n");
      out.write("            \t\t\t\t\t    x: 'center',\r\n");
      out.write("            \t\t\t\t\t    textStyle:{\r\n");
      out.write("            \t\t\t\t\t        //文字颜色\r\n");
      out.write("            \t\t\t\t\t        color:'#000000',\r\n");
      out.write("            \t\t\t\t\t        //字体风格,'normal','italic','oblique'\r\n");
      out.write("            \t\t\t\t\t        fontStyle:'normal',\r\n");
      out.write("            \t\t\t\t\t        //字体粗细 'normal','bold','bolder','lighter',100 | 200 | 300 | 400...\r\n");
      out.write("            \t\t\t\t\t        fontWeight:'bold',\r\n");
      out.write("            \t\t\t\t\t        //字体系列\r\n");
      out.write("            \t\t\t\t\t        fontFamily:'sans-serif',\r\n");
      out.write("            \t\t\t\t\t        //字体大小\r\n");
      out.write("            \t\t\t\t\t        fontSize:15\t\r\n");
      out.write("\r\n");
      out.write("            \t\t\t\t\t    }\r\n");
      out.write("            \t\t\t\t    },\r\n");
      out.write("                \t\t\t\ttooltip : {\r\n");
      out.write("                        \t        trigger: 'axis',\r\n");
      out.write("                        \t        axisPointer: {\r\n");
      out.write("                        \t            type: 'cross',\r\n");
      out.write("                        \t            label: {\r\n");
      out.write("                        \t                backgroundColor: '#6a7985'\r\n");
      out.write("                        \t            }\r\n");
      out.write("                        \t        }\r\n");
      out.write("                        \t    },\r\n");
      out.write("                        \t    legend: {\r\n");
      out.write("                        \t        data: ['耗时'],\r\n");
      out.write("                        \t        x: 'right',\r\n");
      out.write("               \t\t\t\t\t\ty: 30\r\n");
      out.write("                        \t    },\r\n");
      out.write("                        \t    grid: {\r\n");
      out.write("                        \t    \tx:42,\r\n");
      out.write("                        \t    \ty:55,\r\n");
      out.write("                        \t    \tx2:15,\r\n");
      out.write("                        \t    \ty2:55,\r\n");
      out.write("                        \t    \tleft: '0%',\r\n");
      out.write("                        \t    \tright: '0%',\r\n");
      out.write("                        \t    \tbottom: '0%',\r\n");
      out.write("                        \t    \tcontainLabel: true\r\n");
      out.write("                        \t    \t},\r\n");
      out.write("                        \t    toolbox: {\r\n");
      out.write("                        \t    \tshow: true,\r\n");
      out.write("                        \t        feature: {\r\n");
      out.write("                        \t            dataZoom: {\r\n");
      out.write("                        \t                yAxisIndex: 'none'\r\n");
      out.write("                        \t            },\r\n");
      out.write("                        \t            dataView: {readOnly: false},\r\n");
      out.write("                        \t            magicType: {type: ['line', 'bar']},\r\n");
      out.write("                        \t            restore: {},\r\n");
      out.write("                        \t            saveAsImage: {}\r\n");
      out.write("                        \t        }\r\n");
      out.write("                        \t    },\r\n");
      out.write("                         \t    xAxis : [\r\n");
      out.write("                        \t        {\r\n");
      out.write("                        \t            type : 'category',\r\n");
      out.write("                        \t            boundaryGap : false,\r\n");
      out.write("                        \t            splitLine:{ \r\n");
      out.write("                                            show:false \r\n");
      out.write("                                     },\r\n");
      out.write("                        \t           data :  xtime,\r\n");
      out.write("                        \t           axisLabel: {\r\n");
      out.write("                                           interval: 4,\r\n");
      out.write("                                           rotate: 48,\r\n");
      out.write("                                           //倾斜度 -90 至 90 默认为0  \r\n");
      out.write("                                           margin: 2,\r\n");
      out.write("                                           textStyle: {\r\n");
      out.write("                                               color: \"#000000\"\r\n");
      out.write("                                           }\r\n");
      out.write("                                       }\r\n");
      out.write("                        \t        // data:[1, 2, 3, 4, 5, 6, 7]\r\n");
      out.write("                        \t        }\r\n");
      out.write("                        \t    ],\r\n");
      out.write("                        \t    yAxis : [\r\n");
      out.write("               \t\t\t\t        {\r\n");
      out.write("               \t\t\t\t        \tname: '耗时(秒)',\r\n");
      out.write("               \t\t\t\t        \ttype: 'value',\r\n");
      out.write("               \t\t\t\t        \taxisLine: {onZero: false}\r\n");
      out.write("                \t\t\t\t        }\r\n");
      out.write("                        \t    ],\r\n");
      out.write("                          \t    series : [\r\n");
      out.write("                          \t    \t{   name:'耗时',\r\n");
      out.write("                                        type:'line',\r\n");
      out.write("                                        data: ytime\r\n");
      out.write("                                     }\r\n");
      out.write("                           \t    ]\r\n");
      out.write("                 \t\t};\r\n");
      out.write("                 \t\t//option.series = series;\r\n");
      out.write("                \t\t// 为echarts对象加载数据 \r\n");
      out.write("                        myChart.setOption(option); \r\n");
      out.write("                        window.onresize = myChart.resize;\r\n");
      out.write("                 \t},\r\n");
      out.write("                });\r\n");
      out.write("                 \r\n");
      out.write("            }\r\n");
      out.write("        );\r\n");
      out.write("    \t\r\n");
      out.write("     };\r\n");
      out.write("    </script>\r\n");
      out.write("</head>\r\n");
      out.write("<body\r\n");
      out.write("\tstyle=\"margin-top: 120px; margin-left: 10px; margin-right: 10px; margin-bottom: 10px; border-top-width: 0px; border-top-style: solid;\">\r\n");
      out.write("\t<div id=\"main\" style=\"height: 400px; width: 100%\">\r\n");
      out.write("\t\t<input id=\"reportId\" name=\"reportId\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${reportId}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\" type=\"hidden\" />\r\n");
      out.write("\t\t<input id=\"reportName\" name=\"reportName\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${reportName}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\"\r\n");
      out.write("\t\t\ttype=\"hidden\" />\r\n");
      out.write("\t</div>\r\n");
      out.write("\r\n");
      out.write("\t<script src=\"/dsp_mobile/js/echart/echarts.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\">\r\n");
      out.write("        \r\n");
      out.write("    </script>\r\n");
      out.write("</body>\r\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
