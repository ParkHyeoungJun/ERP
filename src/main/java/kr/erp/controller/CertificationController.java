package kr.erp.controller;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.erp.service.CertificationService;
import kr.erp.vo.CertificationVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/certification/*")
@AllArgsConstructor
public class CertificationController {
  private CertificationService service;
  
  @PostMapping("/Create")
 	public  ResponseEntity<String> Create(CertificationVO vo)
 	{
	  // 10개의 랜덤 문자 생성 대소문자 구별
 		String retval =RandomStringUtils.randomAlphanumeric(10);

 		vo.setKey(retval);
 		service.add(vo);
 		return new ResponseEntity<String>(retval, HttpStatus.OK);
 		
 	}
  
  @PostMapping("/get")
 	public  ResponseEntity<String> get(CertificationVO vo)
 	{
	  log.info("key:"+vo.getKey());
	  CertificationVO data = service.get(vo);
	  log.info("data:"+data);
 		if(data!= null)
 		{
 		//	service.delete(vo);
 			return new ResponseEntity<String>("succuess", HttpStatus.OK);
 		}
 		else
		{
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	
		}
 		
 	}
  
  @PostMapping("/delete")
 	public  ResponseEntity<String> delete(CertificationVO vo)
 	{
	  log.info("key:"+vo.getKey());
	  int data = service.delete(vo);
	  log.info("data:"+data);
 		if(data>0)
 		{
 		//	service.delete(vo);
 			return new ResponseEntity<String>("succuess", HttpStatus.OK);
 		}
 		else
		{
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	
		}
 		
 	}
}
