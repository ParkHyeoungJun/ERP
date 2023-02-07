package kr.erp.service;

import java.util.List;

import kr.erp.vo.AttachVO;

public interface AttachService {
	 public void add(AttachVO vo); 
	 public int delete (AttachVO vo);
	 
	 public List<AttachVO> select(Long num);
}
