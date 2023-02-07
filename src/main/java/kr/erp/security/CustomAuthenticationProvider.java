package kr.erp.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import kr.erp.vo.CustomUserDetails;
import lombok.extern.log4j.Log4j;
@Log4j
public class CustomAuthenticationProvider{
//	public class CustomAuthenticationProvider implements AuthenticationProvider {  
// 
////	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
//	
//    @Override
//    public boolean supports(Class<?> authentication) {
//        return authentication.equals(UsernamePasswordAuthenticationToken.class);
//    }
//
//	@Override
//	public Authentication authenticate(Authentication authentication)
//			throws AuthenticationException {
//		
//		String user_id = (String)authentication.getPrincipal();		
//		String user_pw = (String)authentication.getCredentials();
//		
//		
//		log.info("Welcome authenticate! {"+ user_id + "," + user_pw+"}");
//		
//		// check whether user's credentials are valid.
//		// if false, throw new BadCredentialsException(messages.getMessage("AbstractUserDetailsAuthenticationProvider.badCredentials", "Bad credentials"));
//		
//		
//		List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
//        roles.add(new SimpleGrantedAuthority("ROLE_MEMBER"));
//        
//        UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(user_id, user_pw, roles);
//        result.setDetails(new CustomUserDetails(user_id, user_pw));
//		return result;
//        
//		
//	}
}