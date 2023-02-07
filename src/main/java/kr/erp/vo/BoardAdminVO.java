package kr.erp.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardAdminVO {
	private Long code;
    private boolean reply;
    private boolean answer;
    private boolean editor;
    private boolean attach;
    private boolean declar;
    private boolean auth;
    private String title;
    private String writer;
    private Date day;
    private String updater;
    private Date updatedate;
    private String ip;
}