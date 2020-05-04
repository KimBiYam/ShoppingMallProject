package com.myshop.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	private Long bno;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private int replycnt;
	private int viewcnt;
	private String name;
	

}
