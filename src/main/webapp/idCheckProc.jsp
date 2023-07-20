<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>idCheckForm.jsp</title>
</head>
<body>
   <div style="text-align: center;">
      <h3>* 아이디 중복확인 결과 *</h3>
     <%
     	String id = request.getParameter("id");
          	String checkid = null;
          
         	String dbDriver = "com.mysql.jdbc.Driver";
     		String jdbcUrl = "jdbc:mysql://192.168.50.52:3306/board";
     		String jdbcUsername = "NULL";
     		String jdbcPassword = "0000";

     		Connection conn = null;
     		PreparedStatement pstmt = null;
     		ResultSet rs = null;
     		
     		Class.forName(dbDriver);
     		conn = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);
     		
     		String sql = "SELECT id FROM member WHERE id = ?";
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, id);
             rs = pstmt.executeQuery();
             
             if (rs.next()) {
             	checkid = rs.getString("id");
             }
             
             if (checkid == null) {
             	out.println("<p>사용 가능한 아이디 입니다!!</p>");
         		out.println("<a href='javascript:sendId(\""+ id + "\")'>[적용]</a>");
     		} else {
     	out.println("<p style='color:red'>해당 아이디는 이미 사용 중 입니다.</p>");
     		}
     		rs.close();
     		pstmt.close();
     %>

   <hr>
   <a href="javascript:history.back()">[다시검색]</a>
   &nbsp;&nbsp;
   <a href="javascript:window.close()">[창닫기]</a>
  
   
   </div>
   
</body>
<script>
function sendId(check){

	opener.setId(check);

	window.close();

	}
</script>

</html>