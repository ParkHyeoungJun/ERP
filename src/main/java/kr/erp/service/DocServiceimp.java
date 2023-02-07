package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.erp.mapper.DeclarMapper;
import kr.erp.mapper.DocMapper;
import kr.erp.vo.DocVO;
import lombok.Setter;
@Service
public class DocServiceimp implements DocService {
	 @Setter(onMethod_ = @Autowired) 
	 private DocMapper mapper;
	 
	@Override
	public void add(DocVO vo) {
		mapper.add(vo);

	}

	@Override
	public int modfiy(DocVO vo) {
		// TODO Auto-generated method stub
		return mapper.modfiy(vo);
	}

	@Override
	public int delete(Long idx) {
		// TODO Auto-generated method stub
		return mapper.delete(idx);
	}

	@Override
	public List<DocVO> select(Long prentidx) {
		// TODO Auto-generated method stub
		return mapper.select(prentidx);
	}

	@Override
	public DocVO get(Long idx) {
		// TODO Auto-generated method stub
		return mapper.get(idx);
	}

}
