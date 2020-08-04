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
				<h2>[게시판목록]</h2>
				 <div id="search" >
                  <select id="key">
                     <option value="title" >제목</option>
                     <option value="content">내용</option>
                     <option value="writer">작성자</option>
                     <option value="wdate" >작성일자</option>   
                  </select>
                  <input type="text" id="word">
                  <select id="perPage">
                     <option value="5">5행씩 출력</option>
                     <option value="10">10행씩 출력</option>
                     <option value="15">15행씩 출력</option>
                  </select>
                  <input type="button" value="검색" id="btnSearch">
                  	검색건수:<span id="count"></span>                 
            	</div>
				<table id ="tbl" width=700></table>
				<script id="temp" type="text/x-handlebars-template">
				<tr class="title">
					<td width=100>No.</td>
					<td width=100>제목</td>
					<td width=300>내용</td>
					<td width=100>작성자</td>
					<td width=100>작성일</td>
				</tr>
				{{#each list}}
				<tr class="row">
					<td class="no">{{seqno}}</td>
					<td>{{title}}</td>
					<td>{{content}}</td>
					<td>{{writer}}</td>
					<td>{{wdate}}</td>
				</tr>
				{{/each}}
				</script>
			<div id="pagination">
               <button id="btnPre">←</button>
               <button id="btnNext">→</button>
               [
               <span id=spage></span>
               /
               <span id=stotPage></span>
               ]
            </div>
			<!-- 여기에 출력할 내용 작성 종료 -->
			</div>
		</div>
		<div id = "footer"><jsp:include page="../footer.jsp"/></div>
	</div>
</body>
<script>
   var key;
   var word;
   var page=1;
   var perPage;
   var totPage;
   
   getList();
   
   $("#tbl").on("click",".row",function(){
	   var no=$(this).find(".no").html();
	   location.href="read?no=" + no;
   });
   
   $("#btnPre").on("click", function(){
      page--;
      getList();
   });
   $("#btnNext").on("click", function(){
      page++;
      getList();
   });
   
   $("#btnSearch").on("click", function(){
      page=1;
      getList();
   });
   $("#word").keydown(function(key){
      if(key.keyCode==13){
         page=1;
         getList();
      }
   });
   
   $("#perPage").change(function(){
   	page=1;
       getList();    	
   });          

	
	function getList(){
		key=$("#key").val();
	    word=$("#word").val();
	    perPage=$("#perPage").val();
		$.ajax({
			type:"get",
			url:"/bbs/list.json",
			data:{"key":key,"word":word,"page":page,"perPage":perPage},
			dataType:"json",
			success:function(data){
				var temp=Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
				 $("#count").html(data.count);
		            if(data.count==0){
		               $("#pagination").hide();
		            }else{
		               $("#pagination").show();
		            }
		            if(page==1){
		               $("#btnPre").attr("disabled",true)
		            }else{
		               $("#btnPre").attr("disabled",false)
		            }
		            if(page==data.totPage){
		               $("#btnNext").attr("disabled",true)
		            }else{
		               $("#btnNext").attr("disabled",false)
		            }
		            $("#spage").html(page);
		            $("#stotPage").html(data.totPage);
		            
			}
		});
	}
</script>	
</html>