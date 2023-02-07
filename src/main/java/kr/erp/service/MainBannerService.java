package kr.erp.service;

import java.util.List;

import kr.erp.vo.MainBannerVO;

public interface MainBannerService {
	public void add(MainBannerVO vo);

	public List<MainBannerVO> select();

	public int delete(Long idx);
}