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
				<h2>[도서 등록]</h2>
				<table id="tbl" border=1 width=700>
					<tr class="row">
						<td class="title">코드</td>
						<td><input type="text" id="txtCode"></td>
					</tr>
					<tr class="row">
						<td class="title">제목</td>
						<td><input type="text" id="txtTitle"></td>
					</tr>
					<tr class="row">
						<td class="title">저자</td>
						<td><input type="text" id="txtWriter"></td>
					</tr>
					<tr class="row">
						<td class="title">가격</td>
						<td><input type="number" id="txtPrice"></td>
					</tr>
				</table>
				<input type="button" id="btnInsert" value="저장">
				<input type="reset" value="취소">
			<!-- 여기에 출력할 내용 작성 종료 -->
			</div>
		</div>
		<div id = "footer"><jsp:include page="../footer.jsp"/></div>
	</div>
</body>
<script>
	
   
   $("#btnInsert").on("click", function(){
	  if(!confirm("등록하시겠습니까?")) return;
	  
	  var code=$("#txtCode").val();
	  var title=$("#txtTitle").val();
	  var writer=$("#txtWriter").val();
	  var price=$("#txtPrice").val();

	  if(code==""|| title==""|| writer==""|| price==""){
		  alert("모든값을 입력해주세요!");
	  }else{
		  $.ajax({
			type:"post",
			url:"/book/insert",
			data:{"code":code,"title":title,"writer":writer,"price":price},
			dataType:"json",
			success:function(data){
				if(data.count==0){
					alert("저장되었습니다.");
					location.href="list";
				}else{
					alert("코드가 중복됩니다");
					$("#txtCode").focus();
				}
			}
		});
	  }
   });
</script>	
</html>