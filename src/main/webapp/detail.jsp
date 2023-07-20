<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*, java.io.*"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<html>
<head>
<link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<title>게시글 상세 내용</title>
<!-- 
<style>
body {
    font-family: Arial, sans-serif;
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
}

th {
    background-color: #f2f2f2;
    font-weight: bold;
}

tr:nth-child(even) {
    background-color: #f9f9f9;
}

tr:hover {
    background-color: #e5e5e5;
}

.content {
    margin-bottom: 20px;
}

.action-buttons {
    text-align: center;
    margin-top: 10px;
}

.download-link {
    display: block;
    margin-top: 10px;
}
</style>

 -->


</head>
<body>
 
    <%!
        // 서버 측에 로그인 상태를 확인하기 위한 메서드
        private boolean isUserLoggedIn(HttpSession session) {
            // 로그인한 사용자의 정보가 세션에 저장되어 있는지 확인
            return session.getAttribute("sessionId") != null;
        }
    %>
    <jsp:include page="nav.jsp"/>
    <h1>게시글 상세 내용</h1>
    <%
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
		
        //로그인 상태 확인
        boolean isUserLoggedIn = isUserLoggedIn(session);
        
        // 게시글 번호를 파라미터로 전달받음
        int bno = Integer.parseInt(request.getParameter("bno"));

        // 해당 게시글 조회수 증가
        String updateSql = "UPDATE board SET viewCnt = viewCnt + 1 WHERE bno = ?";
        pstmt = conn.prepareStatement(updateSql);
        pstmt.setInt(1, bno);
        pstmt.executeUpdate();
		
        // 해당 게시글 내용 조회
        String selectSql = "SELECT bno, title, writer, regDate, viewCnt, content, file_name, file_path FROM board WHERE bno = ?";
        pstmt = conn.prepareStatement(selectSql);
        pstmt.setInt(1, bno);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String title = rs.getString("title");
            String writer = rs.getString("writer");
            Date regDate = rs.getDate("regDate");
            int viewCnt = rs.getInt("viewCnt");
            String content = rs.getString("content");
            String fileName = rs.getString("file_name");
            String filePath = rs.getString("file_path");
            
         // 로그인한 사용자의 이름 가져오기
            String sessionId = (String) session.getAttribute("sessionId");
            String memberName = null;
            // 데이터베이스에서 member 테이블을 조회하여 회원의 이름 가져오기
            String sqlMember = "SELECT name FROM member WHERE id = ?";
            PreparedStatement pstmtMember = conn.prepareStatement(sqlMember);
            pstmtMember.setString(1, sessionId);
            ResultSet rsMember = pstmtMember.executeQuery();
            if (rsMember.next()) {
                memberName = rsMember.getString("name");
            }
            rsMember.close();
            pstmtMember.close();
            
         	// 수정과 삭제 버튼 표시 여부를 결정하는 변수
            boolean showEditButtons = isUserLoggedIn && writer.equals(memberName);
    %>
    <table class="table table-bordered">
    	<tr>
    		<th>제목 </th>
        	<td><%= title %></td>
        </tr>
        <tr>
        	<td>작성자: <%= writer %></td>
        	<td>작성일: <%= regDate %></td>
        	<td>조회수: <%= viewCnt %></td>
        </tr>

        <tr>
        	<th>내용</th>
			<td><%=content%></td>
        </tr>
        <tr>
        	<th>첨부 파일</th>
        	<%
        	if (fileName != null && !fileName.isEmpty() && filePath != null && !filePath.isEmpty()) {
    		%>
    		<td>
        		<a href="download.jsp?filePath=<%=filePath%>&fileName=<%=fileName%>"><%=fileName%></a>
    		</td>
    		<%
        	}
    		%>
        </tr>
        
    </table>
    <br>
    <br>
    <div style="display: flex; justify-content: center; gap: 10px;">
        <!-- 수정과 삭제 버튼 표시 -->
        <% if (showEditButtons) { %>
            <form method="post" action="delete.jsp">
                <input type="hidden" name="bno" value="<%=bno%>">
                <button type="submit" value="삭제" class="btn btn-danger">삭제</button>
            </form>
            <form method="post" action="modify.jsp">
                <input type="hidden" name="bno" value="<%=bno%>">
                <input type="submit" value="수정" class="btn btn-secondary" >
            </form>
        <% } %>
        <!-- 목록 버튼 -->
        <form method="post" action="index.jsp">
            <button type="submit" value="목록" class="btn btn-primary">목록</button>
            
        </form>
    </div>


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
      <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>