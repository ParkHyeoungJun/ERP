package kr.erp.mapper;

import java.util.List;

import kr.erp.vo.ReportVO;

public interface ReportMapper {
	public void add(ReportVO vo); // 입력 
	
	public int delete (Long idx); // 삭제 
	
	public ReportVO get(Long num); // 상세 
	
	
	public ReportVO detils(ReportVO vo);
}
