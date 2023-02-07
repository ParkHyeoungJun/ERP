package kr.erp.vo;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MemberSelectVO {
	public Long idx;
	public Long num;
	public String userid;
	public String username;
	public String useridsp;//id split
	public String usernamesp;//name split
}
