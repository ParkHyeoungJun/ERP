package kr.erp.vo;

	import java.util.Date;
	import java.util.List;

	import lombok.Getter;
	import lombok.Setter;

	@Setter
	@Getter
	public class MemberVO {
		public String userid;
		public String userpw;
		public String username;
		public String sex;
		public String birth;
		public String email;
		public String zip;
		public String addr1;
		public String addr2;
		public String phone;
		public String hp;
		public String job;
		public String dept;
		public Date day;
		public Long bonus;
		public List<AuthVO> authList;
		public Long cnt;
	}