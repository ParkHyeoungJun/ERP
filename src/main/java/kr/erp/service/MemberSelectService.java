package kr.erp.service;

import java.util.List;

import kr.erp.vo.MemberSelectVO;

public interface MemberSelectService {
	public int add(MemberSelectVO vo);

	public int delete(Long idx);

	public int update(MemberSelectVO vo);

	public MemberSelectVO get(Long idx);

	public List<MemberSelectVO> select(Long num);

	public MemberSelectVO read(MemberSelectVO vo);
}
