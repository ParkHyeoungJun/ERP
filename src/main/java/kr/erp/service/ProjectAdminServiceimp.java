package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.erp.mapper.MemberMapper;
import kr.erp.mapper.MemberSelectMapper;
import kr.erp.mapper.ProjectAdminMapper;
import kr.erp.vo.Criteria;
import kr.erp.vo.ProjectAdminVO;
import lombok.Setter;

@Service
public class ProjectAdminServiceimp implements ProjectAdminService{
	@Setter(onMethod_ = @Autowired)	
	private ProjectAdminMapper mapper;
	@Setter(onMethod_ = @Autowired)	
	private MemberSelectMapper membermapper;
	@Override
	public void add(ProjectAdminVO vo) {
		// TODO Auto-generated method stub
		mapper.add(vo);
	}

	@Override
	public int update(ProjectAdminVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public int delete(Long num) {
		// TODO Auto-generated method stub
		membermapper.deleteAll(num);
		
		return mapper.delete(num);
	}




	@Override
	public ProjectAdminVO get(Long num) {
		// TODO Auto-generated method stub
		return mapper.get(num);
	}

	@Override
	public List<ProjectAdminVO> select(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.select(cri);
	}

	
	@Override
	public ProjectAdminVO projectget(Long num) {
		// TODO Auto-generated method stub
		return mapper.projectget(num);
	}

	@Override
	public List<ProjectAdminVO> pselect(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.pselect(cri);
	}

	public List<ProjectAdminVO> myreport(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.myreport(cri);
	}

	@Override
	public List<ProjectAdminVO> allproject(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.allproject(cri);
	}

}