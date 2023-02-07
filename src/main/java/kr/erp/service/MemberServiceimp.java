package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kr.erp.mapper.MemberMapper;
import kr.erp.vo.Criteria;
import kr.erp.vo.MemberVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Service
@Log4j
public class MemberServiceimp implements MemberService {
	@Setter(onMethod_ = @Autowired)	
	private MemberMapper mapper;

	@Override
	public int membership(MemberVO vo) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	      //비밀번호 암호화하여 다시 vo객체에 저장
		String securPw = vo.getUserpw();
	      log.info(vo.getUserpw());
	      log.info(securPw);
	      vo.setUserpw(securPw);//DB에 넘겨주기 위해 암호화 된 비밀번호를 vo 객체에 저장

		return mapper.membership(vo);
	}

	@Override
	public int update(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public MemberVO existid(String userid) {
		// TODO Auto-generated method stub
		return mapper.existid(userid);
	}

	@Override
	public int delete(String userid) {
		// TODO Auto-generated method stub
		return mapper.delete(userid);
	}

	///로그인
	@Override
	public MemberVO read(String userid) {
		// TODO Auto-generated method stub
		return mapper.read(userid);
	}

	@Override
	public List<MemberVO> select(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.select(cri);
	}

	@Override
	public MemberVO finduserid(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.finduserid(vo);
	}

	@Override
	public int pwdreset(MemberVO vo) {
		// TODO Auto-generated method stub
		return mapper.pwdreset(vo);
	}

	@Override
	public List<MemberVO> memberselect(String dept, String job) {
		// TODO Auto-generated method stub
		return mapper.memberselect(dept, job);
	}
	
	@Override
	public Long bonusplus(Long bonus, String userid) {
		// TODO Auto-generated method stub
		return mapper.bonusplus(bonus, userid);
	}

	@Override
	public Long bonusminus(Long bonus, String userid) {
		// TODO Auto-generated method stub
		return mapper.bonusminus(bonus, userid);
	}
	
	
	@Override
	public List<MemberVO> bonuslist() {
		// TODO Auto-generated method stub
		return mapper.bonuslist();
	}

	@Override
	public List<MemberVO> bonuslistdept() {
		// TODO Auto-generated method stub
		return mapper.bonuslistdept();
	}

	@Override
	public List<MemberVO> bonuslistjob() {
		// TODO Auto-generated method stub
		return mapper.bonuslistjob();
	}

	@Override
	public List<MemberVO> firstper() {
		// TODO Auto-generated method stub
		return mapper.firstper();
	}

	@Override
	public List<MemberVO> firstdept() {
		// TODO Auto-generated method stub
		return mapper.firstdept();
	}
	
	
	@Override
	public List<MemberVO> mbonuslist() {
		// TODO Auto-generated method stub
		return mapper.mbonuslist();
	}

	@Override
	public List<MemberVO> mbonuslistdept() {
		// TODO Auto-generated method stub
		return mapper.mbonuslistdept();
	}

	@Override
	public List<MemberVO> mbonuslistjob() {
		// TODO Auto-generated method stub
		return mapper.mbonuslistjob();
	}

	@Override
	public List<MemberVO> mfirstper() {
		// TODO Auto-generated method stub
		return mapper.mfirstper();
	}

	@Override
	public List<MemberVO> mfirstdept() {
		// TODO Auto-generated method stub
		return mapper.mfirstdept();
	}
	
	
	@Override
	public List<MemberVO> memberselect2(String dept, String job, Long num) {
		// TODO Auto-generated method stub
		return mapper.memberselect2(dept, job, num);
	}
}
