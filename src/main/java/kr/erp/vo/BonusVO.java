package kr.erp.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BonusVO {
	public Long idx;
	public Long num;
	public String userid;
	public Long bonus;
	public String con;
	public String ip;
	public Date day;
	public String writer;
	public String updater;
	public Date updatedate;
	public int cnt;
	
	public String daytostring;//날짜 불러오기
	public Long pastbonus;
}