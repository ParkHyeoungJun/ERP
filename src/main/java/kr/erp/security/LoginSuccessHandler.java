package kr.erp.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
//		log.error("onAuthenticationSuccess");
//		log.fatal("onAuthenticationSuccess");
	log.warn("onAuthenticationSuccess");
		
		
		List<String> roleNames = new ArrayList<>();
		authentication.getAuthorities().forEach(auth -> {
			roleNames.add(auth.getAuthority());
		});
		if (roleNames.contains("ROLE_ADMIN")) {
			response.sendRedirect("/admin/member/list");
			return;
		}
		else  {
			response.sendRedirect("/");
			return;
		}
//		response.sendRedirect("/");
	}
}
