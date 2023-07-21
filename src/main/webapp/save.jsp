<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.io.output.*"%>
<%@ page import="java.sql.*, javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.MultipartConfig"%>
<%@ page import="java.io.File"%>
<%@ page import="java.sql.DriverManager"%>

<html>
<head>
<title>저장 결과</title>
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

.error {
	color: red;
	font-weight: bold;
}
</style>
</head>
<body>
	<%!
	// 서버 측에 로그인 상태를 확인하기 위한 메서드
    private boolean isUserLoggedIn(HttpSession session) {
        // 로그인한 사용자의 정보가 세션에 저장되어 있는지 확인
        return session.getAttribute("sessionId") != null;
    }
	%>
	<%
	request.setCharacterEncoding("UTF-8");

    String dbDriver = "com.mysql.jdbc.Driver";
    String jdbcUrl = "jdbc:mysql://192.168.50.52:3306/board";
    String jdbcUsername = "NULL";
    String jdbcPassword = "0000";

	Connection conn = null;
	PreparedStatement pstmt = null;

	File file;
	int maxFileSize = 5000 * 1024;
	int maxMemSize = 5000 * 1024;
	ServletContext context = pageContext.getServletContext();
	String uploadPath = "C:/eGovFrameDev-4.1.0-64bit/workspace/ipp/upload"; // 파일 저장 경로 설정

	// Verify the content type
	String contentType = request.getContentType();

	if (contentType != null && contentType.indexOf("multipart/form-data") >= 0) {
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// maximum size that will be stored in memory
		factory.setSizeThreshold(maxMemSize);

		// Location to save data that is larger than maxMemSize.
		factory.setRepository(new File("c:\\temp"));

		// Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);

		// maximum file size to be uploaded.
		upload.setSizeMax(maxFileSize);

		try {
			// Parse the request to get file items.
			List<FileItem> fileItems = upload.parseRequest(request);
			
			// Process the uploaded file items
			String fileName = "";
			String filePath = "";
			String writer = null;

			// Check if file item is not empty and process file upload
			for (FileItem fileItem : fileItems) {
				if (!fileItem.isFormField() && fileItem.getSize() > 0) {
					// Get the uploaded file parameters
					String fieldName = fileItem.getFieldName();
					fileName = fileItem.getName();
					filePath = uploadPath + "/" + fileName;
					boolean isInMemory = fileItem.isInMemory();
					long sizeInBytes = fileItem.getSize();

					// Write the file to the specified path
					fileItem.write(new File(filePath));
				}
			}

			// Save the file information to the database
			Class.forName(dbDriver);
			conn = DriverManager.getConnection(jdbcUrl, jdbcUsername, jdbcPassword);
			
			
	        if (isUserLoggedIn(session)) {
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
	            if (memberName != null) {
	                writer = memberName;
	            }
	            rsMember.close();
	            pstmtMember.close();
	        }
	        
			String sql = "INSERT INTO board (title, writer, content, file_name, file_path, userid) VALUES (?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);

			String title = "";
			String content = "";
			String userId = (String) session.getAttribute("sessionId");

			for (FileItem fileItem : fileItems) {
				if (fileItem.isFormField()) {
					String fieldName = fileItem.getFieldName();
					String fieldValue = fileItem.getString("UTF-8");
					if (fieldName.equals("title")) {
						if (fieldValue != null && !fieldValue.isEmpty()) {
							title = fieldValue;
						}
					} else if (fieldName.equals("content")) {
						if (fieldValue != null && !fieldValue.isEmpty()) {
							content = fieldValue;
						}
					}
				}
			}

			pstmt.setString(1, title);
			pstmt.setString(2, writer);
			pstmt.setString(3, content);
			pstmt.setString(4, fileName);
			pstmt.setString(5, filePath);
			pstmt.setString(6, userId);

			int rowsAffected = pstmt.executeUpdate();

			if (rowsAffected > 0) {
	%>
	<div class="message"></div>
	<%
	} else {
	%>
	<div class="message error">저장에 실패했습니다.</div>
	<%
	}
	} catch (Exception ex) {
	ex.printStackTrace();
	}
	} else {
	out.println("<html>");
	out.println("<head>");
	out.println("<title>Servlet upload</title>");
	out.println("</head>");
	out.println("<body>");
	out.println("<p>No file uploaded</p>");
	out.println("</body>");
	out.println("</html>");
	}

	try {
	if (pstmt != null)
	pstmt.close();
	if (conn != null)
	conn.close();
	} catch (SQLException e) {
	e.printStackTrace();
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