<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.DriverManager"%>
<html>
<head>
    <title>게시글 수정 처리</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        .message {
            font-size: 24px;
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
  
    <%
    request.setCharacterEncoding("UTF-8");
    %>
    <%
    String dbDriver = "com.mysql.jdbc.Driver";
    String jdbcUrl = "jdbc:mysql://192.168.50.52:3306/board";
    String jdbcUsername = "NULL";
    String jdbcPassword = "0000";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName(dbDriver);
        conn = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);

        // 게시글 번호와 수정할 내용을 파라미터로 전달받음
        int bno = Integer.parseInt(request.getParameter("bno"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");

        // 해당 게시글 업데이트
        String updateSql = "UPDATE board SET title = ?, content = ? WHERE bno = ?";
        pstmt = conn.prepareStatement(updateSql);
        pstmt.setString(1, title);
        pstmt.setString(2, content);
        pstmt.setInt(3, bno);
        pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null)
                pstmt.close();
            if (conn != null)
                conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    %>

    
    <script>
        // INDEX 페이지로 바로 이동
        setTimeout(function() {
            window.location.href = 'index.jsp';
        }, 1000); // 1초 후에 이동 (원하는 시간으로 변경 가능)
    </script>
</body>
</html>