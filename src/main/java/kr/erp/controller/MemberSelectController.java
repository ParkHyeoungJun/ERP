package kr.erp.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.erp.service.MemberSelectService;
import kr.erp.vo.MemberSelectVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/memberselect/*") // replies어쩌고 하면 매핑하라.
@Controller
@Log4j
@AllArgsConstructor
public class MemberSelectController {
	private MemberSelectService service;

	@PostMapping(value = "/select", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<MemberSelectVO>> select(Long num) {
		// List<BoardAdminVO> list=service.select()
		return new ResponseEntity<>(service.select(num), HttpStatus.OK);
	}

	

	@PostMapping("/delete")
	public ResponseEntity<String> memberdelete(Long idx, Model model) {
		int row = service.delete(idx);
		if (row > 0) {
			return new ResponseEntity<String>("succuess", HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}

	}

}