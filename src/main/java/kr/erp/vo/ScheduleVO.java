package kr.erp.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ScheduleVO {
	private Long num;
	private String startday;
	private String endday;
	private String title;
	private String content;	
	private String personal;
	private String writer;
	private Date day;
	private Date updatedate;
	private String ip;
	private Long cnt;
}