package kr.erp.service;

import java.util.List;

import kr.erp.vo.BoardVO;
import kr.erp.vo.Criteria;

public interface BoardService {
	public int clientupdate(BoardVO vo);

	public void insertSelectKey(BoardVO vo);

	public int delete(Long num);

	public void add(BoardVO vo);

	public List<BoardVO> select(Criteria cri);

	public BoardVO get(Long code);

	public int update(BoardVO vo);
	public List<BoardVO> myselect(Criteria cri);
}
