package kr.erp.mapper;

import java.util.List;

import kr.erp.vo.AttachVO;

public interface AttachMapper {
 public void add(AttachVO vo); 
 public int delete (AttachVO vo);
 
 public List<AttachVO> select(Long num);
 public int deleteAll(Long num);
}
