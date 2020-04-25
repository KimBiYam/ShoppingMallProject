package com.myshop.service;

import com.myshop.domain.Criteria;
import com.myshop.domain.ReplyPageDTO;
import com.myshop.domain.ReplyVO;

public interface ReplyService {
	
	public int register(ReplyVO vo);
	
	public ReplyVO get(Long rno);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long rno);
	
	public ReplyPageDTO getListPage(Criteria cri, Long bno);

}
