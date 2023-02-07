package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.erp.mapper.MemberSelectMapper;
import kr.erp.vo.MemberSelectVO;
import lombok.Setter;
@Service
public class MemberSelectServiceimp implements MemberSelectService{
	@Setter(onMethod_ = @Autowired)	
	private MemberSelectMapper mapper;
	
	@Override
	public int add(MemberSelectVO vo) {
		// TODO Auto-generated method stub
		return mapper.add(vo);
	}

	@Override
	public int delete(Long idx) {
		// TODO Auto-generated method stub
		return mapper.delete(idx);
	}

	@Override
	public List<MemberSelectVO> select(Long num) {
		// TODO Auto-generated method stub
		return mapper.select(num);
	}

	@Override
	public int update(MemberSelectVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public MemberSelectVO get(Long idx) {
		// TODO Auto-generated method stub
		return mapper.get(idx);
	}

	@Override
	public MemberSelectVO read(MemberSelectVO vo) {
		// TODO Auto-generated method stub
		return mapper.read(vo);
	}

}