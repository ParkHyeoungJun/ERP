package kr.erp.service;

import java.util.List;

import kr.erp.vo.ReplyVO;


public interface ReplyService {
	public int add(ReplyVO vo);

	public int modfiy(ReplyVO vo);

	public int delete(Long idx);

	public List<ReplyVO> select(Long num);
}
