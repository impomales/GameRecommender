<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css" />
<title>Verify Patterns</title>
</head>
<body>
	<div id="header">
		<h1>Verify Patterns</h1>
	</div>
	<div id="main">
		<h2>Patterns Options</h2>
		<form method="post" action="patternres.jsp">
			 <br />
			<select name="pattern">
				<option value="os">Most games supported by windows</option>
				<option value="preference">Games of preferred genre are higher rated</option>
				<option value="country">Games from same country as player are higher rated</option>
				<option value="hours">RPGS and MMOGs are played for more hours</option>
			</select>
			<input type="submit" />
		</form>
	</div>
</body>
</html>