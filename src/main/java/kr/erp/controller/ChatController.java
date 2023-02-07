package kr.erp.controller;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.erp.vo.CustomUser;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class ChatController {

	@GetMapping("/chat")
	public void chat(Model model) {
		CustomUser user= null;
		try {
			user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		} catch (Exception e) {
			// TODO: handle exception
		}	
		if(user != null)
		model.addAttribute("userid", user.getUsername());
	}
}
