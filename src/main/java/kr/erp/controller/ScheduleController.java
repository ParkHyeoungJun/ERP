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
import org.springframework.web.bind.annotation.RequestParam;

import kr.erp.mapper.ScheduleMapper;
import kr.erp.service.ProjectAdminService;
import kr.erp.service.ScheduleService;
import kr.erp.vo.Criteria;
import kr.erp.vo.DeclarVO;
import kr.erp.vo.Personal;
import kr.erp.vo.ProjectAdminVO;
import kr.erp.vo.ScheduleVO;
import kr.erp.vo.Sel;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/schedule/*")
@AllArgsConstructor
public class ScheduleController {
	private ScheduleService service;
	private ProjectAdminService pservice;
	@GetMapping("/select")
	public void select() {

	}

	@GetMapping("/add")
	public void add() {

	}

	@PostMapping("/add")
	public ResponseEntity<String> addajax(ScheduleVO vo, Model model) {
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
		} else {
			service.update(vo);
		}
		return new ResponseEntity<String>("succuess", HttpStatus.OK);
	}

	@PostMapping(value = "select", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ScheduleVO>> List(Criteria cri) {
		log.info("select service:" + cri.getKeyword());
		// return null;
		return new ResponseEntity<>(service.select(cri), HttpStatus.OK);
	}

	@GetMapping({ "/update", "/get" })
	public void get(@RequestParam("num") Long num, Model model) {
		model.addAttribute("num", num);
		ScheduleVO vo = service.get(num);
		model.addAttribute("vo", vo);
	}

	@PostMapping("/delete") 
	public ResponseEntity<String> deletedajax(Long num, Model model) { 
		int row =service.delete(num); 
		if(row>0) { 
			return new ResponseEntity<String>("succuess", HttpStatus.OK);
		} else { 
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
		}
	}

	@PostMapping(value = "/personal", produces = MediaType.APPLICATION_JSON_VALUE)
	   public ResponseEntity<List<Personal>> Personal() {
	      List<Personal> list = new ArrayList<>();
	      Personal p1 = new Personal("0","개인");
	      Personal p2 = new Personal("1","부서");
	      Personal p3 = new Personal("2","직책");

	      list.add(p1);
	      list.add(p2);
	      list.add(p3);
	      return new ResponseEntity<>(list, HttpStatus.OK);
	   }
	
	@GetMapping("/projectschedule")
	public void list() {

	}
	
	@PostMapping(value = "/projectschedule", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ProjectAdminVO>> pselect(Criteria cri) {

		return new ResponseEntity<>(pservice.pselect(cri), HttpStatus.OK);
	}
	
	@GetMapping("/projectget")
	public void projectgetget(@RequestParam("num") Long num, Model model) {
		model.addAttribute("num", num);
		ProjectAdminVO vo = pservice.projectget(num);
		model.addAttribute("vo", vo);
	}

	@PostMapping(value = "/calendar", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ScheduleVO>> calendar() {		
		return new ResponseEntity<>(service.calendar(), HttpStatus.OK);
	}
	
	
	
}
