package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.erp.mapper.AttachMapper;
import kr.erp.vo.AttachVO;
import lombok.Setter;	
@Service
public class AttachServiceimp implements AttachService{
	@Setter(onMethod_ = @Autowired)	
	private AttachMapper mapper;

	@Override
	public void add(AttachVO vo) {
		// TODO Auto-generated method stub
		mapper.add(vo);
	}

	@Override
	public int delete(AttachVO vo) {
		// TODO Auto-generated method stub
		return mapper.delete(vo);
	}

	

	@Override
	public List<AttachVO> select(Long num) {
		// TODO Auto-generated method stub
		return mapper.select(num);
	}
	

	
	
}
