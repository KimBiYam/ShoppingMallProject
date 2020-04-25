package com.myshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myshop.domain.Criteria;
import com.myshop.domain.ReplyVO;

public interface ReplyMapper {
	
	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long rno);
	
	public int delete(Long rno);
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("bno") Long bno);
	
	public int getCountByBno(Long bno);
	
	public int deleteByBno(Long bno);
	

}
