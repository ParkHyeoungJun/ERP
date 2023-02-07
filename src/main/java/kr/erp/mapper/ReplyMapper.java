package kr.erp.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.erp.vo.ReplyVO;

public interface ReplyMapper {

	public int add (ReplyVO vo);
	public int modfiy(ReplyVO vo);
	public int delete(Long idx);
	public List<ReplyVO> select(Long num);
	
	public ReplyVO idx(Long idx);
	
	public int deleteAll(Long num);
	public void updateReplyCnt(@Param("num") Long num, @Param("amount") int amount);
}
