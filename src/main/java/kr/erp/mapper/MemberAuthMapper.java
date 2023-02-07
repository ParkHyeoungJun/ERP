package kr.erp.mapper;

import java.util.List;

import kr.erp.vo.AuthVO;

public interface MemberAuthMapper {
	public int add(AuthVO vo);

	public int delete(AuthVO vo);

	public List<AuthVO> select(String userid);
	
	public List<AuthVO> authselect(String userid);
}
