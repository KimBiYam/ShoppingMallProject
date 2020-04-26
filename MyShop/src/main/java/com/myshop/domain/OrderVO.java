package com.myshop.domain;

import java.util.Date;

import lombok.Data;

@Data
public class OrderVO {
	private String orderid;
	private String userid;
	private String addr;
	private String tel;
	private String approval;
	private String productname;
	private int productprice;
	private String src;
	private int amount;
	private String ordercode;
	private Date orderdate;
	private int rownum;
	private int productid;
	private String ordername;
	
}
