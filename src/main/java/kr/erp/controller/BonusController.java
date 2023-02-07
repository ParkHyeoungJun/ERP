package kr.erp.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.erp.service.BonusService;
import kr.erp.service.MemberService;
import kr.erp.vo.BonusVO;
import kr.erp.vo.Content;
import kr.erp.vo.Criteria;
import kr.erp.vo.MemberVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/admin/bonus/*")
@Controller
@Log4j
@AllArgsConstructor
public class BonusController {
	private BonusService service;
	private MemberService memberservice;
	
	@GetMapping("/select")
	public void list() {

	}
	
	@GetMapping("/charts")
	public void charts() {

	}

	@PostMapping(value = "/content", produces = MediaType.APPLICATION_JSON_VALUE)
	   public ResponseEntity<List<Content>> content() {
	      List<Content> list = new ArrayList<>();
	      Content c1 = new Content("1","프로젝트 완료");
	      Content c2 = new Content("2","관리자 권한으로 부여");
	      Content c3 = new Content("3","기타");
	      
	      list.add(c1);
	      list.add(c2);
	      list.add(c3);
	      
	      return new ResponseEntity<>(list, HttpStatus.OK);
	   }
	
	@PostMapping(value = "/select", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<BonusVO>> select(Criteria cri) {
		
		return new ResponseEntity<>(service.select(cri), HttpStatus.OK);
	}

	@PostMapping("/add")
	public ResponseEntity<String> addajax(BonusVO vo, Model model) {
		InetAddress local = null;
		try {
			local = InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String ip = local.getHostAddress();
		vo.setIp(ip);
		
		log.info(ToStringBuilder.reflectionToString(vo));
		if (vo.getIdx() == 0) {
			service.add(vo);
			
			MemberVO mvo = new MemberVO();
			
			 mvo.bonus = vo.getBonus();
			 mvo.userid = vo.getUserid();
			 
			memberservice.bonusplus(mvo.bonus, mvo.userid);
			
				
		}else {
			service.update(vo);
			
			MemberVO mvo = new MemberVO();
			
			 mvo.bonus = vo.getBonus();
			 mvo.userid = vo.getUserid();
			 
			memberservice.bonusminus(vo.getPastbonus(), mvo.userid);
			memberservice.bonusplus(mvo.bonus, mvo.userid);
		}
		return new ResponseEntity<String>("succuess", HttpStatus.OK);
	}

	@PostMapping("/delete")
	public ResponseEntity<String> delete(Long idx,BonusVO vo, Model model) {
		int row = service.delete(idx);
		
		MemberVO mvo = new MemberVO();
		
		 mvo.bonus = vo.getBonus();
		 mvo.userid = vo.getUserid();
		 
		memberservice.bonusminus(mvo.bonus, mvo.userid);
		
		if (row > 0) {
			return new ResponseEntity<String>("succuess", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}
}