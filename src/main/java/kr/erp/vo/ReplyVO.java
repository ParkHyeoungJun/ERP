package kr.erp.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class ReplyVO {
public Long idx;
public Long num;
public String content;	
public String writer;
public Date day;
public String updater;
public Date updatedate;
public String ip;
public Long cnt;
}
