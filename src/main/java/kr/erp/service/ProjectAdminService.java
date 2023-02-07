package kr.erp.service;

import java.util.List;

import kr.erp.vo.Criteria;
import kr.erp.vo.ProjectAdminVO;

public interface ProjectAdminService {
public void add(ProjectAdminVO vo);
	
	public int update(ProjectAdminVO vo);
	
	public int delete(Long num);

	public ProjectAdminVO get(Long num);

	public List<ProjectAdminVO> select(Criteria cri);
	
	public ProjectAdminVO projectget(Long num);
	public List<ProjectAdminVO> pselect(Criteria cri);
	
	public List<ProjectAdminVO> myreport(Criteria cri); 
	public List<ProjectAdminVO> allproject(Criteria cri);
}
