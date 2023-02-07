package kr.erp.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReportsubVO {
	public Long idx;
	public String sel ;
	public String txt;
	public String writer;
	public Date day;
	public String updater;
	public String ip;
	public String daytostring; // 문자형으로 반환 하기위해	
}
