package kr.erp.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.erp.vo.Criteria;
import kr.erp.vo.MemberSelectVO;
import kr.erp.vo.MemberVO;

public interface MemberService {
	public int update(MemberVO vo); // 회원 수정

	public int membership(MemberVO vo);

	public MemberVO existid(String userid);

	public int delete(String userid);

	public MemberVO read(String userid);

	public List<MemberVO> select(Criteria cri);

	public MemberVO finduserid(MemberVO vo);

	public int pwdreset(MemberVO vo); // 패스워드 초기화후 변경

	public List<MemberVO> memberselect(@Param("dept") String dept, @Param("job") String job);

	public Long bonusplus(@Param("bonus") Long bonus, @Param("userid") String userid);

	public Long bonusminus(@Param("bonus") Long bonus, @Param("userid") String userid);

	public List<MemberVO> bonuslist();

	public List<MemberVO> bonuslistdept();

	public List<MemberVO> bonuslistjob();

	public List<MemberVO> firstper();

	public List<MemberVO> firstdept();
	
	public List<MemberVO> mbonuslist();

	public List<MemberVO> mbonuslistdept();

	public List<MemberVO> mbonuslistjob();

	public List<MemberVO> mfirstper();

	public List<MemberVO> mfirstdept();
	
	public List<MemberVO> memberselect2(@Param("dept") String dept, @Param("job") String job, @Param("num") Long num);
}
