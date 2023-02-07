<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- jstl core 쓸때 태그에 c 로 표시. -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- jstl fmt 쓸때 위와 같음. fmt : formatter 형식 맞춰서 표시 -->
<%@ include file="includes/clientheader.jsp"%>
<style>
.btn-primary {
	border: none;
	background-color: #343A40;
}

.btn-primary:hover {
	border: none;
	background-color: #FFC107;
}
</style>
<header>
	<div id="carouselExampleIndicators" class="carousel slide"
		data-ride="carousel">
		<ol class="carousel-indicators">
			<li data-target="#carouselExampleIndicators" data-slide-to="0"
				class="active"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
		</ol>
		<div class="carousel-inner" role="listbox"></div>
		<a class="carousel-control-prev" href="#carouselExampleIndicators"
			role="button" data-slide="prev"> <span
			class="carousel-control-prev-icon" aria-hidden="true"></span> <span
			class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>
	<br>
	<br>
</header>


<a id="chat" style="position: fixed; bottom: 80px; right: 20px;"
	title="채팅"><img src='/resources/img/chat.png' style='width: 50px;'></a>


<a style="display: scroll; position: fixed; bottom: 20px; right: 20px;"
	href="#" title="맨위로"> <img src='/resources/img/top.png'
	style='width: 50px;'></a>

<!-- Page Content -->

<div>
	<h2 class="my-4">게시판</h2>

	<!-- Marketing Icons Section -->
	<div style='width: 48%; float: left;'>
		<div>
			<div style='font-weight: bold; font-size: 20px;' class="card-header">
				공지사항 <input type="hidden" id='notice-code' value='0'> <a
					href="/board/select" id="notice" class="btn btn-primary"
					style="font-size: 15px; float: right; height: 35px;">More...</a>

			</div>


			<div class="card-body">
				<div id='notice-con' class="card-text" style="height: 150px;"></div>
			</div>
			<div class="card-footer" style="height: 50px;"></div>
		</div>
	</div>
	<div style='width: 4%; float: left;'>&nbsp;</div>

	<div style='width: 48%; float: left;'>
		<div>
			<div style='font-weight: bold; font-size: 20px;' class="card-header">
				자유게시판 <input type="hidden" id='free-code' value='0'> <a
					href="/board/select" id="free" class="btn btn-primary"
					style="font-size: 15px; float: right; height: 35px;">More...</a>
			</div>


			<div class="card-body">
				<div id='free-con' class="card-text" style="height: 150px;"></div>
			</div>
			<div class="card-footer" style="height: 50px;"></div>


			<!-- 코드 맞춰서 넣기 -->

		</div>
	</div>
</div>
<br>
<div>&nbsp;</div>

<sec:authorize access="isAuthenticated()">
	<div>
		<h2 class="my-4">프로젝트</h2>

		<!-- Marketing Icons Section -->
		<div style='width: 48%; float: left;'>
			<div>

				<div style='font-weight: bold; width: 1110px; font-size: 20px;'
					class="card-header">
					프로젝트 일정<a href="/board/project" id="pro" class="btn btn-primary"
						style="font-size: 15px; float: right; height: 35px;">More...</a>
				</div>
				<div class="card-body">
					<div class="card-text" id='pro-con'
						style="height: 200px; width: 1060px;"></div>
				</div>
				<div class="card-footer" style="height: 50px; width: 1110px;"></div>





			</div>
		</div>
	</div>
</sec:authorize>
<br>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>

<sec:authorize access="isAuthenticated()">
	<div>
		<div style='width: 48%; display: inline-block;'>
			<h2 class="my-4">사원 실적</h2>

			<!-- Marketing Icons Section -->
			<div style='display: inline-block;'>
				<div
					style='background-color: #00000008; border-radius: 10px; width: 500px; height: 300px; display: table-cell; vertical-align: middle;'>
					<div style="text-align: center;">
						<div>
							<span style="font-size: 17px;" id='fpspan'>이달의 최우수 사원: </span><span
								style="font-size: 20px;"><b id='firstper'></b></span>
						</div>
						<br>
						<div>
							<span style="font-size: 17px;" id='fdspan'>이달의 최우수 부서: </span><span
								style="font-size: 20px;"><b id='firstdept'></b></span>
						</div>
					</div>
				</div>
				<div style='width: 500px; height: 220px; padding-top: 10px;'>
					<a href="/clientcharts" class="btn btn-primary"
						style="float: right; height: 35px;">Move</a>
				</div>
			</div>
			<br>
			<div id='board-footer'></div>

		</div>

		<div style='width: 3%; display: inline-block;'>&nbsp;</div>

		<div style='width: 48%; display: inline-block;'>
			<h2 class="my-4" style='width: 70%; display: inline-block;'>스케쥴
				캘린더</h2>
			<div style='width: 25%; display: inline-block;'>
				<a href="/board/calendar" class="btn btn-primary"
					style="float: right; height: 35px;">자세히 보기 ></a>
			</div>
			<!-- Marketing Icons Section -->

			<div id="calendar">
				<iframe src="/board/calendarview" name="캘린더" width="500px"
					height="500px" style='overflow: hidden; border: 0;'>
				</iframe>
			</div>

			<br>
			<div id='board-footer'></div>

		</div>

	</div>
