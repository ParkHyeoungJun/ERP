package kr.erp.vo;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
public class BoardVO {
	public Long num;
	public Long code;
	public Long parentnum;
	public Long depth;
	public boolean notice;
	public String title;
	public String content;
	public String ip;
	public Date day;
	public String writer;
	public String updater;
	public Date updatedate;
	public int cnt ;
	public int replycnt;
	public Long numkey;
	public String daytostring; // 문자형으로 반환 하기위해	
	public List<AttachVO> attachList;	
	
}
