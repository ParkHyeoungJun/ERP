package kr.erp.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;
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
import org.springframework.web.bind.annotation.RequestParam;

import kr.erp.mapper.ProjectAdminMapper;
import kr.erp.service.BonusService;
import kr.erp.service.MemberSelectService;
import kr.erp.service.MemberService;
import kr.erp.service.ProjectAdminService;
import kr.erp.vo.BonusVO;
import kr.erp.vo.Criteria;
import kr.erp.vo.MemberSelectVO;
import kr.erp.vo.MemberVO;
import kr.erp.vo.ProjectAdminVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/admin/projectadmin/*")
@AllArgsConstructor
public class ProjectAdminController {
	private ProjectAdminService service;
	private MemberSelectService memberservice;
	private BonusService bonusservice;
	private MemberService memservice;
	@GetMapping("/select")
	public void list() {

	}

	@GetMapping("/add")
	public void add() {

	}

	@GetMapping({ "/update", "/get" })
	public void get(@RequestParam("num") Long num, Model model) {
		model.addAttribute("num", num);
		ProjectAdminVO vo = service.get(num);
		model.addAttribute("vo", vo);

	}

	@GetMapping("/memberselect")
	public void memberselect(@RequestParam("num") Long num, Model model) {
		model.addAttribute("num", num);
	}

	@PostMapping(value = "/select", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ProjectAdminVO>> select(Criteria cri) {

		return new ResponseEntity<>(service.select(cri), HttpStatus.OK);
	}

	@PostMapping(value = "/get", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ProjectAdminVO> get(@RequestParam Long num) {

		return new ResponseEntity<ProjectAdminVO>(service.get(num), HttpStatus.OK);
	}

	@PostMapping("/add")
	public ResponseEntity<String> addajax(ProjectAdminVO vo, Model model) {
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
		if (vo.getNum() == 0) {
			service.add(vo);
			//log.info("getarrlist: "+vo.getArrList());
			
			if(vo.getUseridsp() != "" || vo.getUseridsp().length()>0)
			{
				MemberSelectVO mvo = new MemberSelectVO();
				
				String[] rm= vo.getUseridsp().split(",");
				String[] rmn= vo.getUsernamesp().split(",");
				
				 for (int i = 0; i < rm.length; i++) { 
				 mvo.num = vo.getNum();
				 mvo.userid= rm[i];
				 mvo.username= rmn[i];
				 memberservice.add(mvo);
				 
				 }
				//return;
				 
			}
				//vo.setNum(vo.getNum());
		}
		else {
			service.update(vo);
			
			if(vo.getUseridspplus() != "" || vo.getUseridspplus().length()>0)
			{
				MemberSelectVO mvo = new MemberSelectVO();
				
				String[] rm= vo.getUseridspplus().split(",");
				String[] rmn= vo.getUsernamesp().split(",");
				
				 for (int i = 0; i < rm.length; i++) { 
				 mvo.num = vo.getNum();
				 mvo.userid= rm[i];
				 mvo.username= rmn[i];
				 memberservice.add(mvo);
				 
				 }
				//return;
				 
			}
			
			if(vo.isProgress()==true) {
				BonusVO bvo = new BonusVO();
				MemberVO mvo = new MemberVO();
				
				String[] rm= vo.getUseridsp().split(",");
				
				for (int i = 0; i < rm.length; i++) {
				 bvo.num = vo.getNum();
				 bvo.userid = rm[i];
				 bvo.bonus = vo.getBonus();
				 bvo.con = vo.getCon();
				 bvo.ip=vo.getIp();
				 bvo.writer=vo.getUpdater();
				 mvo.bonus = vo.getBonus();
				 mvo.userid = rm[i];
				
				memservice.bonusplus(mvo.bonus, mvo.userid);
				bonusservice.add(bvo);
				}
				
				
			}
			if(vo.getPastprogress() != "" && vo.isProgress()==false) {//완료된 프로젝트를 다시 진행중으로 돌렸을 때,
				
				BonusVO bvo = new BonusVO();
				MemberVO mvo = new MemberVO();
				
				bvo.num = vo.getNum();
				
				bonusservice.pjdelete(bvo.num);//실적관리에서 없애기
				
				String[] rm= vo.getUseridsp().split(",");
				
				for (int i = 0; i < rm.length; i++) {

				 mvo.bonus = vo.getBonus();
				 mvo.userid = rm[i];
				 
				memservice.bonusminus(mvo.bonus, mvo.userid);
				
				}//회원 실적 데이터 -100
			}
		}
		return new ResponseEntity<String>("succuess", HttpStatus.OK);
	}






	@PostMapping("/delete")
	public ResponseEntity<String> deletedajax(Long num, Model model) {
		int row = service.delete(num);
		if (row > 0) {
			return new ResponseEntity<String>("succuess", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

}
