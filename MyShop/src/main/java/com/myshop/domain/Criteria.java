package com.myshop.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum;
	private int amount;

	private String type;
	private String keyword;
	
	private int btype;

	public Criteria() {
		this(1, 15, 1);		
	}

	public Criteria(int pageNum, int amount, int btype) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.btype = btype;
	}

	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
	
	public String getListLink() {
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("btype", this.getBtype())
				.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
		
	}

}
