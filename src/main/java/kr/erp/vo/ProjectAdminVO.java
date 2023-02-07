package kr.erp.vo;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProjectAdminVO {
	public Long num;
	public String title;//프로젝트 게시물명
	public String content;		
	public String ip;		
	public String startday;//프로젝트 시작 날짜
	public String endday;//프로젝트 끝나는 날짜
	public String writer;	
	public Date day;
	public String member;
	public String updater;
	public Date updatedate;
	public int cnt;
	
	public String daytostring;//날짜 불러오기
	public String useridsp;//id split
	public String usernamesp;//name split
	//public List<MemberSelectVO> arrList;
	public boolean progress;
	public String useridspplus;
	public Long bonus;
	public String con;
	public String pastprogress;
	public String userid;   // 자기 지정 프로젝트 알기 위해
	public String filename; // 확인 사인 sign 이미지 
	public String projectday; // 프로젝트 일정 알기 위해 추가 

	
	
}