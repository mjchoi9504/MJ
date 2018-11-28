<%@ page contentType="text/json; charset=UTF-8"%>
<%
	if( request.getAttribute("msg").equals("ok") ) {
%>
		{ "upload" : "ok" }
<%	
	} else {
%>
		{"upload" : "fail" }
<%
	}
%>