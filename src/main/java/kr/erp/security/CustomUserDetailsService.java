package kr.erp.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

import kr.erp.mapper.MemberMapper;
import kr.erp.vo.CustomUser;
import kr.erp.vo.MemberVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;

	@Override
	public UserDetails loadUserByUsername(String username) {
//		log.warn("Load User By UserName : " + username);

		MemberVO vo = mapper.read(username);
//      if(vo.getAuthList()!=null)
//      {
//    	  log.warn("queried by auth size 0: "+ vo.getAuthList().get(0).getAuth());
//    	  log.warn("queried by auth size 1: "+ vo.getAuthList().get(1).getAuth());
//      }

//		CustomUser cu = null;

//		try {
//			cu = new CustomUser(vo);
//		} catch (Exception e) {
//			log.info("cu error:" + e.getMessage());
//		}
//		log.warn("cu555 : " + cu.getAuthorities());

		return vo == null ? null : new CustomUser(vo);
	}

}