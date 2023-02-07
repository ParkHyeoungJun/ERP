package kr.erp.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.CookieClearingLogoutHandler;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.security.web.authentication.rememberme.AbstractRememberMeServices;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.erp.service.MemberAuthService;
import kr.erp.service.MemberService;
import kr.erp.util.LoginInfo;
import kr.erp.vo.AuthVO;
import kr.erp.vo.MemberVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Log4j
@Controller
@AllArgsConstructor
public class HomeController {

	// private static final Logger log =
	// LoggerFactory.getLogger(HomeController.class);
	private MemberService service;
	private MemberAuthService authservice;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Authentication authentication,Locale locale, Model model) {
		String userid = "";

		try {
			UserDetails userDetails = (UserDetails) authentication.getPrincipal();
			userid = userDetails.getUsername();
			//MemberVO vo = service.read(userid);
			//model.addAttribute("user", vo);
		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			if (userid != null)
				model.addAttribute("userid", userid);
		}
		return "home";
	}
	@GetMapping("/login")
	public void loginInput(String error, String logout, Model model) {
		if (error != null)
			model.addAttribute("error", error);
		if (logout != null)
			model.addAttribute("logout", "로그아웃");
	}

	@GetMapping("/logout")
	public void logoutGet() {
		log.info("custom logout");
	}

	@PostMapping("myout")
	public void mylogout(HttpServletRequest request, HttpServletResponse response) {
		CookieClearingLogoutHandler cookieClearingLogoutHandler = new CookieClearingLogoutHandler(
				AbstractRememberMeServices.SPRING_SECURITY_REMEMBER_ME_COOKIE_KEY);
		SecurityContextLogoutHandler securityContextLogoutHandler = new SecurityContextLogoutHandler();
		cookieClearingLogoutHandler.logout(request, response, null);
		securityContextLogoutHandler.logout(request, response, null);

	}

	@GetMapping("/finduserid")
	public void finduserid() {

	}

	// ResponseEntity
	@PostMapping(value = "/finduserid")
	public ResponseEntity<String> finduserid(MemberVO vo) {

		MemberVO data = service.finduserid(vo);
		
			return new ResponseEntity<String>(data.getUserid(), HttpStatus.OK);
		//if (data != null && data != "") {
//			return new ResponseEntity<String>(data, HttpStatus.OK);
//		} else
//			return new ResponseEntity<String>("no", HttpStatus.OK);
	}

	@GetMapping("/membership")
	public void membership() {

	}

	@PostMapping("/memberjoin")
	public ResponseEntity<String> memberjoin(MemberVO vo, Model model) {

		// log.info("birth:"+vo.getBirth());
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		vo.setUserpw(passwordEncoder.encode(vo.getUserpw()));

		log.info("userpw:" + vo.getUserpw());
		int row = service.membership(vo);
		if (row > 0) {
			AuthVO auth = new AuthVO();
			auth.setUserid(vo.getUserid());
			auth.setAuth("ROLE_MEMBER"); // 회원 데이터 권한
			authservice.add(auth); // 회원가입되었다면 권한 주기
			return new ResponseEntity<String>("succuess", HttpStatus.OK);
		} else
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	@GetMapping("/findpwd")
	public void findpwd() {

	}

	@PostMapping("findpwd")
	public ResponseEntity<String> findpwd(MemberVO vo) {
		MemberVO data = service.finduserid(vo);
		if(data !=null)
		return new ResponseEntity<String>(data.getUserid(), HttpStatus.OK);
		else return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// 패스워드 초기화
	@GetMapping("/pwdreset")
	public void pwdreset(@RequestParam String userid, Model model) {
		model.addAttribute("userid", userid);
	}

	// 패스워드 초기화
	@PostMapping("/pwdreset")
	public ResponseEntity<String> pwdreset(MemberVO vo) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		vo.setUserpw(passwordEncoder.encode(vo.getUserpw()));
		int row = service.pwdreset(vo);
		if (row > 0) {
			return new ResponseEntity<String>("succuess", HttpStatus.OK);
		} else
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}

	@GetMapping("/clientcharts")
	public void clientcharts() {

	}

	@GetMapping("/bonus")
	public void bonus() {

	}

	@GetMapping("/test")
	public void test() {
	}

	@GetMapping("/test2")
	public void test2() {

	}

	@GetMapping("/test3")
	public void test3() {

	}

	@GetMapping("/test4")
	public void test4() {

	}
	
	@GetMapping("/test5")
	public void test5() {

	}
	
	
	@GetMapping("/alarm")
	public void alarm(Model model) {
			model.addAttribute("loginId", "phj830914");
	}
	@PostMapping("coercion")
	public void coercion() {
		LoginInfo.userid = "";
		LoginInfo.memberauth = "";
		LoginInfo.adminauth = "";
	}
}
