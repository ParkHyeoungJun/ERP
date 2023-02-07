package kr.erp.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Dept {
	private String code;
	private String name;
	
	public Dept(String code,String name) {
		this.code =code;
		this.name = name;
	}
}
