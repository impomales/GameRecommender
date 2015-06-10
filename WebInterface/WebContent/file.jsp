<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	// default id is 0 if no input.
	int gamerID;
	if (request.getParameter("gamerID") != null)  
    	gamerID = Integer.parseInt(request.getParameter("gamerID"));
	else
		gamerID = 0;
   session.setAttribute( "gamerID", gamerID );
   String option = request.getParameter("option");
   session.setAttribute("option", option);
   
   String nextPage = null;
   if (option.equals("General"))
	   nextPage = "general.jsp";
   else if (option.equals("Specific Player")) {
	   nextPage = "sp.jsp";
   }
   else 
	   nextPage = "ymal.jsp";
   response.sendRedirect(nextPage);	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Form Handler</title>
</head>
<body>
</body>
</html>