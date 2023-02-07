package kr.erp.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Content {
	private String code;
	private String name;

	public Content(String code, String name) {
		this.code = code;
		this.name = name;
	}
}