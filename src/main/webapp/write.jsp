<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.DriverManager"%>
<html>
<head>
<title>글 작성</title>

<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
</head>
<body>
<jsp:include page="nav.jsp"/>
<nav class="navbar navbar-light bg-light">
  <span class="navbar-brand" style="margin-left : 20px"><h3>게시글 작성</h3></span>
</nav>
    
    <div style="margin: 50px; margin-top : 30px" >
    
    <form action="save.jsp" method="post" enctype="multipart/form-data">
        <label for="title">제목:</label>
        <input class="form-control" type="text" name="title" id="title" required/>
		<br>
        <label for="content">내용:</label>
        <textarea class="form-control" name="content" id="content" rows="5" cols="50" required></textarea>
		<br>
        <label for="file">파일 선택:</label>
        <input class="form-control-file " type="file" name="file" id="file" />
		<br>
        <input class="btn btn-primary" type="submit" value="저장" />
    </form>
    <form method="post" action="index.jsp">
        <input type="submit" value="돌아가기">
    </form>
            </div>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
</body>
</html>