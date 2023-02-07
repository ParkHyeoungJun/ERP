package kr.erp.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.erp.service.DeclarService;
import kr.erp.vo.Criteria;
import kr.erp.vo.DeclarVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/declar/*")
@AllArgsConstructor
public class MyPageController {
	private DeclarService dservice;

	@GetMapping("/mydeclar")
	public void mydeclar() {

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

	@GetMapping("declarlist")
	public void declarlist() {

	}

	@PostMapping(value = "declarlist", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<DeclarVO>> List(Criteria cri) {
		log.info("select dservice:" + cri.getKeyword()); 
		//return null;
		return new ResponseEntity<>(dservice.Cselect(cri), HttpStatus.OK);
	}

}