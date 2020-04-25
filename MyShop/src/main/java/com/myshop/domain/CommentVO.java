package com.myshop.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CommentVO {
	
	private Long cnum;
	private Long bnum;	
	private String userid;
	private String content;
	private Date regdate;

}
