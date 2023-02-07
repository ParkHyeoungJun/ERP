package kr.erp.mapper;

import java.util.List;

import kr.erp.vo.DocVO;

public interface DocMapper {
	public void add(DocVO vo);
	public int modfiy(DocVO vo);
	public int  delete(Long idx);	
	public List<DocVO> select(Long prentidx);
	public DocVO get(Long idx);
}
