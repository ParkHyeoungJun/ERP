<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../includes/clientheader.jsp"%>
<style>
#canvas {
	border: 0px solid #5D5D5D;
	position: absolute;
	height: 200px;
	width: 200px;
	margin: -150px 0px 0px -200px;
	top: 50%;
	left: 50%;
	padding: 5px;
}

.col-1 {
	flex: 0 0 10.33333%;
	max-width: 10.33333%;
}

.col-11 {
	flex: 0 0 89.66667%;
	max-width: 89.66667%;
}
</style>

<input type='hidden' id="num" name="num" value="${num}" />
<input type='hidden' id="code" name="code" value="${code}" />
<input type="hidden" name="${_csrf.parameterName }"
	value="${_csrf.token}" />
<div class="card-body">
	<div class="row">
		<div class="col-lg-12">
			<h1 id="titlename" class="page-header">
				<c:out value="${v.title}"></c:out>
			</h1>
		</div>
	</div>
	<hr>
	<br>
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading"></div>
				<div class="panel-body">


					<div class="form-group row">
						<label class="control-label col-1" for="num">게시물번호</label>
						<div class="col-11">
							<label class="control-label"><c:out value='${vo.num}' /></label>
						</div>
					</div>
					<div class="form-group row">
						<label class="control-label col-1" for="title">제목</label>
						<div class="col-11">
							<label class="control-label"><c:out value='${vo.title}' /></label>
						</div>
					</div>
					<div class="form-group row">
						<label class="control-label col-1">내용</label>
						<div class="col-11">${vo.content}</div>
					</div>

					<div class="form-group row">
						<label class="control-label col-1" for="writer">작성자</label>
						<div class="col-11">
							<label class="control-label"><c:out value='${vo.writer}' /></label>
						</div>
					</div>
					<div class="form-group row">
						<label class="control-label col-1" for="day">작성일</label>
						<div class="col-11">
							<label class="control-label"><fmt:formatDate
									pattern="yyyy-MM-dd" value="${vo.day}" /></label>

						</div>
					</div>
					<div class="form-group row">
						<div class="col-lg-12">
							<div class="panel panel-default">
								<div class="panel-heading">첨부파일</div>
								<div class="panel-body">
									<div class="uploadResult">
										<ul></ul>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--             <div class="form-group row"> -->
					<!--                <label class="control-label col-1" for="updater">수정자</label> -->
					<!--                <div class="col-11"> -->
					<!--                   <input class="form-control" id="updater" name="updater" -->
					<%--                      value="<c:set var='updater' value='${vo.updater}'/><c:if test='${updater eq null}'><c:out value="-"/></c:if><c:if test='${updater ne null}'><c:out value='${vo.updater}'/></c:if>" --%>
					<!--                      readonly="readonly" /> -->
					<!--                </div> -->
					<!--             </div> -->
					<!--             <div class="form-group row"> -->
					<!--                <label class="control-label col-1" for="updatedate">수정일</label> -->
					<!--                <div class="col-11"> -->
					<!--                   <input class="form-control" id="updatedate" name="updatedate" -->
					<%--                      value="<c:set var='updatedate' value='${vo.updatedate}'/><c:if test='${updatedate eq null}'><c:out value="-"/></c:if><c:if test='${updatedate ne null}'><fmt:formatDate pattern="yyyy-MM-dd" value="${vo.updatedate}" /></c:if>" --%>
					<!--                      readonly="readonly" /> -->
					<!--                </div> -->
					<!--             </div> -->
					<br />
					<br>
					<div align="right">
						<sec:authentication property="principal" var="pinfo" />
						<sec:authorize access="isAuthenticated()">
							<c:if test="${pinfo.username eq vo.writer}">
								<button style='color: white;' class="btn btn-warning"
									id="boardModBtn">수정</button>
							</c:if>
							<button class="btn btn-success" id="boardAnswerBtn">답글
								작성</button>
							<button class="btn btn-danger" id="boardDeclarBtn">신고</button>
						</sec:authorize>
						<button class="btn btn-info" id="boardListBtn">목록</button>
					</div>
					<br>
					<br>
					<hr>
				</div>
			</div>
		</div>
		<div id='replyview' class="col-lg-12">
			<b style="font-size: 20px;" class="panel-heading">댓글</b> <br>
			<br>
			<div class="panel-body">
				<div class="form-group row">
					<div class="col-11">
						<input type="hidden" id="idx" name="idx" value="0"> <input
							class="form-control" style="height: 50px;" id="replycontent"
							name="replycontent">
					</div>
					<div class="col-1" style="padding-top: 5px;">
						<button id="btnreply" class="reply"
							style="color: white; width: 80px; height: 40px; border: none; border-radius: 5px; background-color: #343A40;"
							class="btn">저장</button>
					</div>

				</div>
			</div>
			<div class="panel-footer">
				<div class="col-11 replylist"></div>
			</div>
		</div>
	</div>
