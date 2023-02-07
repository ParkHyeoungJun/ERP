package kr.erp.mapper;

import java.util.List;

import kr.erp.vo.MainBannerVO;

public interface MainBannerMapper {
	public void add(MainBannerVO vo);

	public List<MainBannerVO> select();

	public int delete(Long idx);
     
}