package org.apache.jsp.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List _jspx_dependants;

  static {
    _jspx_dependants = new java.util.ArrayList(2);
    _jspx_dependants.add("/WEB-INF/taglibs/c.tld");
    _jspx_dependants.add("/WEB-INF/taglibs/fmt.tld");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.AnnotationProcessor _jsp_annotationprocessor;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_annotationprocessor = (org.apache.AnnotationProcessor) getServletConfig().getServletContext().getAttribute(org.apache.AnnotationProcessor.class.getName());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.release();
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
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("<title>数据服务平台移动端报表首页</title>\r\n");
      out.write("<link type=\"text/css\" rel=\"stylesheet\"\r\n");
      out.write("\thref=\"/dsp_mobile/css/bootstrap/bootstrap.min.css\" />\r\n");
      out.write("<script type=\"application/javascript\"\r\n");
      out.write("\tsrc=\"/dsp_mobile/js/common/jquery-3.2.1.min.js\"></script>\r\n");
      out.write("<script type=\"application/javascript\"\r\n");
      out.write("\tsrc=\"/dsp_mobile/js/common/bootstrap.min.js\"></script>\r\n");
      out.write("<script type=\"text/javascript\" src=\"/dsp_mobile/js/globalVal.js\"></script>\r\n");
      out.write("<script src=\"/dsp_mobile/js/amazeui.js\"></script>\r\n");
      out.write("\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\r\n");
      out.write("$(document).ready(function (){\r\n");
      out.write(" \tgetchannalsecond();\r\n");
      out.write("});\r\n");
      out.write("//获取二级渠道\r\n");
      out.write("function getchannalsecond(){\r\n");
      out.write(" \t\r\n");
      out.write("\t//初始化查询参数\r\n");
      out.write("\t$.ajax({\r\n");
      out.write("\t\ttype:\"GET\",\r\n");
      out.write("\t\turl:'/dsp_mobile/mobile/reportList.do',\r\n");
      out.write("\t\tdataType : 'json',\r\n");
      out.write("\t\tbeforeSend: LoadFunction, //加载执行方法      \r\n");
      out.write("        error: erryFunction,  //错误执行方法      \r\n");
      out.write("        success: succFunction //成功执行方法      \r\n");
      out.write("    })  \r\n");
      out.write("    function LoadFunction() {  \r\n");
      out.write("       // $(\"#report\").html('加载中...');  \r\n");
      out.write("    }  \r\n");
      out.write("    function erryFunction() {  \r\n");
      out.write("        alert(\"访问受限！\");  \r\n");
      out.write("    }  \r\n");
      out.write("    function succFunction(data) {  \r\n");
      out.write("    \t/* <a  href=\"/dsp_mobile/ops/getRunLog.do?reportId='+n.reportId+'\"> */\r\n");
      out.write("        var b=data;\r\n");
      out.write("        var reportHtml = '';\r\n");
      out.write("        $.each(b, function(i, n){\r\n");
      out.write("        reportHtml+='<ul class=\"list-group\" style=\"float: center; padding: 0; margin: 0\">'\r\n");
      out.write("                   +'<li class=\"list-group-item\" style=\"text-align:center;font-size:30px\">'\r\n");
      out.write("                   +'<a  href=\"/dsp_mobile/mobile/getRunLog.do?reportId='+n.REPORT_ID+'&reportName='+n.REPORT_NAME+'\"><span class=\"badge\">'+n.REPORT_NAME+'</span></a></li></ul>'\r\n");
      out.write("        });\r\n");
      out.write("        $('#report').append(reportHtml);\r\n");
      out.write("  }\r\n");
      out.write("};\r\n");
      out.write("\t\r\n");
      out.write("function openReport(reportId,reportName){\r\n");
      out.write("\tparent.layer.open({\r\n");
      out.write("\t\ttype: 2,\r\n");
      out.write("\t\tshadeClose: true,\r\n");
      out.write("\t\tshade: false,\r\n");
      out.write("\t\tmaxmin: true, //开启最大化最小化按钮\r\n");
      out.write("\t\tarea: ['98%', '600px'],\r\n");
      out.write("\t\tcontent: '/dsp_mobile/mobile/getRunLog.do?reportId='+reportId+'&reportName='+reportName\r\n");
      out.write("\t});\r\n");
      out.write("};\t\r\n");
      out.write("</script>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\t");
      out.write("\r\n");
      out.write("\t<div class=\"row\">\r\n");
      out.write("\t\t<div class=\"col-lg-6\">\r\n");
      out.write("\t\t\t<div id=\"report\" style='margin-top:10px;margin-bottom:10px;border:solid white;'>\r\n");
      out.write("\t\t\t\t<!-- <ul class=\"list-group\" style=\"float: center; padding: 0; margin: 0\">\r\n");
      out.write("\t\t\t\t\t\t");
      if (_jspx_meth_c_005fforEach_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\t\t</ul> -->\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("</body>\r\n");
      out.write("</html>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
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

  private boolean _jspx_meth_c_005fforEach_005f0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_005fforEach_005f0 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_005fforEach_005f0.setPageContext(_jspx_page_context);
    _jspx_th_c_005fforEach_005f0.setParent(null);
    // /jsp/index.jsp(89,6) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f0.setVar("report");
    // /jsp/index.jsp(89,6) name = items type = java.lang.Object reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fforEach_005f0.setItems((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${reportMap.reportList}", java.lang.Object.class, (PageContext)_jspx_page_context, null, false));
    int[] _jspx_push_body_count_c_005fforEach_005f0 = new int[] { 0 };
    try {
      int _jspx_eval_c_005fforEach_005f0 = _jspx_th_c_005fforEach_005f0.doStartTag();
      if (_jspx_eval_c_005fforEach_005f0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\t\t\t\t\t\t\t<li class=\"list-group-item\"><span class=\"badge\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${report.reportId}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</span>\r\n");
          out.write("\t\t\t\t\t\t\t\t<a style=\"font-family: Microsoft YaHei\"\r\n");
          out.write("\t\t\t\t\t\t\t\thref=\"/dsp/mobile/inserRunLog.do?reportId=");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${report.reportId}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write('"');
          out.write('>');
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${report.reportName }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</a>\r\n");
          out.write("\t\t\t\t\t\t\t</li>\r\n");
          out.write("\t\t\t\t\t\t");
          int evalDoAfterBody = _jspx_th_c_005fforEach_005f0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_005fforEach_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_005fforEach_005f0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_005fforEach_005f0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_005fforEach_005f0.doFinally();
      _005fjspx_005ftagPool_005fc_005fforEach_0026_005fvar_005fitems.reuse(_jspx_th_c_005fforEach_005f0);
    }
    return false;
  }
}
