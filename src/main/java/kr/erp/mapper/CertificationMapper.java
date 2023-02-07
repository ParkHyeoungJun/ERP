package kr.erp.mapper;

import kr.erp.vo.CertificationVO;

public interface CertificationMapper {
	public void add(CertificationVO vo);
	public int delete (CertificationVO vo);
	
	public CertificationVO get(CertificationVO vo);
	
}
