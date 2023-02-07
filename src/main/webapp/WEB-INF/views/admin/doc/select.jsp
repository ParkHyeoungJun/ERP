<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../../includes/adminheader.jsp"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/themes/default/style.min.css" />

<style>
.left {
	margin-left: 20px;
	width: 500px;
	height: 400px;
	border: 1px solid blue;
	border-radius: 10px;
}

.center {
	width: 150px;
	height: 400px;
}

.right {
	padding-left: 20px;
	width: 500px;
	height: 400px;
	border: 1px solid blue;
	border-radius: 10px;
}
.modal-body {
   
    max-width:calc(800px);
	max-height: calc(300px);
	overflow-y: scroll;
}
</style>
<div class=col-lg-12>
	<div class="panel-heading">
	<p><p>
	</div>
	<div class="panel-body">
		<div class="form-group row">
			<label for="num">프로젝트 번호</label> <input id="num" name="num"
				placeholder="프로젝트번호" disabled="disabled"> <label
				class="control-label" for="num">프로젝트 명</label> <input id="title"
				name="title" placeholder="프로젝트명" disabled="disabled">
			<button id="btnProject" style="color: white; background-color: #4e73df;">프로젝트 검색</button>
		</div>
		<div class="form-group row">
			<div class="left">
				<!--  트리 메뉴 영엳 -->
				<div id="jstree">
					<!-- in this example the tree is populated from inline HTML -->
					<ul>
						<li id="root1">Root1</li>
						<!-- 						<li data-jstree='{"icon":"/resources/img/file.gif"}'>Root2</li> -->
					</ul>
				</div>

				<!--  트리 메뉴 영역 -->
			</div>
			<div class="center"></div>
			<div class="right">
				<div class="panel panel-default">
					<div class="panel-heading"></div>
					<div class="panel-body">
						<div class="form-group row">
							<label class="control-label" for="num">파일명</label> <input
								style="width: 430px" class="form-control" id="filename"
								name="filename">
								
							<input type="hidden" id="idx" name="idx" value="0" >
								<!--  파일인지 폴더 인지 구분 folder,file -->
							<input type="hidden" id="filetype" name="filetype" value="folder">
							<!--  파일이라면 업로드 된 경로  -->
							<input type="hidden" id="uuid" name="uuid" >
							<!-- 부모 시퀀스 저장  -->
							<input type="hidden" id="prentidx" name="prentidx" >
							<!-- 깊이 저장 첫번째 알아 오기위함 0이라면 첫번째  -->
							<input type="hidden" id="depth" name="depth" >
						</div>
						<div class="form-group row">
							<label class="control-label" for="num">파일 첨부:</label> <input
								type="file" name="uploadFile" multiple>
							<div class="uploadResult">
								<ul style='list-style: none;'></ul>
							</div>
						</div>
						<div class="form-group row">
							<button class="btn btn-warning" id="btnCreate">생성</button>
							<button class="btn btn-success" id="btnSave">저장</button>
							<button class="btn btn-danger" id="btnDelte">삭제</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jstree/3.2.1/jstree.min.js"></script>
<script>
	function ProjectSelect(num, title) {
		title=title.replace("__"," ");
		$("#num").val(num);
		$("#title").val(title);
	}
    
	function Save(prentidx,filename,depth)
	{
		//저정 로직
		var params = {
				idx : $("#idx").val(),
				filetype : $("#filetype").val(),
				filename : filename,
				uuid : $("#uuid").val(),
				prentidx : prentidx,
				depth : depth,
				idx : $("#idx").val()
			}
			//
			$.ajax({
				type : "POST", // HTTP method type(GET, POST) 형식이다.
				url : "/admin/doc/add", // 컨트롤러에서 대기중인 URL 주소이다.
				beforeSend : function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data : params, // Json 형식의 데이터이다.
				success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
					// 응답코드 > 0000
					// 
					alert("저장 되었습니다");
					$("#idx").val("0"); // 입력 모드
					
					//     
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
					alert("통신 실패.")
				}
			});
		//저장 로직 
	}
	
	function List(prentidx,depth)
	{
		
	}
	
	
	$(document).ready(
			function() {
				$('#jstree').jstree();
				$('#jstree').jstree(true).select_node('root1');

				$("#btnProject").on(
						"click",
						function() {
							window.open("/admin/doc/projectselect",
									"DescriptiveWindowName",
									"left=100,top=100,width=850,height=400");
						});
				
				/// 폻더 생성 
				$("#btnCreate").on("click",function(){
					var ref = $('#jstree').jstree(true),
					sel = ref.get_selected();
					if(!sel.length) { alert("선택된 행이 없습니다") }
					var sel = ref.create_node(sel, {"type":"folder"});
					alert(sel)
					if(sel) {
						ref.edit(sel);
					}
				});
				
				//
				$("#btnSave").on("click",function(){
					if($("#filetype").val()=="folder")
					{
						if($("#filename").val() =="")
						{
							alert("파일명을 입력하여 주세요")
							return ;
						}
						
					}
						Save(0,$("#filename").val(),0)
				})
			});
</script>

<%@ include file="../../includes/adminfooter.jsp"%>