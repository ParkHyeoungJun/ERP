package kr.erp.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Job {
	private String code;
	private String name;
	
	public Job(String code,String name) {
		this.code =code;
		this.name = name;
	}
}
