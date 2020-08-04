<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="../home.css"/>
	<meta charset="UTF-8">
	<title>한빛 미디어</title>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
</head>
<body>
	<div id = "page">
		<div id = "header"><jsp:include page="../header.jsp"/></div>
		<div id = "center">
			<div id = "menu"><jsp:include page="../menu.jsp"/></div>
			<div id = "content">
			<!-- 여기에 출력할 내용 작성 시작 -->
				<h2>[유저목록]</h2>
				 <form name="ufrm">
				 	<table width=500>
				 		<tr class="row">
				 			<td class="title">아이디</td>
				 			<td><input type="text" name="id"></td>
				 		</tr>
				 		<tr class="row">
				 			<td class="title">비밀번호</td>
				 			<td><input type="password" name="password"></td>
				 		</tr>
				 		<tr class="row">
				 			<td class="title">이름</td>
				 			<td><input type="text" name="name"></td>
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
	$(ufrm).submit(function(e){
		e.preventDefault();
		if(!confirm("저장하시겠습니까?")) return;
		var id = $(ufrm.id).val();
		var password = $(ufrm.password).val();
		var name = $(ufrm.name).val();
		if(id==""||password==""||name==""){
			alert("모든 데이터를 입력하세요");
		}else{
			$.ajax({
				type:"post",
				url:"/user/insert",
				data:{"id":id,"password":password,"name":name},
				dataType:"json",
				success:function(data){
					if(data.count==0){
						alert("등록되었습니다.");
						location.href="/user/list";
					}else{
						alert("이미 등록된 회원입니다.");
						$(ufrm.id).focus();
					}
				}
			})
		}
	})
</script>	
</html>