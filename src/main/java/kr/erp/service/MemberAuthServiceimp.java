package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.erp.mapper.MemberAuthMapper;
import kr.erp.vo.AuthVO;
import lombok.Setter;
@Service
public class MemberAuthServiceimp implements MemberAuthService {
	@Setter(onMethod_ = @Autowired)	
	private MemberAuthMapper mapper;
	@Override
	public int add(AuthVO vo) {
		// TODO Auto-generated method stub
		return mapper.add(vo);
	}

	@Override
	public int delete(AuthVO vo) {
		// TODO Auto-generated method stub
		return mapper.delete(vo);
	}

	@Override
	public List<AuthVO> select(String userid) {
		// TODO Auto-generated method stub
		return mapper.select(userid);
	}

	@Override
	public List<AuthVO> authselect(String userid) {
		// TODO Auto-generated method stub
		return mapper.authselect(userid);
	}
}
