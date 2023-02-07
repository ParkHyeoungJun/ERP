package kr.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.erp.mapper.MainBannerMapper;
import kr.erp.vo.MainBannerVO;
import lombok.Setter;

@Service
public class MainBannerServiceimp implements MainBannerService {
	@Setter(onMethod_ = @Autowired) 
	private MainBannerMapper mapper;
	 
	@Override
	public void add(MainBannerVO vo) {
		// TODO Auto-generated method stub
		mapper.add(vo);
	}

	@Override
	public List<MainBannerVO> select() {
		// TODO Auto-generated method stub
		return mapper.select();
	}

	@Override
	public int delete(Long idx) {
		// TODO Auto-generated method stub
		return mapper.delete(idx);
	}

}