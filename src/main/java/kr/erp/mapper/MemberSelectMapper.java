package kr.erp.mapper;

import java.util.List;

import kr.erp.vo.MemberSelectVO;

public interface MemberSelectMapper {
	public int add(MemberSelectVO vo);

	public int delete(Long idx);

	public int update(MemberSelectVO vo);
	
	public MemberSelectVO get(Long idx);
	
	public List<MemberSelectVO> select(Long num);

	public int deleteAll(Long num);
	
	public MemberSelectVO read(MemberSelectVO vo);
}