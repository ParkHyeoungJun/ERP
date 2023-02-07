package kr.erp.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.erp.service.MemberService;
import kr.erp.vo.Dept;
import kr.erp.vo.Job;
import kr.erp.vo.MemberVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {

	private MemberService service;

//회원 가입 보여준 페이지

	// 부서
	@PostMapping(value = "/dept", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Dept>> dept() {
		List<Dept> list = new ArrayList<>();
		Dept d1 = new Dept("10", "인사부");
		Dept d2 = new Dept("20", "총무부");
		Dept d3 = new Dept("30", "회계부");
		Dept d4 = new Dept("40", "기획부");
		Dept d5 = new Dept("50", "영업부");

		list.add(d1);
		list.add(d2);
		list.add(d3);
		list.add(d4);
		list.add(d5);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	/// 직책
	@PostMapping(value = "/job", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Job>> job() {
		List<Job> list = new ArrayList<>();
		Job d1 = new Job("01", "사원");
		Job d2 = new Job("02", "주임");
		Job d3 = new Job("03", "전임");
		Job d4 = new Job("04", "선임");
		Job d5 = new Job("05", "대리");
		Job d6 = new Job("06", "과장");
		Job d7 = new Job("07", "차장");
		Job d8 = new Job("08", "부장");
		Job d9 = new Job("09", "이사");
		Job d10 = new Job("10", "상무");
		Job d11 = new Job("11", "전무");
		Job d12 = new Job("12", "부사장");
		Job d13 = new Job("13", "사장");
		Job d14 = new Job("14", "부회장");
		Job d15 = new Job("15", "회장");
		list.add(d1);
		list.add(d2);
		list.add(d3);
		list.add(d4);
		list.add(d5);
		list.add(d6);
		list.add(d7);
		list.add(d8);
		list.add(d9);
		list.add(d10);
		list.add(d11);
		list.add(d12);
		list.add(d13);
		list.add(d14);
		list.add(d15);
		return new ResponseEntity<>(list, HttpStatus.OK);
	}

	/// 아이디 중복확인
	@PostMapping("/existid")
	public ResponseEntity<String> existid(String userid, Model model) {
		MemberVO vo = service.existid(userid);
		if (vo != null) {
			return new ResponseEntity<String>("no", HttpStatus.OK);
		} else
			return new ResponseEntity<String>("ok", HttpStatus.OK);
	}

	@GetMapping("detils")
	// @PreAuthorize("isAuthenticated()") // 로그인한 사용자만 접근
	public void detils(Authentication authentication, Model model) {

		String userid = "";

		try {
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			userid = userDetails.getUsername();
			MemberVO vo = service.read(userid);
			model.addAttribute("user", vo);
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			if (userid != null)
				model.addAttribute("userid", userid);
		}
	}

	@PostMapping(value = "/memberselect", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<MemberVO>> memberselect(String dept, String job) {
		return new ResponseEntity<>(service.memberselect(dept, job), HttpStatus.OK);
	}

	// 나의 정보 수정
	@PostMapping("detils")
	public ResponseEntity<String> detils(MemberVO vo) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		vo.setUserpw(passwordEncoder.encode(vo.getUserpw()));
		int row = service.update(vo);
		if (row > 0) {
			return new ResponseEntity<String>("succuess", HttpStatus.OK);
		} else
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}

	// 개인별 실적차트 조회
	@PostMapping(value = "/bonuslist", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<MemberVO>> bonuslist() {
		return new ResponseEntity<>(service.bonuslist(), HttpStatus.OK);
	}

	// 부서별
	@PostMapping(value = "/bonuslistdept", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<MemberVO>> bonuslistdept() {
		return new ResponseEntity<>(service.bonuslistdept(), HttpStatus.OK);
	}

	// 직책별
	@PostMapping(value = "/bonuslistjob", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<MemberVO>> bonuslistjob() {
		return new ResponseEntity<>(service.bonuslistjob(), HttpStatus.OK);
	}

	// 최우수 사원
	@PostMapping(value = "/firstper", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<MemberVO>> firstper() {
		return new ResponseEntity<>(service.firstper(), HttpStatus.OK);
	}

	// 최우수 부서
	@PostMapping(value = "/firstdept", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<MemberVO>> firstdept() {
		return new ResponseEntity<>(service.firstdept(), HttpStatus.OK);
	}

	// 월별 개인 차트
	@PostMapping(value = "/mbonuslist", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<MemberVO>> mbonuslist() {
		return new ResponseEntity<>(service.mbonuslist(), HttpStatus.OK);
	}

	// 월별 부서 차트
	@PostMapping(value = "/mbonuslistdept", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<MemberVO>> mbonuslistdept() {
		return new ResponseEntity<>(service.mbonuslistdept(), HttpStatus.OK);
	}

	// 월별 직책 차트
	@PostMapping(value = "/mbonuslistjob", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<MemberVO>> mbonuslistjob() {
		return new ResponseEntity<>(service.mbonuslistjob(), HttpStatus.OK);
	}

	// 월별 최우수 사원
	@PostMapping(value = "/mfirstper", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<MemberVO>> mfirstper() {
		return new ResponseEntity<>(service.mfirstper(), HttpStatus.OK);
	}

	// 월별 최우수 부서
	@PostMapping(value = "/mfirstdept", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<MemberVO>> mfirstdept() {
		return new ResponseEntity<>(service.mfirstdept(), HttpStatus.OK);
	}

	// 이미 선택된 담당자는 표시되지 않게 하기
	@PostMapping(value = "/memberselect2", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<MemberVO>> memberselect2(String dept, String job, Long num) {
		return new ResponseEntity<>(service.memberselect2(dept, job, num), HttpStatus.OK);
	}
}
