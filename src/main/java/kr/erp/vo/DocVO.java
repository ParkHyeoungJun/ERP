package kr.erp.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DocVO {
	public Long idx;
	public Long num;
	public String filetype;
	public String filename;
	public String uuid;
	public Long prentidx;
	public String ip;
	public Date day;
	public String writer;
	public String updater;
	public Date updatedate;
	public int cnt;
	public Long depth;
}
