<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	// default id is 0 if no input.
	int gamerID2;
	if (request.getParameter("gamerID2") != null)  
    	gamerID2 = Integer.parseInt(request.getParameter("gamerID2"));
	else
		gamerID2 = 0;
   session.setAttribute( "gamerID2", gamerID2 );
   response.sendRedirect("specp.jsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>