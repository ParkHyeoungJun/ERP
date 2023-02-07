package kr.erp.service;

import java.util.List;

import kr.erp.vo.Criteria;
import kr.erp.vo.ScheduleVO;

public interface ScheduleService {
	public void add(ScheduleVO vo);
	
	public List<ScheduleVO> select(Criteria cri);

	public ScheduleVO get(Long num);

	public int delete(Long num);

	public void update(ScheduleVO vo);
	
	public List<ScheduleVO> calendar();
}
