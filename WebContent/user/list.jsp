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
				 <div id="search" >
                  <select id="key">
                     <option value="name">이름</option>
                     <option value="id">아이디</option>
                     <option value="job">직업</option>
                     <option value="tel">전화번호</option>   
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
					<td width=100>이름</td>
					<td width=200>아이디</td>
					<td width=100>직업</td>
					<td width=300>전화번호</td>
				</tr>
				{{#each array}}
				<tr class="row">
					<td>{{name}}</td>
					<td>{{id}}</td>
					<td>{{job}}</td>
					<td>{{tel}}</td>
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
			url:"/user/list.json",
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