package kr.erp.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SmsVO {

	public String form; // sms 보내는 사람 
	public String to; // sms 받는 사람 
	public String text; // 내용~
}
