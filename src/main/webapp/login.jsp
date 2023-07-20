<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
 <link href="bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="nav.jsp"/>
<div class="jumbotron">
	<div style="text-align :center;" class="container">
		<h1 >로그인</h1>
	</div>
</div>
<div class="container" align="center">
	<div>
		<h3 class="form-signin-heading">Please sign in</h3>
		<%
			String error = request.getParameter("error");
			if(error!=null){
				out.print("<div class='alert alert-danger'>");
				out.print("아이디와 비밀번호를 확인해주세요.");
				out.print("</div>");
			}
		%>
		<div class="jumbotron" style="padding-top: 20px;">
		<form class="form-signin" action="processLoginMember.jsp" method="post">
			<div class="form-group">
				<label class="sr-only">User Name</label>
				<input name="id" class="form-control" placeholder="ID" required autofocus>
			</div>
			<div class="form-group">
				<label class="sr-only">Password</label>
				<input type="password" name="password" class="form-control" placeholder="Password" required>
			</div>
			<button class="btn btn-primary" type="submit">로그인</button>
			<button class="btn btn-info" type="button" onclick="location.href='addMember.jsp'">회원가입</button>
		</form>
	</div>
</div>
</div>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>