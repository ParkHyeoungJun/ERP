<!DOCTYPE html>
<html lang="en">
<head>
<title>CSS Template</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
</head>
<body>
<canvas id="canvas" style="display:none"></canvas>
<input type="button" id="btnSubmit" value="다운로드"/>
<script>
var canvas = document.getElementById("canvas");
var ctx = canvas.getContext("2d");
function showPer(per) {
ctx.clearRect(0, 0, 400, 400);
//바깥쪽 써클 그리기
ctx.strokeStyle = "#f66";
ctx.lineWidth=10;
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
var url = '/img/bigsize.dat';
$("#btnSubmit").on("click", function(e) {
$.ajax({
url: url,
type : 'get',
xhrFields: { //response 데이터를 바이너리로 처리한다.
responseType: 'blob'
},
beforeSend : function() { //ajax 호출전 progress 초기화
showPer(0);
canvas.style.display = 'block';
},
xhr: function() { //XMLHttpRequest 재정의 가능
var xhr = $.ajaxSettings.xhr();
xhr.onprogress = function(e) {
showPer(Math.floor(e.loaded / e.total * 100));
};
return xhr;
},
success : function(data) {
console.log("완료");
var blob = new Blob([data]);
//파일저장
if (navigator.msSaveBlob) {
return navigator.msSaveBlob(blob, url);
}
else {
var link = document.createElement('a');
link.href = window.URL.createObjectURL(blob);
link.download = url;
link.click();
}
},
complete : function() {
canvas.style.display = 'none';
}
});
});
</script>
</body>
</html>