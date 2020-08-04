<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
				<h2>[게시글 읽기]</h2>
				<div>[제목]:${vo.title}</div>
				<div>[작성일자]:${vo.wdate}</div>
				<div>[작성자]:${vo.writer}</div>
				------------------------------------------------------<br>
				${vo.content}
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