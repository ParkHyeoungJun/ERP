package kr.erp.service;

import java.util.List;

import kr.erp.vo.AuthVO;

public interface MemberAuthService {
	public int add(AuthVO vo);

	public int delete(AuthVO vo);

	public List<AuthVO> select(String userid);
	
	public List<AuthVO> authselect(String userid);
}
