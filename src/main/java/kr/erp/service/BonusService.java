package kr.erp.service;

import java.util.List;

import kr.erp.vo.BonusVO;
import kr.erp.vo.Criteria;

public interface BonusService {
	public void add(BonusVO vo);

	public List<BonusVO> select(Criteria cri);

	public int update(BonusVO vo);

	public int delete(Long idx);
	
	public int pjdelete(Long num);
     
}