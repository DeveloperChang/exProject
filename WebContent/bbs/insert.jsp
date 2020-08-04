<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="../home.css"/>
	<meta charset="UTF-8">
	<title>한빛 미디어</title>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
</head>
<body>
	<div id = "page">
		<div id = "header"><jsp:include page="../header.jsp"/></div>
		<div id = "center">
			<div id = "menu"><jsp:include page="../menu.jsp"/></div>
			<div id = "content">
			<!-- 여기에 출력할 내용 작성 시작 -->
				<h2>[게시판 글쓰기]</h2>
				<form action="insert" method="post" name="frm">
				<c:if test="${id==null}">
					<input type="hidden" value="guest" name="writer">
				</c:if>
				<c:if test="${id!=null}">
					<input type="hidden" value="${id}" name="writer">
				</c:if>
				<table id="tbl" border=1 width=700>
					<tr class="row">
						<td class="title">제목</td>
						<td><input type="text" name="title" size=50></td>
					</tr>
					<tr class="row">
						<td colspan=2>
							<textarea rows="10" cols="70" name="content"></textarea>
						</td>
					</tr>
				</table>
				<input type="submit" value="저장">
				<input type="reset" value="취소">
				</form>
			<!-- 여기에 출력할 내용 작성 종료 -->
			</div>
		</div>
		<div id = "footer"><jsp:include page="../footer.jsp"/></div>
	</div>
</body>
<script>
	$(frm).submit(function(){
		e.preventDefault();
		if(!confirm("저장하시겠습니까?")) return;
		
		var title=$(frm.title).val();
		var content=$(frm.content).val();
		
		if(title==""){
			alert("제목을 입력하세요");
			$(frm.title).focus();
		}else if(content==""){
			alert("내용을 입력하세요");
			$(frm.content).focus();
		}else{
			frm.submit();
		}
	})
</script>
</html>