</div>
<canvas id="canvas" style="display: none"></canvas>
<script>
	// 댓글 리스트 
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	var canvas = document.getElementById("canvas");
	var ctx = canvas.getContext("2d");
	var userid = "<c:out value="${userid}"></c:out>"
	var role_admin = '<c:out value="${member.authList[0].auth}"></c:out>'
	var role_member = '<c:out value="${member.authList[1].auth}"></c:out>'
	// 진행 바 보여주기 
	function showPer(per) {
		ctx.clearRect(0, 0, 400, 400);
		//바깥쪽 써클 그리기
		ctx.strokeStyle = "#f66";
		ctx.lineWidth = 10;
		ctx.beginPath();
		ctx.arc(60, 60, 50, 0, Math.PI * 2 * per / 100);
		ctx.stroke();
		//숫자 올리기
		ctx.font = '32px serif';
		ctx.fillStyle = "#000";
		ctx.textAlign = 'center';
		ctx.textBaseline = 'middle';
		ctx.fillText(per + '%', 60, 60);
	}

	function FileList() {
		var params = {
			num : $("#num").val()
		}
		//alert(params.attachList);
		$(".uploadResult ul").empty();
		$
				.ajax({
					type : "POST",
					url : "/fileselect",
					beforeSend : function(xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					data : params,
					success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
						//alert(Object.keys(res).length)
						var str = "";
						$(res)
								.each(
										function(i, attach) {
											str += "<li data-path='";
                     str+=attach.uploadpath+"' data-uuid='";
                     str+=attach.uuid+"' data-filename='";
                     str+=attach.filename+"'><div>";
											str += "<img src='/resources/img/attach.png' width='20' height='20'>";
											str += "<span>" + attach.filename
													+ "</span><br/> ";

											str += "</div></li>";
										});
						$(".uploadResult ul").html(str);
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
						alert("통신 실패.")
					}
				});
	}
	function ReplyList() {
		var params = {
			num : $("#num").val()
		}
		//alert(params.attachList);

		$
				.ajax({
					type : "POST",
					url : "/reply/select",
					beforeSend : function(xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					data : params,
					success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
						//alert(res)
						var str = "";
						$('.replylist').empty();
						$
								.each(
										res,
										function(i, v) { //i 인덱스 , v 값
											str += "<div class='form-group row'>"
											str += "<label id='writer"+v.idx+"' class='control-label'>"
													+ v.writer + "</label>:"
											str += "<label id='lbl"+v.idx+"' class='control-label' style='width:920px;'>"
													+ v.content + "</label>"
											// 수정과 삭제는 작성자만 
											var userid = '${userid}'
											//alert(userid +","+v.writer)
											if (userid == v.writer) {
												str += "<div><button style='width:80px; color: white; background-color: #F6C23E;'"
										               str +="class='replymodfiy btn reply' data-idx="+v.idx+">수정</button>&nbsp;&nbsp;"
												str += "<button style='width:80px;color: white; background-color: #DC3545;'"
										                str +="class='replydelete btn reply' data-idx="+v.idx+">삭제</button>"
												str += "</div>"
											} else if (role_admin == "ROLE_ADMIN") {
												str += "<div><button style='width:80px;color: white; background-color: #DC3545;'"
			                                        str +="class='replydelete btn reply' data-idx="+v.idx+">삭제</button>"
												str += "</div>"
											}

											str += "</div>"
										})

						//alert(str)
						$('.replylist').append(str);
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
						alert("통신 실패.")
					}
				});

	}
	var reply = "${v.reply}"; // 댓글여부
	var answer = "${v.answer}"; // 답변여부
	var declar = "${v.declar}"; // 신고여부 

	$(document)
			.ready(
					function() {
						if (answer == "false") {
							$("#boardAnswerBtn").hide();
						}
						if (declar == "false") {
							$("#boardDeclarBtn").hide();
						}
						if (reply == "false") {
							$("#replyview")
									.html(
											'<br><b>※댓글 기능을 지원하지 않는 게시판입니다.<b/><br><br>');
						}
						ReplyList();
						FileList();
						$('#boardModBtn')
								.on(
										"click",
										function(e) {
											e.preventDefault();
											window.location.href = "/board/update?code="
													+ $("#code").val()
													+ "&num=" + $("#num").val();

										});

						$('#boardListBtn')
								.on(
										"click",
										function(e) {
											e.preventDefault();

											window.location.href = "/board/select?code="
													+ $("#code").val();
										});

						$('#boardAnswerBtn')
								.on(
										"click",
										function(e) {
											e.preventDefault();
											window.location.href = "/board/answer?code="
													+ $("#code").val()
													+ "&num=" + $("#num").val();
										});

						$("#btnreply").on(
								"click",
								function() {
									//   alert("<c:out value='${vo.writer}' />");
									$("#idx").val("0");
									if ($("#replycontent").val() == "") {
										alert("내용을 입력하여 주세요")
										return;
									}

									/////////
									var params = {
										num : $("#num").val(),
										idx : $("#idx").val(),
										content : $("#replycontent").val(),
										writer : "<c:out value='${userid}'/>"
									}
									//alert(params.attachList);

									$.ajax({
										type : "POST",
										url : "/reply/add",
										beforeSend : function(xhr) {
											xhr.setRequestHeader(
													csrfHeaderName,
													csrfTokenValue);
										},
										data : params,
										success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
											alert("저장 되었습니다");
											$("#idx").val("0");
											$("#replycontent").val("");
											ReplyList();

										},
										error : function(XMLHttpRequest,
												textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
											alert("통신 실패.")
										}
									});
									/////////
								});

						$(document)
								.on(
										"click",
										".replymodfiy",
										function(e) {
											e.preventDefault();
											var idx = $(this).data("idx");
											var content = $("#lbl" + idx)
													.text();
											if ($(this).text() == "수정") {
												$(this).text("저장");

												$("#lbl" + idx)
														.replaceWith(
																"<input class='form-control' style='width:920px;' type='textbox' id='lbl"+idx+"' value='"+content+"' />");
												//html 변경후 속성은 사라지므료 다시 속성을 줘야 함

											} else {
												if ($("#lbl" + idx).val() == "") {
													alert("내용을 입력하여 주세요")
													return;
												}
												//
												var params = {
													num : $("#num").val(),
													idx : idx,
													content : $("#lbl" + idx)
															.val(),
													writer : "<c:out value='${userid}' />"
												}
												//alert(params.attachList);

												$
														.ajax({
															type : "POST",
															url : "/reply/add",
															beforeSend : function(
																	xhr) {
																xhr
																		.setRequestHeader(
																				csrfHeaderName,
																				csrfTokenValue);
															},
															data : params,
															success : function(
																	res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
																alert("저장 되었습니다");
																content = $(
																		"#lbl"
																				+ idx)
																		.val();
																$("#lbl" + idx)
																		.replaceWith(
																				"<label class='control-label' style='width:920px;'  id='lbl"+idx+"'></label>");
																$("#lbl" + idx)
																		.val(
																				content);
																ReplyList();

															},
															error : function(
																	XMLHttpRequest,
																	textStatus,
																	errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
																alert("통신 실패.")
															}
														});
												//
											}
											//$("#idx").val($(this).attr("data-idx"));
											//alert($("#idx").val())
											////

											////
										});
						$(document).on(
								"click",
								".replydelete",
								function(e) {
									e.preventDefault();
									var ret = confirm("정말로 삭제하시겠습니다?");
									//alert($(this).attr("data-idx"))
									if (ret) {
										var params = {
											idx : $(this).attr("data-idx")
										}
										//alert(params.attachList);

										$.ajax({
											type : "POST",
											url : "/reply/delete",
											beforeSend : function(xhr) {
												xhr.setRequestHeader(
														csrfHeaderName,
														csrfTokenValue);
											},
											data : params,
											success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
												alert("삭제되었습니다");
												ReplyList();

											},
											error : function(XMLHttpRequest,
													textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
												alert("통신 실패.")
											}
										});
									} else {
										alert("취소 되었습니다")
									}
								});

						$('#boardDeclarBtn')
								.on(
										"click",
										function(e) {
											e.preventDefault();
											window.location.href = "/board/declar?code="
													+ $("#code").val()
													+ "&num=" + $("#num").val();
										});
						$(document).on(
								"click",
								".uploadResult ul li",
								function() {
									console.log("download file");

									var liObj = $(this);// 클릭된 li
									//   alert(liObj.data("path"))
									var path = encodeURIComponent("/"
											+ liObj.data("uuid"));
									var url = "/download?fileName=" + path;

									///
									$.ajax({
										url : url,
										type : 'get',
										xhrFields : { //response 데이터를 바이너리로 처리한다.
											responseType : 'blob'
										},
										beforeSend : function() { //ajax 호출전 progress 초기화
											showPer(0);
											canvas.style.display = 'block';
										},
										xhr : function() { //XMLHttpRequest 재정의 가능
											var xhr = $.ajaxSettings.xhr();
											xhr.onprogress = function(e) {
												showPer(Math.floor(e.loaded
														/ e.total * 100));
											};
											return xhr;
										},
										success : function(data) {
											console.log("완료");
											var blob = new Blob([ data ]);
											//파일저장
											if (navigator.msSaveBlob) {
												return navigator.msSaveBlob(
														blob, url);
											} else {
												var link = document
														.createElement('a');
												link.href = window.URL
														.createObjectURL(blob);
												link.download = url;
												link.click();
											}
										},
										complete : function() {
											canvas.style.display = 'none';
										}
									});
									///
								});
					});
</script>

<%@ include file="../includes/clientfooter.jsp"%>