package com.myshop.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	private Long bnum;
	private	String userid;
	private String title;
	private String content;
	private Date regdate;
	private int type;
	private int viewcnt;
	private int commentcnt;
}
