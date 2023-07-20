<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@page import="java.sql.DriverManager"%>
<html>
<head>
<title>게시판</title>

<!-- CSS STYLE -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
	integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct"
	crossorigin="anonymous"></script>

</head>
<body>

	<%
	/* 로그인시 저장했던 sessionId 가져오기 로그인 안한 상태면 sessionId==null */
	String sessionId = (String) session.getAttribute("sessionId");
	%>
	<nav class="navbar navbar-expand navbar-dark bg-dark">
		<div class="container">

			<div>
				<div class="navbar-nav mr-auto">
					<c:choose>
						<c:when test="${empty sessionId }">
							${sessionId==null}
							<li class="nav-item"><a class="nav-link"
								href="<c:url value='login.jsp'/>">로그인</a></li>
							<li class="nav-item"><a class="nav-link"
								href="<c:url value='addMember.jsp'/>">회원가입</a></li>
						</c:when>
						<c:otherwise>
							<li style="padding-top: 7px; color: white;">[<%=sessionId%>님]
							</li>
							<li class="nav-item"><a class="nav-link"
								href="<c:url value='logout.jsp'/>">로그아웃</a></li>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</nav>

<!-- 검색창 -->
	<div class="container mt-5">
		<form class="search-form" method="get" action="index.jsp">
			<div class="form-group row">
				<label for="keyword" class="col-sm-2 col-form-label"></label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="keyword" name="keyword"
						placeholder="제목으로 검색하세요">
				</div>
				<div class="col-sm-4">
					<button type="submit" class="btn btn-primary">검색</button>
				</div>
			</div>

		</form>
	</div>

	<div class="container">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
						<th style="background-color: #eeeeee; text-align: center;">조회수</th>
					</tr>
				</thead>
				<tbody>

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

						if (keyword == null) {
							String sql = "SELECT bno, title, writer, regDate, viewCnt FROM board";
							pstmt = conn.prepareStatement(sql);
						} else {
							String sql = "SELECT bno, title, writer, regDate, viewCnt FROM board WHERE title LIKE ?";
							pstmt = conn.prepareStatement(sql);
							pstmt.setString(1, "%" + keyword + "%");
						}
						rs = pstmt.executeQuery();

						while (rs.next()) {
							int bno = rs.getInt("bno");
							String title = rs.getString("title");
							String writer = rs.getString("writer");
							String regDate = rs.getString("regDate");
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
				</tbody>
			</table>
		</div>
    <div class="d-flex justify-content-end">
        <button type="button" class="btn btn-secondary" onclick="checkLogin()">글 작성</button>
    </div>
	</div>
</body>

<script src="js/bootstrap.js"></script>

<script type="text/javascript">
function checkLogin() {	
	var id = '<%=sessionId%>';
		if (id == "null") {
			alert("로그인 후 글쓰기가 가능합니다.");
			return false;
		} else {
			location.href = "write.jsp";
		}
	}
</script>
</html>

