package kr.erp.controller;


import java.io.File;
import java.io.IOException;

import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.erp.vo.SmsVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Balance;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.model.StorageType;
import net.nurigo.sdk.message.request.MessageListRequest;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.MessageListResponse;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

//@RestController
@Controller
@Log4j
@RequestMapping("/admin/sms/*")
@AllArgsConstructor
public class AdminSMSController {
	 private DefaultMessageService messageService = null;
	 
	 /**
	     * 발급받은 API KEY와 API Secret Key를 사용해주세요.
	     */
	 public AdminSMSController() {
	        this.messageService = NurigoApp.INSTANCE.initialize("API KEY", "Secret Key", "https://api.coolsms.co.kr");
	 }
	 
	 
	 @GetMapping("/send")
	 public void send() 
	 {
	 }
	 
	 @GetMapping("/list")
	 public void list() 
	 {
		 log.info("log!!!");
	 }
	 
	 /**
	     * 잔액 조회 예제
	     */
	 @PostMapping("/getblance")
	 public ResponseEntity <String> getblance() {
		  Balance balance = this.messageService.getBalance();
		  return new ResponseEntity<String>(balance.toString(), HttpStatus.OK);
	 }
	 
	 
	 /**
	     * 단일 메시지 발송 예제
	     * 한글 45자, 영자 90자 이하 입력되면 자동으로 SMS타입의 메시지가 추가됩니다. 90자 이상시 자동으로 mms 발송 
	     */
	    @PostMapping("/sendone")
	    public ResponseEntity <String> sendOne(SmsVO sms) {
	        Message message = new Message();
	        message.setFrom(sms.getForm());
	        message.setTo(sms.getTo());
	        message.setText(sms.getText());

	        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
	        System.out.println(response);

	        return new ResponseEntity<String>(response.toString(), HttpStatus.OK);
	    }
	    
	    
	    /**
	     * 메시지 조회 예제
	     */
	    @PostMapping("/get-message-list")
	    public ResponseEntity <String>  getMessageList() {
	        MessageListResponse response = this.messageService.getMessageList(new MessageListRequest());

	        return new ResponseEntity<String>(response.toString(), HttpStatus.OK);
	    }
	    
	    /**
	     * MMS 발송 예제
	     * 단일 발송, 여러 건 발송 상관없이 이용 가능
	     */
	    @PostMapping("/send-mms")
	    public ResponseEntity <String> sendMmsByResourcePath(SmsVO sms) throws IOException {
	        ClassPathResource resource = new ClassPathResource("/resources/img/new.gif");
	        File file = resource.getFile();
	        String imageId = this.messageService.uploadFile(file, StorageType.MMS, null);

	        Message message = new Message();
	        message.setFrom(sms.getForm());
	        message.setTo(sms.getTo());
	        message.setText(sms.getText());
	        message.setImageId(imageId);

	        // 여러 건 메시지 발송일 경우 send many 예제와 동일하게 구성하여 발송할 수 있습니다.
	        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
	        return new ResponseEntity<String>(response.toString(), HttpStatus.OK);
	    }
}
