package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.erp.mapper.BonusMapper;
import kr.erp.vo.BonusVO;
import kr.erp.vo.Criteria;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BonusServiceimp implements BonusService{

	@Setter(onMethod_ = @Autowired)   
	   private BonusMapper mapper;
	
	@Override
	public void add(BonusVO vo) {
		// TODO Auto-generated method stub
		mapper.add(vo);
	}

	@Override
	public List<BonusVO> select(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.select(cri);
	}

	@Override
	public int update(BonusVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public int delete(Long idx) {
		// TODO Auto-generated method stub
		return mapper.delete(idx);
	}

	@Override
	public int pjdelete(Long num) {
		// TODO Auto-generated method stub
		return mapper.pjdelete(num);
	}
}
