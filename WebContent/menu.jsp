<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${id==null}">
	<div class="login">
		<jsp:include page="/user/login.jsp"/>
	</div>
</c:if>
<c:if test="${id!=null}">
	<div class="logout">
		<div>안녕하세요 ${name}님</div>
		<button onClick="location.href='/user/logout'">로그아웃</button>
	</div>
</c:if>
<div class="item"><a href="/index.jsp">회사소개</a></div>
<div class="item"><a href="/book/list">도서정보</a></div>
<div class="item"><a href="/book/insert">도서등록</a></div>
<div class="item"><a href="/bbs/insert">게시판 글쓰기</a></div>
<div class="item"><a href="/bbs/list">게시판 긁읽기</a></div>
<div class="item"><a href="/user/list">회원목록</a></div>
<div class="item"><a href="/book/cart">장바구니</a></div>
