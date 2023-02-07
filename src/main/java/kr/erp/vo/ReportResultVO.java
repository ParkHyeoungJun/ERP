package kr.erp.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class ReportResultVO {
	public Long      idx ; // 
	public Long      num ; 
	public String    dept;
	public String    filename;
	public String    uuid;
	public String    writer;
	public Date    	 day;
	public String    ip;
	public String	 sign; // 
	public String	 job; //
	public Long cnt;
	
}
