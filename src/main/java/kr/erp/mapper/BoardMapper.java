package kr.erp.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.erp.vo.BoardVO;
import kr.erp.vo.Criteria;

public interface BoardMapper {
	public int clientupdate(BoardVO vo);

	public Long insertSelectKey(BoardVO vo);

	public int delete(Long num);

	public void add(BoardVO vo);

	public List<BoardVO> select(Criteria cri);

	public BoardVO get(Long code);

	public int update(BoardVO vo);

	public List<BoardVO> myselect(Criteria cri);
	public void updateReplyCnt(@Param("num") Long num, @Param("amount") int amount);
}
