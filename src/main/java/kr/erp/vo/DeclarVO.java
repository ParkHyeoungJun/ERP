package kr.erp.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DeclarVO {
   private Long idx;
   private Long num;
   private Long code;
   private String title;
   private String content;
   private String sel;
   private String val;
   private String writer;
   private Date day;
   private String ip;
   
   private int cnt;
}