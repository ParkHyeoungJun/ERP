package kr.erp.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.erp.service.MemberService;
import kr.erp.service.ProjectAdminService;
import kr.erp.service.ReportResultService;
import kr.erp.service.ReportService;
import kr.erp.service.ReportsubService;
import kr.erp.vo.Criteria;
import kr.erp.vo.MemberVO;
import kr.erp.vo.ProjectAdminVO;
import kr.erp.vo.ReportResultVO;
import kr.erp.vo.ReportVO;
import kr.erp.vo.ReportsubVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/admin/reportresult/*")
@AllArgsConstructor
public class AdminReportResultController {
   private ProjectAdminService projectmapper;
   
   private ReportService reportservice;
   @Resource
   private String uploadPath;

   private ReportResultService mapper;
    private ReportsubService submapper;
    private MemberService member;
   /*
    * sign에서 Base64Binary 으로 넘겨진 데이터을 서버에 이미지파일으로 저장
    */
   @PostMapping("/reportSaveimg")
   public ResponseEntity<String> reportSaveimg(ReportResultVO vo) {
      // 여러개 파일 저장을 위한 객체 배열 타입 선언.
      // log.info("vo:"+ToStringBuilder.reflectionToString(vo));
	  
      String tempFileName = "signResult.png";
      UUID uuid = UUID.randomUUID();
      String uploadFileName = uploadPath + File.separator + "signResult" + File.separator + uuid.toString() + "_"
            + tempFileName;
      
      String uploadFolder = uploadPath;
      File uploadPath = new File(uploadFolder, "signResult");
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

   
   
   // 입력 
   @PostMapping("add")
   public ResponseEntity<String> add(ReportResultVO vo) {      
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
         mapper.add(vo);
      } catch (Exception e) {
         return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
      }
      
      return new ResponseEntity<String>("succuess", HttpStatus.OK);
   }
   
   @GetMapping("list")
   public void list() 
   {
      
   }
   // 조회 
   @PostMapping(value = "searchlist", produces = MediaType.APPLICATION_JSON_VALUE)
   public  ResponseEntity<List<ProjectAdminVO>> searchlist(Criteria cri)
   {
      log.info(ToStringBuilder.reflectionToString(cri));
       return new ResponseEntity<>(projectmapper.allproject(cri), HttpStatus.OK);      
   }
   
   @GetMapping("report")
   public void report(Authentication authentication,@RequestParam Long num, @RequestParam String writer,Model model)
   {
      String userid ="";
      ReportVO vo = new ReportVO();
      vo.setNum(num);
      vo.setWriter(writer);
      ReportVO data = reportservice.detils(vo);
      if(data != null)
      {
         //log.info("idx:"+data.getIdx());
         ReportsubVO subparm= new ReportsubVO();
         subparm.setIdx(data.getIdx());
         //log.info("idx:"+subparm.getIdx());
         List<ReportsubVO> sub = submapper.getview(subparm) ;
         model.addAttribute("data",sub);
         model.addAttribute("uuid",data.getUuid());
      }
      model.addAttribute("num", num);
      model.addAttribute("writer", writer);
      try {
         UserDetails userDetails = (UserDetails) authentication.getPrincipal();
         userid = userDetails.getUsername();
         MemberVO mvo= member.read(userid);
         log.info("login:"+userid);
         // 로그인 한 사용자 부서와 직책 가져온다 
          if(mvo!= null)
          {
             model.addAttribute("dept", mvo.getDept());
             log.info("dept:"+mvo.getDept());
             model.addAttribute("job", mvo.getJob());
          }
          mvo= member.read(writer);
          // 작성자의  부서와 직책도 가져온다 작성시 권한 체크하기 위함 
          if(mvo!= null)
          {
             model.addAttribute("writerdept", mvo.getDept());
             model.addAttribute("writerjob", mvo.getJob());
          }
      } catch (Exception e) {
         log.info("erroe:"+e.getMessage());
      } finally {
         if (userid != null) {
            model.addAttribute("userid", userid);
         }
      }
   }
}