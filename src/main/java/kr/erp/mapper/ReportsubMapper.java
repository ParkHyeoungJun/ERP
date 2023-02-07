package kr.erp.mapper;

import java.util.List;

import kr.erp.vo.ReportsubVO;

public interface ReportsubMapper {
	public void add(ReportsubVO vo);
	
	public List<ReportsubVO> getview(ReportsubVO vo);
}
