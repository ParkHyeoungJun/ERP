package kr.erp.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Personal {
	private String code;
	private String name;
	   
	public Personal(String code,String name) {
		this.code = code;
	    this.name = name;	   
	}
}