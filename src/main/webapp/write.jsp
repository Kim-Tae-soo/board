<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.DriverManager"%>
<html>
<head>
<title>글 작성</title>
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

														<!-- psh 여기부터 -->
	<div class="container" style="padding-top: 20px;">
		<div class="row">
			<div class="table-responsive">
				<form action="save.jsp" method="post" enctype="multipart/form-data"
					onsubmit="return confirm('게시글을 저장하시겠습니까?')">
					<table class="table table-stripped"
						style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="2"
									style="background-color: #eeeeee; text-align: center;">글
									작성</th>
							</tr>
						</thead>

						<tbody>
							<tr>
								<td><input type="text" class="form-control"
									placeholder="제목" name="title" id="title"></td>
							</tr>

							<tr>
								<td><textarea class="form-control" placeholder="내용"
										name="content" id="content" style="height: 350px"></textarea></td>
							</tr>


							<tr>
								<td><input type="file" class="custum-file"
									placeholder="파일선택" name="file" id="file"></td>
							</tr>
						</tbody>
					</table>
					<div class="d-flex justify-content-end">
						<input type="submit" class="btn btn-primary" value="저장">
					</div>
				</form>
				<form method="post" action="index.jsp">
					<input type="submit" class="btn btn-secondary"
						style="position: relative; top: -54px;" value="돌아가기">
				</form>
			</div>
		</div>
	</div>
																<!-- psh 여기까지 -->
</body>
</html>
