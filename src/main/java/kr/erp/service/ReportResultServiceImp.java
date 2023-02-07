package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.erp.mapper.ReportResultMapper;
import kr.erp.vo.ReportResultVO;
import lombok.Setter;
@Service
public class ReportResultServiceImp implements ReportResultService {
	@Setter(onMethod_ = @Autowired)   
	private ReportResultMapper mapper;

	@Override
	public void add(ReportResultVO vo) {
		// TODO Auto-generated method stub
		mapper.add(vo);
	}

	@Override
	public int delete(Long idx) {
		// TODO Auto-generated method stub
		return mapper.delete(idx);
	}

	@Override
	public List<ReportResultVO> get(ReportResultVO vo) {
		// TODO Auto-generated method stub
		return mapper.get(vo);
	}
	

}
