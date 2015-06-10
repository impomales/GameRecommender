<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*, java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css" />
<title>Specific Player</title>
</head>
<body>
	<div id="header">
		<h1>Specific Player.</h1>
	</div>
	<table id="results">
		<tr>
			<td>
				<div>
					<h1 id="title">Highly Recommend!</h1>
<%
	String jdbc = "org.h2.Driver";
	String url = "jdbc:h2:~/gamedata";
	final String user = "impomales";
	final String pass = "abcdefg";
	
	Connection c = null;
	Statement s = null;
	
	try {
		Class.forName(jdbc);
		System.out.println("Connecting to Database...");
		c = DriverManager.getConnection(url, user, pass);
		System.out.println("Connected successfully!");
		s = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		String option;
		if (session.getAttribute("option").equals("Specific Player"))
			option = "= " + session.getAttribute("gamerID2");
		else
			option = "<> " + session.getAttribute("gamerID");
		String sql;
		ResultSet rs;
		
		
		
		sql = "select distinct g.title " +
				"from " + "(select distinct b.gamerid, b.title " +
				"from " +
				"(select title " +
				"from plays " +
				"where gamerid = " + session.getAttribute("gamerID") + " and rating >= 3) a, plays b " +
				"where b.gamerid " + option + " and b.title <> a.title and b.rating >= 3)" + " q, Games g, Players p " +
				"where g.title = q.title and p.ID = " + session.getAttribute("gamerID") + " and g.category = p.preference " +
				"order by g.title asc";
		rs = s.executeQuery(sql);
		if (!rs.next()) {
			;
		} else {
		%>
		<div class="scroll">
		<ul>
		<%
		rs.beforeFirst();
		while (rs.next()) {
		%>
			<li>
				<%=rs.getString("title") %>
			</li>
		<%
		}
		%>
		</ul>
		</div>
		<%
		}
		%>
		</div>
		</td>
		<td>
			<div>
				<h1 id="title">Games playable on your devices.</h1>
		<%
		
		sql = "select distinct s.title, o.deviceid, o.os as own, s.os as supports " +
				"from owns o, supports s, " + "(select distinct b.gamerid, b.title " +
						"from " +
						"(select title " +
						"from plays " +
						"where gamerid = " + session.getAttribute("gamerID") + " and rating >= 3) a, plays b " +
						"where b.gamerid " + option + " and b.title <> a.title and b.rating >= 3) g " + 
				"where o.gamerid = " + session.getAttribute("gamerID") +
				" and s.title = g.title " +
				"and o.deviceid = s.deviceid and o.os = s.os " +
				"order by s.title asc";
		rs = s.executeQuery(sql);
		if (!rs.next()) {
			%>
			<em>You don't own any devices that can play these games!</em>
			<%
		} else {
		%>
			<div class="scroll">
		<table>
			<tr>
				<th>Title</th>
				<th>DeviceID</th>
				<th>OS</th>
			</tr>
		<%
		rs.beforeFirst();
		while (rs.next()) {
		%>
			<tr>
				<td><%=rs.getString("title") %></td>
				<td><%=rs.getString("deviceid") %></td>
				<td><%=rs.getString("own") %></td>
			</tr>
		<%
		}
		%>
		</table>
		</div>
		<%
		}
		%>
		</div>
		</td>
		</tr>
		<tr>
			<td>
				<div>
					<h1 id="title">Games you should check out.</h1>
		<%
		
		sql = "select distinct b.gamerid, b.title " +
				"from " +
				"(select title " +
				"from plays " +
				"where gamerid = " + session.getAttribute("gamerID") + " and rating >= 3) a, plays b " +
				"where b.gamerid " + option + " and b.title <> a.title and b.rating >= 3 " +
				"order by b.title asc";
		rs = s.executeQuery(sql);
		if (!rs.next()) {
			%>
			<em>There aren't any games to recommend from other players.</em><br />
			<%
		} else {
		%>
			<div class="scroll">
		<ul>
		<%
		rs.beforeFirst();
		while (rs.next()) {
		%>
			<li>
				<%=rs.getString("title") %>
			</li>
		<%
		}
		%>
		</ul>
		</div>
		<%
		}
		%>
		</div>
		</td>
		<td>
			<div>
				<h1 id="title">You can play them with these devices.</h1>
		<%
		sql = "select distinct s.* " + 
				"from supports s, (select distinct b.gamerid, b.title " +
				"from " +
				"(select title " +
				"from plays " +
				"where gamerid = " + session.getAttribute("gamerID") + " and rating >= 3) a, plays b " +
				"where b.gamerid " + option + " and b.title <> a.title and b.rating >= 3) g " +
				"where s.title = g.title " +
				"order by s.title";
		rs = s.executeQuery(sql);
		if (!rs.next()) {
			%>
			<em>You can't play them on any devices yet :-/</em>
			<%
		} else {
		%>
			<div class="scroll">
		<table>
			<tr>
				<th>Title</th>
				<th>DeviceID</th>
				<th>OS</th>
			</tr>
		<%
		rs.beforeFirst();
		while (rs.next()) {
		%>
			<tr>
				<td><%=rs.getString("title") %></td>
				<td><%=rs.getString("deviceid") %></td>
				<td><%=rs.getString("os") %></td>
			</tr>
		<%
		}
		%>
		</table>
		</div>
		<%
		}
		%>
		</div>
		</td>
		</tr>
		<tr>
		<td colspan=2>
		<div id="footer">
		<small>Copyright � Isaias Pomales imp31@scarletmail.rutgers.edu</small>
		<a href="verify.jsp">Click here to verify patterns.</a>
		</div>
		</td>
		</tr>
		<%
		rs.close();
	} catch (SQLException e) {
		e.printStackTrace();
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} finally {
		try {
			if (s != null)
				s.close();
		} catch (SQLException e) {}
		try {
			if (c != null)
				c.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
 %>
</table>
</body>
</html>