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

import kr.erp.service.BoardAdminService;
import kr.erp.vo.BoardAdminVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/admin/boardadmin/*")
@AllArgsConstructor
public class BoardAdminController {
// 
	private BoardAdminService service;

	@GetMapping("/list")
	public void list() {

	}

	@GetMapping("/add")
	public void add() {

	}

	@PostMapping(value = "/listajax", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<BoardAdminVO>> listajax() {
		// List<BoardAdminVO> list=service.select()
		return new ResponseEntity<>(service.select(), HttpStatus.OK);
	}
	
	@PostMapping(value = "/get", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<BoardAdminVO> get(@RequestParam Long code) {
		// List<BoardAdminVO> list=service.select()
		return new ResponseEntity<BoardAdminVO>(service.get(code), HttpStatus.OK);
	}

	/// 입력 or 수정 같이
	@PostMapping("/addajax")
	public ResponseEntity<String> addajax(BoardAdminVO vo, Model model) {
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
		if (vo.getCode() == 0) {//code값을 못받아옴 왜?
			service.add(vo);
		}
		else {
			service.update(vo);
		}
		return new ResponseEntity<String>("succuess", HttpStatus.OK);
	}

	
	@PostMapping("/deletedajax")
	public ResponseEntity<String> deletedajax(Long code, Model model) {
		int row =service.delete(code);
		if(row>0)
		{
			return new ResponseEntity<String>("succuess", HttpStatus.OK);
		}
		else
		{
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);	
		}
	
	}
}
