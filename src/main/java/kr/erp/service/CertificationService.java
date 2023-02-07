package kr.erp.service;

import kr.erp.vo.CertificationVO;

public interface CertificationService {
	public void add(CertificationVO vo);
	public int delete (CertificationVO vo);
	
	public CertificationVO get(CertificationVO vo);
}
