package kr.erp.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AttachVO {
	public Long idx;
	public Long num;
	public String uploadpath;
	public String filename;
	public String uuid;
	public String writer;
	public Date day;
	public String updater;
	public Date updatedate;
	public String ip;
	public Long cnt;
}
