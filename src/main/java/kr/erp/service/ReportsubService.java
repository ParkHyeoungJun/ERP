package kr.erp.service;

import java.util.List;

import kr.erp.vo.ReportsubVO;

public interface ReportsubService {
	public void add(ReportsubVO vo);
	public List<ReportsubVO> getview(ReportsubVO vo);
}
