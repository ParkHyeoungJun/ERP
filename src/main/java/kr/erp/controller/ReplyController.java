package kr.erp.controller;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.erp.mapper.ReplyMapper;
import kr.erp.service.ReplyService;
import kr.erp.vo.ReplyVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/reply/*")
@AllArgsConstructor
public class ReplyController {
	private ReplyService service;

	// 입력 혹은 수정
	@PostMapping({ "/add" })
	public ResponseEntity<String> add(ReplyVO vo, Model model) {
		InetAddress local = null;
		try {
			local = InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String ip = local.getHostAddress();
		vo.setIp(ip);
		int reval = 0;
		if (vo.getIdx() == 0) {
			reval = service.add(vo);
		} else {
			reval = service.modfiy(vo);
		}

		if (reval > 0) {
			return new ResponseEntity<String>("succuess", HttpStatus.OK);
		} else
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 삭제
	@PostMapping("delete")
	public ResponseEntity<String> delete(Long idx, Model model)
	{
		int reval = 0; 
		reval = service.delete(idx);
		if (reval > 0) {
			return new ResponseEntity<String>("succuess", HttpStatus.OK);
		} else
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	
	// 조회 
	@PostMapping(value = "select",produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<ReplyVO>>Select(@RequestParam Long num)
	{
		log.info("num");
		return new ResponseEntity<>(service.select(num), HttpStatus.OK);
		
	}
}
