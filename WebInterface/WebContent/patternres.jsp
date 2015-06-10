<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*, java.sql.*" %>
<%
	String pattern = request.getParameter("pattern");
	session.setAttribute("pattern", pattern);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="style.css" />
<title>Results</title>
</head>
<body>
	<div id="header">
		<h1>Patterns</h1>
	</div>
	<div id="options" class="scroll">
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
		
		String sql;
		ResultSet r;
		
		if (pattern.equals("os")) {
			sql = "select os, count(*) as num from supports group by os";
			r = s.executeQuery(sql);
			%>
			<p>Windows is the most supported, Linux is the least.</p>
			<table>
				<tr>
					<th>OS</th>
					<th># of games</th>
				</tr>
				<%
			while (r.next()) {
				%>
				<tr>
					<td><%=r.getString("os") %></td>
					<td><%=r.getInt("num") %></td>
				</tr>
			<%
			}
			%>
			</table>
		<%
		} else  if (pattern.equals("preference")) {
			sql = "select d.title, avg(d.rating) as avgrating " +
					"from (select b.title, a.id " +
					"from players a, games b " +
					"where a.preference = b.category) c, plays d " +
					"where c.id = d.gamerid and c.title = d.title " +
					"group by d.title " +
					"order by d.title asc";
			r = s.executeQuery(sql);
			%>
			<p>Average ratings are 3 and above</p>
			<table>
				<tr>
					<th>title</th>
					<th>average rating</th>
				</tr>
				<%
			while (r.next()) {
				%>
				<tr>
					<td><%=r.getString("title") %></td>
					<td><%=r.getDouble("avgrating") %></td>
				</tr>
			<%
			}
			%>
			</table>
		<%
		} else if (pattern.equals("country")) {
			sql = "select f.title, avg(rating) as avgrating from plays f, " +
					"(select d.title, c.id from produced d, " +
					"(select a.id, b.company from players a, developers b where a.location = b.country) c " +
					"where c.company = d.company) e " +
					"where e.id = f.gamerid and f.title = e.title " +
					"group by f.title " +
					"order by f.title asc";
			r = s.executeQuery(sql);
			%>
			<p>Average ratings are 3 and above</p>
			<table>
				<tr>
					<th>title</th>
					<th>average rating</th>
				</tr>
				<%
			while (r.next()) {
				%>
				<tr>
					<td><%=r.getString("title") %></td>
					<td><%=r.getDouble("avgrating") %></td>
				</tr>
			<%
			}
			%>
			</table>
		<%
		} else {
			sql = 	"select c.title, avg(c.hours) as avghours from plays c, " +
					"(select a.title from games a where a.category like '%RPG%' or a.category like '%MMOG%') b " +
					"where b.title = c.title group by c.title order by c.title asc";
			r = s.executeQuery(sql);
			%>
			<p>Average hours are 30 and above</p>
			<table>
				<tr>
					<th>title</th>
					<th>average rating</th>
				</tr>
				<%
			while (r.next()) {
				%>
				<tr>
					<td><%=r.getString("title") %></td>
					<td><%=r.getDouble("avghours") %></td>
				</tr>
			<%
			}
			%>
			</table>
		<%
		}
		
		r.close();
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
 	</div>
</body>
</html>