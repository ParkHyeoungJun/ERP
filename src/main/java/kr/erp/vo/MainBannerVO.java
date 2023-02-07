package kr.erp.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MainBannerVO {
	public Long idx;
	public Long num;
	public String link;
	public String image;
	public String ip;
	public Date day;
	public String writer;
	public String simg;
	
	public String daytostring;//날짜 불러오기
}