package kr.erp.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.security.Principal;
import java.util.List;

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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.erp.service.BoardAdminService;
import kr.erp.service.BoardService;
import kr.erp.service.DeclarService;
import kr.erp.service.MemberService;
import kr.erp.service.ProjectAdminService;
import kr.erp.vo.BoardAdminVO;
import kr.erp.vo.BoardVO;
import kr.erp.vo.Criteria;
import kr.erp.vo.DeclarVO;
import kr.erp.vo.ProjectAdminVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private BoardService service;
	private BoardAdminService adminservice;
	private DeclarService dservice;
	private MemberService memberservice;
	private ProjectAdminService pservice;

	@GetMapping({ "/update", "/get", "/answer", "/declar" })
	public void get(Authentication authentication, @RequestParam("code") Long code, @RequestParam("num") Long num,
			Model model) {
		model.addAttribute("code", code);
		model.addAttribute("num", num);
		BoardVO vo = service.get(num);
		model.addAttribute("vo", vo);
		BoardAdminVO v = adminservice.get(code);
		model.addAttribute("v", v);
		String userid = "";

		try {
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			userid = userDetails.getUsername();
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			if (userid != null)
			{
				model.addAttribute("userid", userid);
				model.addAttribute("member", memberservice.read(userid));
			}
		}
	}

	@PostMapping("/declar")
	public ResponseEntity<String> add(DeclarVO vo, Model model) {
		InetAddress local = null;
		try {
			local = InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String ip = local.getHostAddress();
		vo.setIp(ip);
		log.info(ip);
		log.info(ToStringBuilder.reflectionToString(vo));
		dservice.add(vo);

		return new ResponseEntity<String>("succuess", HttpStatus.OK);
	}

	@GetMapping("/add")
	public void add(Principal principal, @RequestParam("code") Long code, Model model) {

		BoardAdminVO v = adminservice.get(code);
		model.addAttribute("v", v);
		model.addAttribute("code", code);
		try {
			model.addAttribute("userid", principal.getName());
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

	// 입력 or 수정 같이
		@PostMapping({ "/add","/update", "/answer" })

		public ResponseEntity<String> add(BoardVO vo, Model model) {
			InetAddress local = null;
			try {
				local = InetAddress.getLocalHost();
			} catch (UnknownHostException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			String ip = local.getHostAddress();
			vo.setIp(ip);
			//log.info(ToStringBuilder.reflectionToString(vo));
			//log.info("1209 :"+ vo.getAttachList().size());
			// log.info("건수:"+vo.getAttachList().size());
			if (vo.getNum() == 0)
				service.add(vo);
			else
				service.update(vo);

			return new ResponseEntity<String>("succuess", HttpStatus.OK);
		}


	@GetMapping("/select")
	public void list(@RequestParam("code") Long code, Model model) {
		model.addAttribute("code", code);
		BoardAdminVO v = adminservice.get(code);
		model.addAttribute("v", v);

	}

	@PostMapping(value = "/select", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<BoardVO>> select(Criteria cri) {
		//log.info("select service:" + cri.getKeyword());
		List<BoardVO> list = service.select(cri);
		// 보여줄 목록
		
		if(list.size() <= 0) {
			log.info("등록된 게시물이 없습니다.");
		}
//		log.info("총건수:" + list.get(0).getCnt());
		return new ResponseEntity<>(list, HttpStatus.OK);
//		return null;

	}

	

	@PostMapping("/delete")
	public ResponseEntity<String> delete(Long num, Model model) {
		int row = service.delete(num);
		if (row > 0) {
			return new ResponseEntity<String>("succuess", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

	@GetMapping("declarlist")
	public void declarlist() {

	}

	@PostMapping(value = "declarlist", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<DeclarVO>> List(Criteria cri) {
		log.info("select dservice:" + cri.getKeyword());
		// return null;
		return new ResponseEntity<>(dservice.select(cri), HttpStatus.OK);
	}

	@GetMapping("declarview")
	public void declarview(@RequestParam("idx") Long idx, Model model) {
		model.addAttribute("vo", dservice.read(idx));
	}

	@PostMapping("/declardelete")
	public ResponseEntity<String> declardelete(Long idx, Model model) {
		int row = dservice.delete(idx);
		if (row > 0) {
			return new ResponseEntity<String>("succuess", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}
	
	@GetMapping("/myselect")
	public void myselect() {

	}

	@PostMapping(value = "/myselect", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<BoardVO>> myselect(Long code, Criteria cri) {

		return new ResponseEntity<>(service.myselect(cri), HttpStatus.OK);

	}
	
	@GetMapping("/calendar")
	public void calendar() {
		
	}
	
	
	@GetMapping("/project")
	public void project() {

	}

	@GetMapping("/projectget")
	public void get(@RequestParam("num") Long num, Model model) {
		model.addAttribute("num", num);
		ProjectAdminVO vo = pservice.get(num);
		model.addAttribute("vo", vo);

	}
	
	@PostMapping(value = "/projectget", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ProjectAdminVO> get(@RequestParam Long num) {

		return new ResponseEntity<ProjectAdminVO>(pservice.get(num), HttpStatus.OK);
	}
	
	@GetMapping("/calendarview")
	public void calendarview() {
		
	}
}