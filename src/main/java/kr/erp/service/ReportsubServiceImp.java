package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.erp.mapper.ReportsubMapper;
import kr.erp.vo.ReportsubVO;
import lombok.Setter;
@Service
public class ReportsubServiceImp implements ReportsubService {
	@Setter(onMethod_ = @Autowired)	
	private ReportsubMapper mapper;
	@Override
	public void add(ReportsubVO vo) {
		mapper.add(vo);
		
	}
	@Override
	public List<ReportsubVO> getview(ReportsubVO vo) {
		// TODO Auto-generated method stub
		return mapper.getview(vo);
	}
}
