package kr.erp.controller;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.erp.vo.EmailVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/email/*")
@AllArgsConstructor
public class EmailController {

	@Autowired
	private JavaMailSender mailSender;

	
	@GetMapping("/send")
	public void send() {
			
	}
	@PostMapping("/send")
	public ResponseEntity<String> send(EmailVO vo) 
	{
		try {
            MimeMessage mail = mailSender.createMimeMessage();
            MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
            // true는 멀티파트 메세지를 사용하겠다는 의미
            
            /*
             * 단순한 텍스트 메세지만 사용시엔 아래의 코드도 사용 가능 
             * MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
             */

            mailHelper.setFrom(vo.getFrom());
            // 빈에 아이디 설정한 것은 단순히 smtp 인증을 받기 위해 사용 따라서 보내는이(setFrom())반드시 필요
            // 보내는이와 메일주소를 수신하는이가 볼때 모두 표기 되게 원하신다면 아래의 코드를 사용하시면 됩니다.
            //mailHelper.setFrom("보내는이 이름 <보내는이 아이디@도메인주소>");
            mailHelper.setTo(vo.getTo());
            mailHelper.setSubject(vo.getSubject());
            // 아이디 찾기에 따라 디자인 
           
            log.info("타입:"+vo.getType());
            log.info("내용:"+ConvertDataFindId(vo.getContent()));
            mailHelper.setText(ConvertDataFindId(vo.getContent()), true);
            	 
            // true는 html을 사용하겠다는 의미입니다.
            
            //파일 첨부
           // FileSystemResource file = new FileSystemResource(new File("D:\\test.txt")); 
           // mailHelper.addAttachment("업로드파일.형식", file);
            
            /*
             * 단순한 텍스트만 사용하신다면 다음의 코드를 사용하셔도 됩니다. mailHelper.setText(content);
             */
            
            mailSender.send(mail);
            
        } catch(Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
		//
		return new ResponseEntity<String>("succuess", HttpStatus.OK);
		
		//return "redirect:"+vo.getReturnpage();
		
	}

	///id 찾기 화면에서만 사용되는 함수 
	public String ConvertDataFindId(String data)
	{
		String str ="<style>\r\n" + 
				"#hole {\r\n" + 
				"   border: solid 1px gray;\r\n" + 
				"   border-radius: 10px;\r\n" + 
				"   width: 500px;\r\n" + 
				"   height: 400px;\r\n" + 
				"   padding: 50px;\r\n" + 
				"   margin: auto;\r\n" + 
				"   margin-top: 100px;\r\n" + 
				"   padding-top: 100px;\r\n" + 
				"}\r\n" + 
				"\r\n" + 
				"#pwdreset {\r\n" + 
				"   width: 180px;\r\n" + 
				"   height: 50px;\r\n" + 
				"   border: none;\r\n" + 
				"   border-radius: 3px;\r\n" + 
				"   color:white;\r\n" + 
				"   background-color: #00008B;\r\n" + 
				"   margin:auto;\r\n" + 
				"   display: block;\r\n" + 
				"}\r\n" + 
				"#title{\r\n" + 
				"   position: absolute;\r\n" + 
				"   left: 50%;\r\n" + 
				"   transform: translateX(-50%);\r\n" + 
				"}\r\n" + 
				"</style>\r\n" + 
				"</head>\r\n" + 
				"<body>\r\n" + 
				"   <div id='hole'>\r\n" + 
				"   <div id='title'>\r\n" + 
				"         <span style='font-size: 28px; font-weight: bold; color: #00008B;'>모두의</span>&nbsp; <span style='font-size: 51px; font-weight: bold; color: #F23557;'>E</span><span style='font-size: 45px; font-weight: bold; color: #F0D43A;'>R</span><span style='font-size: 48px; font-weight: bold; color: #22B2DA;'>P</span>\r\n" + 
				"         </div>\r\n" + 
				"         <br><br><br><br>\r\n" + 
				"         <hr>\r\n" + 
				"         <br>\r\n" + 
				"         <div style='font-size: 14px; padding:5px;'><strong>모두의 이알피 비밀번호를 변경해주세요.</strong><br><br>본 메일은 비밀번호 변경을 위해 발송되는 메일입니다. 본인이 요청한 변경 사항이 아니라면 개인정보 보호를\r\n" + 
				"            위해 비밀번호를 재변경해주세요.<br><br>모두의 이알피㈜ 아이디의 비밀번호를 다시 설정하려면 '비밀번호 변경' 버튼을 클릭해주세요.</div>\r\n" + 
				"         <br>\r\n" + 
				"         <br>\r\n" + 
				"         <hr>\r\n" + 
				"         <br>\r\n" + 
				"         <br>\r\n" + 
				"         <a href='http://localhost/pwdreset?userid=myuserid'><button type='button' style='width: 180px;height: 50px;border: none;border-radius: 3px;color:white;background-color: #00008B;margin:auto;display: block;'>비밀번호 변경</button></a>\r\n" + 
				"         \r\n" + 
				"   </div>";
		
		return str.replaceAll("myuserid", data);
		
		
	}
	
	
	public String Emailend(String data)
	{
		String str="<style>\r\n" + 
				"#hole {\r\n" + 
				"   border: solid 1px gray;\r\n" + 
				"   border-radius: 10px;\r\n" + 
				"   width: 500px;\r\n" + 
				"   height: 400px;\r\n" + 
				"   padding: 50px;\r\n" + 
				"   margin: auto;\r\n" + 
				"   margin-top: 100px;\r\n" + 
				"}\r\n" + 
				"</style>\r\n" + 
				"</head>\r\n" + 
				"<body>\r\n" + 
				"   <div id='hole'>\r\n" + 
				"      <div id='title'>\r\n" + 
				"      <div style='color:#3D3D3D;'>&nbsp;Everyone's ERP</div>\r\n" + 
				"      <div style='font-size: 24px; font-weight:bold; color:#3D3D3D;'>이메일 인증 안내입니다.</div>\r\n" + 
				"\r\n" + 
				"      </div>\r\n" + 
				"      <br><br>\r\n" + 
				"      <div style='font-size: 14px; padding: 5px; color:#3D3D3D;'>\r\n" + 
				"         <strong>모두의 이알피㈜ 가입을 환영합니다.</strong><br> <strong>아래의 인증\r\n" + 
				"            코드를 입력하시면 회원가입이 정상적으로 완료됩니다. </strong><br>\r\n" + 
				"         <br>\r\n" + 
				"         <div\r\n" + 
				"            style='background-color: #F5F3F3; padding-left: 20px; height: 60px; width: 600px; font-size: 30px; font-weight: bold; align-content: center; display: table-cell; vertical-align: middle'>\r\n" + 
				data+"</div>\r\n" + 
				"         <br>\r\n" + 
				"         <br>\r\n" + 
				"         <br>\r\n" + 
				"         <br>\r\n" + 
				"         <br> <small>※ 본 메일은 발신전용입니다.</small>\r\n" + 
				"         <br> <small>※ 정해진 시간 내에 인증을 완료하지 않으면 회원가입이 취소됩니다.</small>\r\n" + 
				"\r\n" + 
				"      </div>\r\n" + 
				"      <br>\r\n" + 
				"      <hr>\r\n" + 
				"      \r\n" + 
				"      <div id='footer' style=''float: right;'>\r\n" + 
				"         <span style='font-size: 15px; font-weight: bold; color: #00008B;'>Everyone's</span>&nbsp;\r\n" + 
				"         <span style='font-size: 20px; font-weight: bold; color: #F23557;'>E</span><span\r\n" + 
				"            style='font-size: 20px; font-weight: bold; color: #F0D43A;'>R</span><span\r\n" + 
				"            style='font-size: 20px; font-weight: bold; color: #22B2DA;'>P</span>\r\n" + 
				"      </div>\r\n" + 
				"   </div>";
		return str;
		}
	
	
	@GetMapping("/result")
	public void result() {

	}
}
