   <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	
		/* 로그인시 저장했던 sessionId 가져오기 로그인 안한 상태면 sessionId==null */
	String sessionId = (String)session.getAttribute("sessionId");
%>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="index.jsp">JSP 게시판</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="main.jsp">메인 <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="index.jsp">게시판</a>
      </li>
      
      <%
					if(sessionId == null){
			%>
      <li class="nav-item dropdown">
       <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">
          접속하기
        </a>
 
        <div class="dropdown-menu">
          <a class="dropdown-item" href="login.jsp">로그인</a>
          <a class="dropdown-item" href="join.jsp">회원가입</a>
        </div>
      </li>
      
      <%
				// 로그인이 되어 있는 상태에서 보여주는 화면
				}else{
			%>
				
      <li class="nav-item dropdown">
       <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">
          회원관리
        </a>
 
        <div class="dropdown-menu">
          
          <a style="text-align :center;" href="logout.jsp">로그아웃</a>
        </div>
      </li>
        <%
				}
			%>
			      
      </ul>
			</div>
      
</nav>