package kr.erp.service;

import java.util.List;

import kr.erp.vo.Criteria;
import kr.erp.vo.DeclarVO;

public interface DeclarService {
	 public void add(DeclarVO vo);
	   
	   public List<DeclarVO> select(Criteria cri);

	   public DeclarVO read(Long idx);

	   public int delete(Long idx);

	   public List<DeclarVO> Cselect(Criteria cri);
}