</sec:authorize>


<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>




<script>
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";

	function MainBanner() {//메인 배너
		$
				.ajax({
					type : "POST", // HTTP method type(GET, POST) 형식이다.
					url : "/admin/mainbanner/select", // 컨트롤러에서 대기중인 URL 주소이다.
					beforeSend : function(xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
						// 응답코드 > 0000
						var str = "";
						var liststr = '';//배너 수가 늘어나면 아래 클릭버튼 수 같이 늘어나게
						var arr = new Array();
						var linkarr = new Array();

						$.each(res, function(i, v) {
							arr[i] = getImage(v.image);
							linkarr[i] = v.link;

						})

						if (linkarr[0] == null) {//링크를 설정하지 않았을 경우
							str += '<div class="carousel-item active"';
							str += ' style="background-position: center; background-image: url('
									+ "'" + arr[0] + "'" + ')">';
							str += '</div>';
						}
						if (linkarr[0] != null) {//링크를 설정했을 경우, 이미지 클릭하면 링크로 이동
							str += '<div class="carousel-item active" onclick="';
							str += "location.href='" + linkarr[0] + "';";
							str += '" style="background-position: center;';
							str += 'background-image: url(' + "'" + arr[0]
									+ "'" + ')">';
							str += '</div>';
						}

						for (var i = 1; i < arr.length; i++) {
							if (linkarr[i] == null) {
								str += '<div class="carousel-item"';
								str += ' style="background-position: center; background-image: url('
										+ "'" + arr[i] + "'" + ')">';
								str += '</div>';
							}
							if (linkarr[i] != null) {
								str += '<div class="carousel-item" onclick="';
								str += "location.href='" + linkarr[i] + "';";
								str += '" style="background-position: center;';
								str += 'background-image: url(' + "'" + arr[i]
										+ "'" + ')">';
								str += '</div>';

							}
							if (i > 2) {
								liststr += '<li data-target="#carouselExampleIndicators" data-slide-to="';
                liststr += i+'"></li>';
							}

						}
						$(".carousel-inner").append(str);
						$("#carouselExampleIndicators ol").append(liststr);

						if (Object.keys(res).length === 0) { //데이터가 없을 경우
							$(".carousel-inner").empty();
							str += "<div style='text-align:center; padding-top:100px; font-size:200px;'>No Banner</div>";
							str += "<div style='text-align:center; font-size:30px;'>배너를 등록해주세요</div>";
							$(".carousel-inner").append(str);
						}

					},
					error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
						alert("통신 실패.")
					}
				});

	}

	function getImage(image) {
		return image.replace(/\\/g, "/");
	}

	function BList() {// 게시판에 따른 더 보기 버튼 연동
		$.ajax({
			type : "POST", // HTTP method type(GET, POST) 형식이다.
			url : "/admin/boardadmin/listajax", // 컨트롤러에서 대기중인 URL 주소이다.
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);

			},
			success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
				var fstr = "";
				var nstr = "";

				var arr = new Array();
				var codearr = new Array();

				var free = document.getElementById("free");
				var notice = document.getElementById("notice");

				$.each(res, function(i, v) { //i 인덱스 , v 값
					arr[i] = v.title;
					codearr[i] = v.code;//원하는 게시판의 코드값 담기  
				})

				for (var i = 0; i < arr.length; i++) {
					if (arr[i] == '자유게시판') {

						fstr += "/board/select?code=" + codearr[i] + "";
						free.href = fstr;

						$("#free-code").val(codearr[i]);//code값 html에 저장

						List(codearr[i], '#free-con');
						//alert("코드:"+codearr[i]);
					}
					if (arr[i] == '공지사항') {
						nstr += "/board/select?code=" + codearr[i] + "";
						notice.href = nstr;
						$("#notice-code").val(codearr[i]);
						List(codearr[i], "#notice-con");
					}
				}

			},
			error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
				alert("통신 실패.")
			}
		});
	}

	function List(code, con) {//게시판 내용 불러오기
		var params = {
			pageNum : '1',
			amount : '5',
			type : 'T',
			keyword : '',
			code : code
		}

		$
				.ajax({
					type : "POST", // HTTP method type(GET, POST) 형식이다.
					url : "/board/select", // 컨트롤러에서 대기중인 URL 주소이다.
					beforeSend : function(xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);

						$('#load').show();
						// 화면의 중앙에 위치하도록 top, left 조정 (화면에 따라 조정 필요)
						$("#hiddenDivLoading").show()
								.css(
										{
											top : $(document).scrollTop()
													+ ($(window).height())
													/ 2.6 + 'px',
											left : ($(window).width()) / 2.6
													+ 'px'
										});
					},
					data : params, // Json 형식의 데이터이다.
					success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
						//alert(Object.keys(res).length)

						$(con).empty();
						$(con)
								.append(
										"<thead><th width='15%'>번호</th><th width='70%'>제목</th><th width='15%'>작성자</th></thead>")
						var str = "";

						$
								.each(
										res,
										function(i, v) { //i 인덱스 , v 값
											//alert(v.cnt)

											str += "<tr onmouseover=this.style.background='#f5f2f2' onmouseout=this.style.background='white'>";
											if (v.notice == true) {

												str += "<td style='color:green;'>"
														+ v.num + "</td>"
												str += '<td><a style="color:green;" href=/board/get?code='
														+ v.code
														+ "&num="
														+ v.num
														+ " class='move'>";
												str += getDepth(v.depth,
														v.title)
														+ '</a>';
												str += getReplycnt(v.replycnt,
														v.daytostring)
														+ '</td>';
												str += '<td style="color:green;">'
														+ v.writer + '</td>';
											} else {
												str += "<td>" + v.num + "</td>"
												str += '<td><a href=/board/get?code='
														+ v.code
														+ "&num="
														+ v.num
														+ " class='move'>";
												str += getDepth(v.depth,
														v.title)
														+ '</a>';
												str += getReplycnt(v.replycnt,
														v.daytostring)
														+ '</td>';
												str += '<td>' + v.writer
														+ '</td>';
											}

											str += '</tr>'
										})
						$(con).append(str);

						if (Object.keys(res).length === 0) { //데이터가 없을 경우
							$(con).empty();
							str += "<tr><td colspan=4 style='text-align: center;'>검색된 데이터가 없습니다</td></tr>"
							$(con).append(str);
						}

					},
					error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
						// alert("통신 실패.")
					}
				});

	}

	// depth가 0 이면 그냥 제목만 아님 depth 만큼 깊이 구현 해주고 이미지 구현
	function getDepth(depth, title) {
		var str = "";
		if (depth == 0) {
			return title;
		} else {
			for (var i = 0; i < depth; i++) {
				str += "&nbsp;&nbsp;";
			}
			str += "<img src='/resources/img/re.gif' />"
			str += title;
		}

		return str;
	}

	function getReplycnt(replycnt, daytostring) {
		var str = '';
		if (replycnt != 0) {

			str += '<span style="color: red;">&nbsp;[';
			str += replycnt + ']</span>';

		}
		var today = new Date();

		var year = today.getFullYear(); // 년도
		var month = today.getMonth() + 1; // 월
		var date = today.getDate(); // 날짜

		var newboard = year + '-' + month + '-' + date;

		if (daytostring == newboard) {//오늘 올린 글이면 new 뜨게하기
			str += '<span style="color: red;">&nbsp;';
			str += 'new </span>';
		}
		return str;
	}

	function PList() {//프로젝트 게시판 내용 불러오기

		var params = {
			pageNum : '1',
			amount : '5',
			type : 'T',
			keyword : '',
			num : '',
			btnDaySearch1 : '',
			btnDaySearch2 : ''
		}

		$
				.ajax({
					type : "POST", // HTTP method type(GET, POST) 형식이다.
					url : "/admin/projectadmin/select", // 컨트롤러에서 대기중인 URL 주소이다.
					beforeSend : function(xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);

						$('#load').show();
						// 화면의 중앙에 위치하도록 top, left 조정 (화면에 따라 조정 필요)
						$("#hiddenDivLoading").show()
								.css(
										{
											top : $(document).scrollTop()
													+ ($(window).height())
													/ 2.6 + 'px',
											left : ($(window).width()) / 2.6
													+ 'px'
										});
						$("#hiddenDivLoading").show();
					},
					data : params, // Json 형식의 데이터이다.
					success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.
						// 응답코드 > 0000
						//alert(res);

						$('#pro-con').empty();
						$('#pro-con')
								.append(
										"<thead><th width='5%'>번호</th><th width='60%'>프로젝트명</th><th width='30%'>기간</th><th width='20%'>작성자</th><th width='20%'>&nbsp;</th></thead>")
						var str = "";

						$
								.each(
										res,
										function(i, v) { //i 인덱스 , v 값

											str += "<tr onmouseover=this.style.background='#f5f2f2' onmouseout=this.style.background='white'>";
											str += '<td>' + v.num + '</td>';
											str += '<td>'
													+ '<a href=/board/projectget?num='
													+ v.num + ' class="move">';
											str += getProgress(v.title,
													v.daytostring, v.endday,
													v.progress)
													+ '</a></td>';
											str += '<td>' + v.startday + " ~ "
													+ v.endday + '</td>';
											str += '<td>' + v.writer + '</td>';

											str += '</tr>'
										})

						$('#pro-con').append(str);

						if (Object.keys(res).length == 0) { //데이터가 없을 경우
							$('#pro-con').empty();
							str += "<tr><td colspan=7 style='text-align: center;'>검색된 데이터가 없습니다</td></tr>"
							$('#pro-con').append(str);
						}
					},
					error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
						alert("통신 실패.")
					}
				});
	}

	function getProgress(title, daytostring, endday, progress) {
		var now = new Date();

		var year = now.getFullYear();
		var month = now.getMonth();
		var date = now.getDate();

		var sys = new Date(year, month, date);
		var start = new Date(daytostring)
		var end = new Date(endday)

		var maxgap = end.getTime() - start.getTime();
		var max = Math.ceil(maxgap / (1000 * 60 * 60 * 24));
		var valgap = sys.getTime() - start.getTime();
		var val = Math.ceil(valgap / (1000 * 60 * 60 * 24));

		if (max < 0) {//등록일 이전 날짜를 마감날짜로 선택했을 경우
			var max = 1;
		}

		var per = Math.ceil(val / max * 100);

		if (per > 100) {
			var per = 100
		}

		if (progress == true) {
			return title
					+ "<p style='color:#4E73DF; width:30%; float:right;'><progress style='width:50%;' max='"
					+ max + "' value='" + max
					+ "'></progress><b style='width:50%;'>&nbsp;&nbsp;"
					+ "100 %" + "&nbsp;&nbsp;</b></p>";
		} else {

			return title
					+ "<p style='color:red; width:30%; float:right;'><progress style='width:50%;' max='"
					+ max + "' value='" + val
					+ "'></progress><b style='width:50%;'>&nbsp;&nbsp;" + per
					+ " %" + "&nbsp;&nbsp;</b></p>";
		}
	}

	function Mfp() {//이번달 최우수 사원
		$.ajax({
			type : "POST",
			url : "/member/mfirstper",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.   

				var str = '';

				$.each(res, function(i, v) {
					str += v.username + " (id: " + v.userid + ")";
				})

				$("#firstper").append(str);

				if (Object.keys(res).length == 0) { //데이터가 없을 경우
					$('#firstper').empty();
					$('#firstper').append("-");
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
				alert("통신 실패.")
			}
		});
	}

	function Mfd() {//이번달 최우수 부서
		$.ajax({
			type : "POST",
			url : "/member/mfirstdept",
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success : function(res) { // 비동기통신의 성공일경우 success콜백으로 들어옵니다. 'res'는 응답받은 데이터이다.

				$.each(res, function(i, v) {

					$("#firstdept").append(v.dept);
				})

				if (Object.keys(res).length == 0) { //데이터가 없을 경우
					$('#firstdept').empty();
					$('#firstdept').append("-");
				}

			},
			error : function(XMLHttpRequest, textStatus, errorThrown) { // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
				alert("통신 실패.")
			}
		});

	}
</script>
<script>
	$(document)
			.ready(
					function() {
						MainBanner();
						Mfp();
						Mfd();
						BList();
						PList();

						$("#chat")
								.on(
										"click",
										function() {
											var userid = '${userid}';
											if (userid == "") {
												alert("로그인하여 주세요.");
												window.location.href = "/login";
											} else {
												window
														.open(
																'/chat',
																'_blank',
																'location=no,resizable=no,status=no,toolbar=no,scrollbars=no,top=100,left=700 ,width=600, height=400');
											}
										});
						//크롬은 설정 줘도 주소창 못 없앰
						//$("#calendar").load("http://localhost/board/calendar");

					});
</script>




<%@ include file="includes/clientfooter.jsp"%>