<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.DriverManager"%>
<html>
<head>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css"
        integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
</head>
<body>
    <jsp:include page="nav.jsp" />
   
    <div class="container">
        <div class="row">
            <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
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
                    int currentPage = 1; // 기본적으로 첫 번째 페이지를 보여줌

                    if (request.getParameter("currentPage") != null) {
                        currentPage = Integer.parseInt(request.getParameter("currentPage"));
                    }

                    int pageSize = 10; // 한 페이지에 보여줄 게시글 개수
                    int startRow = (currentPage - 1) * pageSize; // 시작 게시글 번호

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
                            String sql = "SELECT bno, title, writer, regDate, viewCnt FROM board WHERE userid = ? ORDER BY bno DESC LIMIT ?, ?";
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setString(1, (String) session.getAttribute("sessionId"));
                            pstmt.setInt(2, startRow);
                            pstmt.setInt(3, pageSize);
                        } else {
                            String sql = "SELECT bno, title, writer, regDate, viewCnt FROM board WHERE userid = ? AND title LIKE ? ORDER BY bno DESC LIMIT ?, ?";
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setString(1, (String) session.getAttribute("sessionId"));
                            pstmt.setString(2, "%" + keyword + "%");
                            pstmt.setInt(3, startRow);
                            pstmt.setInt(4, pageSize);
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
                        <td><a href="mypagedetail.jsp?bno=<%=bno%>"><%=title%></a></td>
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
        
    </div>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"
        integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>

</body>
</html>
