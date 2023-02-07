package kr.erp.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.erp.mapper.CertificationMapper;
import kr.erp.vo.CertificationVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Service
@Log4j
public class CertificationServiceImp implements CertificationService {
	 @Setter(onMethod_ = @Autowired)   
	CertificationMapper mapper;
	@Override
	public void add(CertificationVO vo) {
		// TODO Auto-generated method stub
		mapper.add(vo);
	}

	@Override
	public int delete(CertificationVO vo) {
		// TODO Auto-generated method stub
		return mapper.delete(vo);
	}

	@Override
	public CertificationVO get(CertificationVO vo) {
		// TODO Auto-generated method stub
		return mapper.get(vo);
	}

}
