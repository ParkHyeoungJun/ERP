<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="../../includes/adminheader.jsp"%>
<style>
.checkbox {
   width: 20px; /*Desired width*/
   height: 20px; /*Desired height*/
   cursor: pointer;
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
<div class="card-body">
<div class="row">
   <div class="col-lg-12">
      <h1 id="titlename" class="page-header">
<c:out value="${v.title}"></c:out>
</h1>
   </div>
</div>

<div >
<br>
   <div class=col-lg-12>
      <div class="panel-heading"></div>
      <div class="panel-body">            
            <input type="hidden" id="pageindex" name="pageindex" value="${pageindex}" />
            <input type="hidden" id="code" name="code" value="${code}" />
            <input type="hidden" id="num" name="num" value="<c:out value='${vo.num}' />" />
            <input type="hidden" id="parentnum" name="parentnum" value="<c:out value='${vo.num}' />"/>
            <input type="hidden" id="depth" name="depth" value="<c:out value='${vo.depth}' />"/>
            
            <div class="form-group row">
               <label class="control-label col-1" for="notice">공지글</label>
               <div class="col-11">
                  <input class="checkbox" type="checkbox" id="notice" name="notice">
               </div>
            </div>
            <div class="form-group row">
               <label class="control-label col-1" for="title">제목</label>
               <div class="col-11">
                  <input class="form-control" type="text" id="title" name="title"
                     maxlength="250" value="Re:<c:out value='${vo.title}' />">
               </div>
            </div>
            <div class="form-group row">
               <label class="control-label col-1" for="con">내용</label>
               <div class="col-11">
               <textarea rows="10" cols="50" class="form-control" id="con" name="con">Re: <c:out value='${vo.content}' /></textarea>
                  
               </div>
            </div>
            <div class="form-group row">
               <label class="control-label col-1" for="writer">작성자</label>
               <div class="col-11">
                  <input class="form-control" type="text" id="writer" name="writer" disabled="disabled"
                     maxlength="20" value="<c:out value="${userid}"></c:out>">
               </div>
            </div>
            <br />
            	<div class="form-group row">
				<div class="col-lg-12">
					<div class="panel panel-default">
						<div class="panel-heading"></div>
						<div class="panel-body">
							<div class="form-group uploadDiv">
								파일 첨부 :&nbsp; <input type="file" name="uploadFile" multiple>
							</div>
							<div class="uploadResult">
								<ul style='list-style: none;'></ul>
							</div>
						</div>
					</div>
				</div>
			</div>
            <br />
            <div align="right">
            <button id="btnSave" type="button" class="btn btn-warning">답글 등록</button>
            <button id="boardListBtn" class="btn btn-info">목록</button>
            </div>
      </div>
   </div>
</div>
</div>
<canvas id="canvas" style="display: none"></canvas>
<form id="myForm"></form>
<script src="//cdn.ckeditor.com/4.17.1/standard/ckeditor.js"></script>
<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	 var canvas = document.getElementById("canvas");
	   var ctx = canvas.getContext("2d");
	var ckeditor_config = {
		resize_enaleb : false,
		enterMode : CKEDITOR.ENTER_BR,
		shiftEnterMode : CKEDITOR.ENTER_P,
		width : '100%',
		height : '400px',
		filebrowserUploadUrl : "/common/ckUpload?${_csrf.parameterName}=${_csrf.token}"
	};
</script>
<script>
	CKEDITOR.replace('con', ckeditor_config); //웹에디터
	var uploadStatus = {
		total : 0,
		count : 0
	};
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
	                              function(i, obj) {
		                               ////
		                               var fileCallPath = encodeURIComponent(obj.uploadpath
														+ "/"
														+ obj.uuid
														+ "_"
														+ obj.filename);

												var fileLink = fileCallPath
														.replace(new RegExp(
																/\\/g), "/");

												str += "<li data-ip='"+obj.ip+"' data-path='";
       										str += obj.uploadpath+"' data-uuid='";
       										str += obj.uuid+"' data-filename='";
       										str += obj.filename+"' data-type='";
       										str += obj.image+"'><div>";
												str += "<img src='/resources/img/attach.png' width='20' height='20'>";
												str += "<span>" + obj.filename
														+ "</span> ";
												str += "<b class='filedelete' data-idx='"+obj.idx;
       										str += "' data-filename='"+fileCallPath+"'>[x]</b>";
												str += "</div></li>";
		                               ////
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
	                                    str += "<label ><button   style='width:80px;color: white; background-color: #4e73df;'"
	               str +="class='replymodfiy btn reply' data-idx="+v.idx+">수정</button>&nbsp;&nbsp;"
	                                    str += "<button style='width:80px;color: white; background-color: #4e73df;'"
	                str +="class='replydelete btn reply' data-idx="+v.idx+">삭제</button>"
	                                    str += "</label>"
	                                 } else if (role_admin == "ROLE_ADMIN") {
	                                    str += "<label ><button style='width:80px;color: white; background-color: #4e73df;'"
	                                        str +="class='replydelete btn reply' data-idx="+v.idx+">삭제</button>"
	                                    str += "</label>"
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
	//alert($("#num").val())
	$(document)
			.ready(
					function(e) {
						//ReplyList();
			            //FileList();
			            
			            $(document).on(
		                        "click",
		                        ".uploadResult ul li",
		                        function() {
		                           console.log("download file");

		                           var liObj = $(this);// 클릭된 li
		                           //   alert(liObj.data("path"))
		                           var path = encodeURIComponent(liObj
		                                 .data("path")
		                                 + "/"
		                                 + liObj.data("uuid")
		                                 + "_"
		                                 + liObj.data("filename"));
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
						$('#boardListBtn')
								.on(
										"click",
										function(e) {
											e.preventDefault();

											window.location.href = "/admin/board/select?code="
													+ $("#code").val()+"&pageindex="+$("#pageindex").val();
										});

						$("#btnSave")
								.on(
										"click",
										function(e) {
											e.preventDefault();
											$("#num").val("0");
											//alert(parseInt($("#depth").val())+1)
											//return ;
											if ($("#title").val() === "") {
												alert("제목을 입력하여 주세요");
												$("#title").focus();
												return false;
											}
											if (CKEDITOR.instances['con']
													.getData() === "") {
												alert("내용을 입력하여 주세요");
												return false;
											}
											if ($("#writer").val() === "") {
												alert("작성자를 입력하여 주세요");
												$("#writer").focus();
												return false;
											}
											/// 게속 
											var $form = $("#myForm");
											if ($form.length < 1) {
												$form = $("<form/>").attr({
													id : "myForm",
													method : 'POST'
												});
												$(document.body).append($form);
											}
											$form.empty();
											$("<input></input>").attr({
												type : "hidden",
												name : "num",
												value : $("#num").val()
											}).appendTo($form);
											$("<input></input>").attr({
												type : "hidden",
												name : "code",
												value : $("#code").val()
											}).appendTo($form);

											$("<input></input>").attr({
												type : "hidden",
												name : "parentnum",
												value : parseInt($("#parentnum").val())
											}).appendTo($form);
											$("<input></input>").attr({
												type : "hidden",
												name : "depth",
												value : parseInt($("#depth").val())+1
											}).appendTo($form);

											$("<input></input>").attr({
												type : "hidden",
												name : "title",
												value : $("#title").val()
											}).appendTo($form);
											$("<input></input>").attr({
												type : "hidden",
												name : "content",
												value : CKEDITOR.instances['con']
												.getData()
											}).appendTo($form);

											$("<input></input>").attr({
												type : "hidden",
												name : "writer",
												value : $("#writer").val()
											}).appendTo($form);
											$("<input></input>").attr(
													{
														type : "hidden",
														name : "notice",
														value : $("#notice")
																.is(":checked")
													}).appendTo($form);

											var str = "";
											$(".uploadResult ul li")
													.each(
															function(i, obj) {
																var jobj = $(obj);//obj: li 배열
																console
																		.dir(jobj);
																console
																		.log("---------------");
																console
																		.log(jobj
																				.data("filename"));

																// 																 str += "<input type='hidden' name='attachList[";
																// 					                                                str += i
																// 					                                                      + "].filename' value='"
																// 					                                                      + jobj.data("filename");
																// 					                                                str += "'>";

																$(
																		"<input></input>")
																		.attr(
																				{
																					type : "hidden",
																					name : "attachList["
																							+ i
																							+ "].filename",
																					value : jobj
																							.data("filename")
																				})
																		.appendTo(
																				$form);

																// 					                                                str += "<input type='hidden' name='attachList[";
																// 					                                                str += i
																// 					                                                      + "].uuid' value='"
																// 					                                                      + jobj
																// 					                                                            .data("uuid");
																// 					                                                str += "'>";
																$(
																		"<input></input>")
																		.attr(
																				{
																					type : "hidden",
																					name : "attachList["
																							+ i
																							+ "].uuid",
																					value : jobj
																							.data("uuid")
																				})
																		.appendTo(
																				$form);
																// 																	str += "<input type='hidden' name='attachList[";
																// 					                                                str += i
																// 					                                                      + "].uploadpath' value='"
																// 					                                                      + jobj
																// 					                                                            .data("path");
																// 					                                                str += "'>";
																$(
																		"<input></input>")
																		.attr(
																				{
																					type : "hidden",
																					name : "attachList["
																							+ i
																							+ "].uploadpath",
																					value : jobj
																							.data("path")
																				})
																		.appendTo(
																				$form);

																$(
																		"<input></input>")
																		.attr(
																				{
																					type : "hidden",
																					name : "attachList["
																							+ i
																							+ "].ip",
																					value : jobj
																							.data("ip")
																				})
																		.appendTo(
																				$form);
															});

											$
													.ajax({
														type : "POST",
														url : "/admin/board/add",
														beforeSend : function(
																xhr) {
															xhr
																	.setRequestHeader(
																			csrfHeaderName,
																			csrfTokenValue);
														},
														data : $form
																.serialize(),
														success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
															alert("저장 되었습니다");
															//$("#num").val("0");

															window.location.href = "/admin/board/select?code="
																	+ $("#code")
																			.val() +"&pageindex="+$("#pageindex").val() //비동기 식 링크 넘기는 방식. 동기식은 form 액션값 바꿔서 보냄.
														},
														error : function(
																XMLHttpRequest,
																textStatus,
																errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
															//			alert(errorThrown)
														}
													});

										});

						var str = "";
						$(".uploadResult ul li")
								.each(
										function(i, obj) {
											var jobj = $(obj);//obj: li 배열
											console.dir(jobj);
											console.log("---------------");
											console.log(jobj.data("filename"));

											str += "<input type='hidden' id='attachList' name='attachList[";
											str += i + "].filename' value='"
													+ jobj.data("filename");
											str += "'>";

											str += "<input type='hidden' name='attachList[";
											str += i + "].uuid' value='"
													+ jobj.data("uuid");
											str += "'>";

											str += "<input type='hidden' name='attachList[";
											str += i + "].uploadpath' value='"
													+ jobj.data("path");
											str += "'>";

											str += "<input type='hidden' name='attachList[";
											str += i + "].ip' value='"
													+ jobj.data("ip");
											str += "'>";

										});
						$(".uploadResult ul li").append(str);

						//첨부파일
						var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
						var maxSize = 524288000; //500MB

						function checkExtension(filename, filesize) {
							if (filesize >= maxSize) {
								alert("파일 크기 초과");
								return false;
							}

							if (regex.test(filename)) {
								alert("해당 종류의 파일은 업로드 불가");
								return false;
							}
							return true;
						}

						$("input[type='file']")
								.change(
										function(e) {
											var formData = new FormData();

											///////
											//////
											var inputFile = $("input[name='uploadFile']");
											var files = inputFile[0].files;
											//지정된 정보로 접근하여 배열 형태로 리턴
											for (var i = 0; i < files.length; i++) {
												if (!checkExtension(
														files[i].name,
														files[i].size)) {
													//확장자가 걸러내야할 경우라면 더이상 처리하지 않고 종료
													return false;
												}
												formData.append("uploadFile",
														files[i]);
												//폼에 관련 정보를 추가
											}

											$
													.ajax({
														type : 'POST',
														url : '/uploadAjaxAction',
														data : formData,
														beforeSend : function(
																xhr) {
															xhr
																	.setRequestHeader(
																			csrfHeaderName,
																			csrfTokenValue);
															$("#modal").modal(
																	"show"); // 모달 창 뛰우기
															setProgress(0);
														},
														xhr : function() { //XMLHttpRequest 재정의 가능
															var xhr = $.ajaxSettings
																	.xhr();
															xhr.upload.onprogress = function(
																	e) { //progress 이벤트 리스너 추가
																var percent = e.loaded
																		* 100
																		/ e.total;
																setProgress(percent);
															};
															return xhr;
														},
														processData : false,
														contentType : false,
														dataType : 'json',
														success : function(
																result) {
															console.log(result);
															setProgress(100);
															$("#modal").modal(
																	"hide"); // 닫기
															showUploadResult(result);
														},

													});
										});
						//add게시판에 파일첨부를 했을때 목록을 보여주는 ajax

						//showUploadResult메소드
						function showUploadResult(uploadResultArr) {
							if (!uploadResultArr || uploadResultArr.length == 0) {
								return;
							}
							var uploadUL = $(".uploadResult ul");
							var str = "";
							//alert(uploadResultArr)
							$(uploadResultArr)
									.each(
											function(i, obj) {
												//alert(obj.fileName)
												var fileCallPath = encodeURIComponent(obj.uploadpath
														+ "/"
														+ obj.uuid
														+ "_"
														+ obj.filename);

												var fileLink = fileCallPath
														.replace(new RegExp(
																/\\/g), "/");

												str += "<li data-ip='"+obj.ip+"' data-path='";
         										str += obj.uploadpath+"' data-uuid='";
         										str += obj.uuid+"' data-filename='";
         										str += obj.filename+"' data-type='";
         										str += obj.image+"'><div>";
												str += "<img src='/resources/img/attach.png' width='20' height='20'>";
												str += "<span>" + obj.filename
														+ "</span> ";
												str += "<b class='filedelete' data-idx='"+obj.idx;
         										str += "' data-filename='"+fileCallPath+"'>[x]</b>";
												str += "</div></li>";
												//확장자이미지,삭제 이미지로 변경해야함.
											});
							uploadUL.append(str);
						}

						function setProgress(percent) {
							var canvas = document.getElementById("canvas");
							var ctx = canvas.getContext("2d");
							ctx.clearRect(0, 0, 400, 400);
							//바깥쪽 써클 그리기
							ctx.strokeStyle = "#f66";
							ctx.lineWidth = 10;
							ctx.beginPath();
							ctx.arc(60, 60, 50, 0, Math.PI * 2 * percent / 100);
							ctx.stroke();
							//숫자 올리기
							ctx.font = '32px serif';
							ctx.fillStyle = "#000";
							ctx.textAlign = 'center';
							ctx.textBaseline = 'middle';
							ctx.fillText(percent + '%', 60, 60);
						}

						//첨부파일 삭제
						$(document).on(
								"click",
								".filedelete",
								function(e) {
									var filename = $(this).data("filename")
									var targetLi = $(this).closest("li");// 첨부파일 목록을 지우기 위해서 지정
									///
									$.ajax({
										url : '/deleteFile',
										beforeSend : function(xhr) {
											xhr.setRequestHeader(
													csrfHeaderName,
													csrfTokenValue);
										},

										data : {
											filename : filename
										},
										type : 'POST',
										success : function(result) {
											alert(result);
											targetLi.remove();
										}
									});
									///
								});

						$(document).ajaxComplete(function() {
							$("#canvas").attr("style.display", "none");
						});
					});
</script>


<%@ include file="../../includes/adminfooter.jsp"%>