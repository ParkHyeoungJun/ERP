package kr.erp.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.compress.utils.IOUtils;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.ClientAnchor;
import org.apache.poi.ss.usermodel.ClientAnchor.AnchorType;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Drawing;
import org.apache.poi.ss.usermodel.Picture;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.erp.service.MemberSelectService;
import kr.erp.service.MemberService;
import kr.erp.service.ProjectAdminService;
import kr.erp.service.ReportResultService;
import kr.erp.service.ReportService;
import kr.erp.vo.Criteria;
import kr.erp.vo.MemberSelectVO;
import kr.erp.vo.MemberVO;
import kr.erp.vo.ProjectAdminVO;
import kr.erp.vo.ReportResultVO;
import kr.erp.vo.ReportVO;
import kr.erp.vo.ReportsubVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/report/*")
@AllArgsConstructor
public class ReportController {
   private ReportService service;
   private MemberSelectService msservice;
   private ProjectAdminService project;
   private MemberService memservice;
   private ReportResultService resultservice;
   private static int cmoney=0;
   
   @Resource
   private String uploadPath;

   @GetMapping("report")
   public void report(@RequestParam Long num, MemberSelectVO data, Authentication authentication, Model model) {
      String userid = "";
      try {
//         ReportVO rdata = service.get(num);
//         if (rdata != null) {
//            model.addAttribute("rdata", rdata);
//         }

         UserDetails userDetails = (UserDetails) authentication.getPrincipal();
         userid = userDetails.getUsername();
         data.setUserid(userid);
         MemberSelectVO vo = msservice.read(data);
         log.info("vo:" + ToStringBuilder.reflectionToString(vo));
         if (vo == null) {
            model.addAttribute("error", "error");
         }

      } catch (Exception e) {
         log.info("error:" + e.getMessage());
      } finally {
         if (userid != null)
            model.addAttribute("userid", userid);

         model.addAttribute("num", num);

      }
   }

   @PostMapping("/reportadd")
   public ResponseEntity<String> reportadd(ReportVO vo) {
      log.info("add:1992");
      InetAddress local = null;
      try {
         local = InetAddress.getLocalHost();
      } catch (UnknownHostException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      String ip = local.getHostAddress();
      vo.setIp(ip);
      try {
         service.add(vo);
      } catch (Exception e) {
         log.info("error:" + e.getMessage());
         return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
      }
      return new ResponseEntity<String>("succuess", HttpStatus.OK);
   }

   /*
    * sign에서 Base64Binary 으로 넘겨진 데이터을 서버에 이미지파일으로 저장
    */
   @PostMapping("/reportSaveimg")
   public ResponseEntity<String> reportSaveimg(ReportVO vo) {
      // 여러개 파일 저장을 위한 객체 배열 타입 선언.
      // log.info("vo:"+ToStringBuilder.reflectionToString(vo));
      
      
      String tempFileName = "sign.png";
      UUID uuid = UUID.randomUUID();
      String uploadFileName = uploadPath + File.separator + "sign" + File.separator + uuid.toString() + "_"
            + tempFileName;
      String uploadFolder = uploadPath;
      File uploadPath = new File(uploadFolder, "sign");
      if (uploadPath.exists() == false) {
         uploadPath.mkdirs();
         // 경로에 폴더들이 생성되어 있지 않다면, 폴더 생성.
      }
      
      tempFileName = uuid.toString() + "_" + tempFileName;
      try {
         String data = vo.getSign().split(",")[1];
         byte[] imageBytes = DatatypeConverter.parseBase64Binary(data);
         BufferedImage bufImg = ImageIO.read(new ByteArrayInputStream(imageBytes));

         ImageIO.write(bufImg, "png", new File(uploadFileName));

      } catch (IOException e) {
         log.info("image:save error:" + e.getMessage());
      }
      return new ResponseEntity<String>(tempFileName, HttpStatus.OK);

   }

   @GetMapping("myproject")
	public void myproject(Authentication authentication, Model model) {
		String userid = "";

		try {
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			userid = userDetails.getUsername();
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			if (userid != null) {
				model.addAttribute("userid", userid);
			}
		}
	}
   @PostMapping(value = "/myproject", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ProjectAdminVO>> myproject(Criteria cri) {

		List<ProjectAdminVO> data = null;
		try {
			data = project.myreport(cri);
		} catch (Exception e) {
			log.info("error:" + e.getMessage());
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<List<ProjectAdminVO>>(data, HttpStatus.OK);

	}

   // 서버에 있는 템플릿 엑셀파일에 데이터베이스 조회하여 엑셀파일에 값 넣고 사용자에 강제적으로 다운로드 실행
   @GetMapping(value = "/exceldownload", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
   @ResponseBody
   public void downloadFile(@RequestHeader("User-Agent") String userAgent, HttpServletResponse response, ReportVO vo) {
      String uploadFileName = uploadPath + File.separator + "excel" + File.separator + "ProjectReport.xlsx";
      FileInputStream fileInputStream = null;
      XSSFWorkbook workbook = null; // poi 라이브러리 엑셀 시트 관리하는 워크북

      try {
         fileInputStream = new FileInputStream(uploadFileName);
         workbook = new XSSFWorkbook(fileInputStream);
      } catch (FileNotFoundException e1) {
         // TODO Auto-generated catch block
         e1.printStackTrace();
      } catch (IOException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }
      XSSFSheet sheet = workbook.getSheetAt(0);
      String userid = vo.getWriter();
      MemberVO member = memservice.read(userid);
      if (member != null) {
         Row row1 = sheet.getRow(3);
         Cell cell1 = row1.getCell(9);
         Row row2 = sheet.getRow(2);
         Cell cell2 = row2.getCell(9);
         cell1.setCellValue(member.getUsername());// 작성자
         cell2.setCellValue(vo.getProjectday()); // 작성 일자

         Row row3 = sheet.getRow(8);
         Cell cell3 = row3.getCell(2);
         cell3.setCellValue(vo.getWriter()); // 신청일자
         Cell cell4 = row3.getCell(7);
         cell4.setCellValue(member.getUsername());// 성명

         String dept = member.getDept();
         if(dept !=null)
         {
         Row row4 = sheet.getRow(9);
         Cell cell5 = row4.getCell(2);
         if (dept.equalsIgnoreCase("10")) {
            cell5.setCellValue("인사부");
         }
         if (dept.equalsIgnoreCase("20")) {
            cell5.setCellValue("총무부");
         }
         if (dept.equalsIgnoreCase("30")) {
            cell5.setCellValue("회계부");
         }
         if (dept.equalsIgnoreCase("40")) {
            cell5.setCellValue("기획부");
         }
         if (dept.equalsIgnoreCase("50")) {
            cell5.setCellValue("영업부");
         }
         Cell cell6 = row4.getCell(7);
         cell6.setCellValue(member.getHp()); // 연락처
         }
      }

      // 일일이 데이터 모두 가지고 올수 없어 프로젝트 번호만 가져와 데이터 조화
      ReportVO data = service.get(vo.getNum());
      if (data != null) {
         // 이미지 처리 시작
         // String uuid ="http://localhost"+ "//" + "resources" + "//" + "sign" + "//" +
         // data.getUuid(); // 실제 이미지 경로
         String uuid = uploadPath + File.separator + "sign" + File.separator + data.getUuid();
         log.info("image url:" + uuid);
         InputStream is = null;
         int pictureIdx = 0;
         try {
            is = new FileInputStream(uuid);
            byte[] bytes = null;
            bytes = IOUtils.toByteArray(is);
            pictureIdx = workbook.addPicture(bytes, Workbook.PICTURE_TYPE_JPEG);
         } catch (IOException e) {
            log.info("image error:" + e.getMessage());
         } finally {
            try {
               is.close();
            } catch (IOException e) {
               log.info("image close() 에러:" + e.getMessage());
            }
         }

         CreationHelper helper = workbook.getCreationHelper();
         Drawing drawing = sheet.createDrawingPatriarch();

         ClientAnchor anchor = helper.createClientAnchor();
         anchor.setAnchorType(AnchorType.MOVE_DONT_RESIZE);//setAnchorType(1);
         
         anchor.setCol1(1); // image 영역 지정
         anchor.setRow1(19);
         

         Picture pict = drawing.createPicture(anchor, pictureIdx);
         pict.resize(6.1, 9); // 넒이 , 폭이 비율으로 계산하는거 같음
         //pict.resize();
         // 이미지 처리 끝
         int drow = 13;
         List<ReportsubVO> arrList = data.getArrList();
         // log.info(arrList);
         //int cmoney=0;
         for (int i = 0; i < arrList.size(); i++) {

            ReportsubVO sub = arrList.get(i);
            Row datarow = sheet.getRow(drow);
            Cell daytostring = datarow.getCell(1);
            Cell sel = datarow.getCell(2);
            Cell celltxt = datarow.getCell(8);
            daytostring.setCellValue(sub.getDaytostring());
            sel.setCellValue(sub.getSel());
            celltxt.setCellValue(sub.getTxt());
            if(sub.getTxt() !=null)
            {
                  cmoney += Integer.parseInt(sub.getTxt().replaceAll(",", ""));
            }
            // log.info("금액:"+sub.getTxt());
            drow += 1;
         }
      }
      Row rowc = sheet.getRow(17);
      Cell cellc = rowc.getCell(8);
      //int cmoney;
      cellc.setCellValue(Comma());
      
      /* 결재 승인 부분 시작 */
      ReportResultVO resultvo= new ReportResultVO();
      resultvo.setNum(vo.getNum());
      resultvo.setWriter(userid);
      List<ReportResultVO> result = resultservice.get(resultvo);
      int [] col = {6,8,9,10,11,12};
      for (int i = 0; i < result.size(); i++) {
         ReportResultVO resultdata= result.get(i);
         Row rowjob = sheet.getRow(5);
         Cell jobcol = rowjob.getCell(col[i]);
         log.info("job:::"+resultdata.getJob());
         if(resultdata.getJob().equalsIgnoreCase("01"))
         {
            jobcol.setCellValue("사원");
         }
         else if(resultdata.getJob().equalsIgnoreCase("02"))
         {
            jobcol.setCellValue("주임");
         }
         else if(resultdata.getJob().equalsIgnoreCase("03"))
         {
            jobcol.setCellValue("전임");
         }
         else if(resultdata.getJob().equalsIgnoreCase("04"))
         {
            jobcol.setCellValue("선임");
         }
         else if(resultdata.getJob().equalsIgnoreCase("05"))
         {
            jobcol.setCellValue("대리");
         }
         else if(resultdata.getJob().equalsIgnoreCase("06"))
         {
            jobcol.setCellValue("과장");
         }
         else if(resultdata.getJob().equalsIgnoreCase("07"))
         {
            jobcol.setCellValue("차장");
         }
         else if(resultdata.getJob().equalsIgnoreCase("08"))
         {
            jobcol.setCellValue("부장");
         }
         else if(resultdata.getJob().equalsIgnoreCase("09"))
         {
            jobcol.setCellValue("이사");
         }
         else if(resultdata.getJob().equalsIgnoreCase("10"))
         {
            jobcol.setCellValue("상무");
         }
         else if(resultdata.getJob().equalsIgnoreCase("11"))
         {
            jobcol.setCellValue("전무");
         }
         else if(resultdata.getJob().equalsIgnoreCase("12"))
         {
            jobcol.setCellValue("부사장");
         }
         else if(resultdata.getJob().equalsIgnoreCase("13"))
         {
            jobcol.setCellValue("사장");
         }
         else if(resultdata.getJob().equalsIgnoreCase("14"))
         {
            jobcol.setCellValue("부회장");
         }
         else
         {
            jobcol.setCellValue("회장");
         }
         
         String uuid = uploadPath + File.separator + "signResult" + File.separator + resultdata.getUuid();
         
         InputStream is = null;
         int pictureIdx = 0;
         try {
            is = new FileInputStream(uuid);
            byte[] bytes = null;
            bytes = IOUtils.toByteArray(is);
            pictureIdx = workbook.addPicture(bytes, Workbook.PICTURE_TYPE_JPEG);
         } catch (IOException e) {
            log.info("image error:" + e.getMessage());
         } finally {
            try {
               is.close();
            } catch (IOException e) {
               log.info("image close() 에러:" + e.getMessage());
            }
         }

         CreationHelper helper = workbook.getCreationHelper();
         Drawing drawing = sheet.createDrawingPatriarch();
         ClientAnchor anchor = helper.createClientAnchor();
         anchor.setAnchorType(AnchorType.MOVE_DONT_RESIZE);//setAnchorType(1);
         
         anchor.setCol1(col[i]); // image 영역 지정
         anchor.setRow1(6);
         Picture pict = drawing.createPicture(anchor, pictureIdx);
         pict.resize(0.8, 0.8); // 넒이 , 폭이 비율으로 계산하는거 같음
      }
       /*결재 승인 부분 완료*/
      
      /*
       * // 셀 Style 정보를 저장할 객체 생성 CellStyle cellStyle = workbook.createCellStyle();
       * 
       * // Style 정보를 Cell에 입력하기 cell.setCellStyle(cellStyle);
       * 
       * // Cell 병합 sheet.addMergedRegion(new CellRangeAddress(시작행, 끝행, 시작열, 끝열);
       * 
       * // 정렬 cellStyle.setAlignment(CellStyle.ALIGN_CENTER); // 가운데 정렬
       * cellStyle.setAlignment(CellStyle.ALIGN_LIGHT); // 우측 정렬
       * cellStyle.setAlignment(CellStyle.ALIGN_LEFT); // 좌측 정렬
       * cellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER); // 높이 가운데 정렬
       * cellStyle.setVerticalAlignment(VerticalAlignment.TOP); // 높이 상단 정렬   // 테두리
       * 선(좌, 우, 위, 아래) cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
       * cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
       * cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
       * cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
       * 
       * // 1. 배경 색상 : Color 사용 Color color = new Color(231, 234, 236); // 그레이색
       * cellStyle.setFillForegroundColor(new XSSFColor(color, new
       * DefaultIndexedColorMap()));
       * cellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
       * 
       * // 2. 배경 색상 : XSSFCellStyle 사용 XSSFCellStyle xssCellStyle = (XSSFCellStyle)
       * workbook.createCellStyle(); xssCellStyle.setFillForegroundColor(new
       * XSSFColor(new byte[] {(byte)231, (byte)234, (byte)236}, null));
       * xssCellStyle.setFillPattern(FillPatternType.FINE_DOTS);
       * 
       * // 폰트 설정 Font font = workbook.createFont(); font.setFontName("나눔고딕"); // 글씨체
       * font.setFontHeight((short)(크기 * 20)); // 사이즈
       * font.setBoldweight(Font.BOLDWEIGHT_BOLD); // 굵게 font.setBold(true); // 굵게
       * 
       * // 폰트 적용 cellStyle.setFont(font);
       * 
       * // 포맷 설정
       * cellStyle.setDataFormat(workbook.createDataFormat().getFormat("yyyy-mm-dd"));
       * // 날짜
       * cellStyle.setDataFormat(workbook.createDataFormat().getFormat("0.00%")); //
       * 퍼센트 cellStyle.setDataFormat(workbook.createDataFormat().getFormat("#,##0"));
       * // 금액 cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0")); //
       * 금액 cellStyle.setDataFormat(workbook.getCreationHelper().createDataFormat().
       * getFormat("#,##0")); // 금액
       * 
       */
      // 다운로드 파일명 설정
      Date date = new Date();
      SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
      String time = simpleDateFormat.format(date);
      String fileName = "파일명" + "_" + time + ".xlsx";

      // 파일
      String browser = userAgent;

      // 브라우저에 따른 파일명 인코딩 설정
      if (browser.indexOf("MSIE") > -1) {
         try {
            fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
         } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      } else if (browser.indexOf("Trident") > -1) { // IE11
         try {
            fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
         } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      } else if (browser.indexOf("Firefox") > -1) {
         try {
            fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
         } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      } else if (browser.indexOf("Opera") > -1) {
         try {
            fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
         } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      } else if (browser.indexOf("Chrome") > -1) {
         StringBuffer sb = new StringBuffer();
         for (int i = 0; i < fileName.length(); i++) {
            char c = fileName.charAt(i);
            if (c > '~') {
               try {
                  sb.append(URLEncoder.encode("" + c, "UTF-8"));
               } catch (UnsupportedEncodingException e) {
                  // TODO Auto-generated catch block
                  e.printStackTrace();
               }
            } else {
               sb.append(c);
            }
         }
         fileName = sb.toString();
      } else if (browser.indexOf("Safari") > -1) {
         try {
            fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
         } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      } else {
         try {
            fileName = "\"" + new String(fileName.getBytes("UTF-8"), "8859_1") + "\"";
         } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
         }
      }

      // 브라우저에 따른 컨텐츠타입 설정
      String contentType = "application/download;charset=utf-8";
      switch (browser) {
      case "Firefox":
      case "Opera":
         contentType = "application/octet-stream; text/html; charset=UTF-8;";
         break;
      default: // MSIE, Trident, Chrome, ..
         contentType = "application/x-msdownload; text/html; charset=UTF-8;";
         break;
      }
      response.setContentType("application/x-msdownload; text/html; charset=UTF-8;"); // msie, tRIDE
      response.setContentType("application/octet-stream; text/html; charset=UTF-8;");

      // response 설정
      response.setContentType(contentType);
      response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
      response.setHeader("Content-Transfer-Encoding", "binary");

      // 파일 생성 : OutputStream을 얻어 생성한 엑셀 write
      OutputStream outputStream;
      try {
         outputStream = response.getOutputStream();
         workbook.write(outputStream);
      } catch (IOException e) {
         log.info("file error:" + e.getMessage());
      }
   }
   
   
   public static String Comma()
   {
      DecimalFormat decFormat = new DecimalFormat("###,###");

      String str = decFormat.format(cmoney);
      return str;
   }
   
}