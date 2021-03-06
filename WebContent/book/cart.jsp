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
				<h2>[장바구니]</h2>
				<table width=700 id="tbl">
				<tr class="title">
					<td width=100>코드</td>
					<td width=300>제목</td>
					<td width=100>단가</td>
					<td width=100>수량</td>
					<td width=100>금액</td>
				</tr>
				<c:forEach items="${listCart}" var="vo">
				<tr class="row">
					<td class="code">${vo.code}</td>
					<td class="title">${vo.title}</td>
					<td class="price">${vo.price}</td>
					<td ><input type="text" size=2 value="${vo.number}" class="number"><button>수정</button></td>
					<td>${vo.price*vo.number}</td>
				</c:forEach>
				</table>
			<!-- 여기에 출력할 내용 작성 종료 -->
			</div>
		</div>
		<div id = "footer"><jsp:include page="../footer.jsp"/></div>
	</div>
</body>
<script>
	//카트수량 수정버튼을 눌렀을때
	$("#tbl").on("click",".row button",function(){
		   var row=$(this).parent().parent();
		   var code=row.find(".code").html();
		   var number=row.find(".number").val();
		   
		   if(!confirm("수량을 수정 하시겠습니까?")) return;
		     $.ajax({
		         type:"post",
		         url:"/book/cartUpdate",
		         data:{"code":code, "number":number},
		         success:function(){
		            alert("수정되었습니다.");
		            location.href="cart.jsp"; 
		         }
		      });
	});
</script>
</html>