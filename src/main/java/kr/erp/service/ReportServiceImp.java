package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.erp.mapper.ReportMapper;
import kr.erp.mapper.ReportsubMapper;
import kr.erp.vo.ReportVO;
import lombok.Setter;
@Service
public class ReportServiceImp implements ReportService {
	@Setter(onMethod_ = @Autowired)	
	private ReportMapper mapper;
	@Setter(onMethod_ = @Autowired)	
	private ReportsubMapper submapper;
	
	
	@Transactional
	@Override
	public void add(ReportVO vo) {
		mapper.add(vo);
		if (vo.getArrList() == null || vo.getArrList().size() <= 0) {
			return;
		}

		vo.getArrList().forEach(sub -> {
			sub.setIdx(vo.getIdx());
			sub.setIp(vo.getIp());
			sub.setWriter(vo.getWriter());
			submapper.add(sub);
		});
	}

	@Override
	public int delete(Long idx) {
		// TODO Auto-generated method stub
		return mapper.delete(idx);
	}

	@Override
	public ReportVO get(Long num) {
		// TODO Auto-generated method stub
		return mapper.get(num);
	}

	@Override
	public ReportVO detils(ReportVO vo) {
		// TODO Auto-generated method stub
		return mapper.detils(vo);
	}

}
