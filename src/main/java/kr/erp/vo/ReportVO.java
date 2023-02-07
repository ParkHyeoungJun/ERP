package kr.erp.vo;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReportVO {
	public Long idx;
	public Long num;
	public String filename;
	public String uuid;
	public String writer;
	public Date day;
	public String updater;
	public String ip;
	public String sign;
	public String txt;
	public String sel;
	public List<ReportsubVO> arrList;
	public Long cnt;
	
	public String projectday; // 프로젝트 등록일 기억하기 위햐
}
