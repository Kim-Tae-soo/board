<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@page import="java.sql.DriverManager"%>
<html>
<head>
 <link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">

<title>게시판</title>
<%
	/* 로그인시 저장했던 sessionId 가져오기 로그인 안한 상태면 sessionId==null */
	
%>

<style>
/*
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
}

h1 {
	text-align: center;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

th, td {
	padding: 10px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #f2f2f2;
}

.search-form {
	display: flex;
	margin-bottom: 20px;
}

.search-form label {
	font-weight: bold;
	margin-right: 10px;
}

.search-form input[type="text"] {
	padding: 5px;
	font-size: 14px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

.search-form input[type="submit"] {
	padding: 5px 10px;
	font-size: 14px;
	cursor: pointer;
}

.search-form input[type="submit"]:hover {
	
}

.write-btn {
	text-align: center;
}

.write-btn input[type="submit"] {
	padding: 5px 10px;
	font-size: 14px;
	cursor: pointer;
}

.write-btn input[type="submit"]:hover {
	
}
*/
</style>
</head>
<body>
<jsp:include page="nav.jsp"/>


	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
		<%
		String keyword = request.getParameter("keyword");

		String dbDriver = "com.mysql.jdbc.Driver";
		String jdbcUrl = "jdbc:mysql://192.168.50.52:3306/board";
		String jdbcUsername = "NULL";
		String jdbcPassword = "0000";

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			Class.forName(dbDriver);
			conn = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);

			if(keyword==null){
				String sql = "SELECT bno, title, writer, regDate, viewCnt FROM board";
				pstmt = conn.prepareStatement(sql);
			}else{
				String sql = "SELECT bno, title, writer, regDate, viewCnt FROM board WHERE title LIKE ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "%" + keyword + "%");
			}
			rs = pstmt.executeQuery();

			while (rs.next()) {
				int bno = rs.getInt("bno");
				String title = rs.getString("title");
				String writer = rs.getString("writer");
				Date regDate = rs.getDate("regDate");
				int viewCnt = rs.getInt("viewCnt");
		%>
		<tr>
			<td><%=bno%></td>
			<td><a href="detail.jsp?bno=<%=bno%>"><%=title%></a></td>
			<td><%=writer%></td>
			<td><%=regDate%></td>
			<td><%=viewCnt%></td>
		</tr>
		<%
		}
		} catch (Exception e) {
		e.printStackTrace();
		} finally {
		try {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
		} catch (SQLException e) {
		e.printStackTrace();
		}
		}
		%>
	</table>

	<form class="search-form" method="get" action="index.jsp">
		<label for="keyword">검색어:</label> <input type="text" id="keyword"
			name="keyword"> <input type="submit" value="검색">
	</form>

	<div class="write-btn">
		<form method="post" action="write.jsp">
			<input  class="btn btn-primary" type="button" value="글 작성" onclick = "checkLogin()">
		</form>
	</div>

</body>

<script type="text/javascript">
<%
/* 로그인시 저장했던 sessionId 가져오기 로그인 안한 상태면 sessionId==null */
String sessionId = (String)session.getAttribute("sessionId");
%>
	
function checkLogin() {	
	
	var id = '<%=sessionId%>';
	
    if (id=="null") {
    	   alert("로그인 후 글쓰기가 가능합니다.");
    	   return false;
   	 } else {
    	   location.href = "write.jsp";
   	}
}
</script>
</html> 
