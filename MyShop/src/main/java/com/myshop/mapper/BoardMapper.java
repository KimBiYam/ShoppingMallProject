package com.myshop.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myshop.domain.BoardVO;
import com.myshop.domain.Criteria;

public interface BoardMapper {
	//작성
	//조회
	//리스트
	//수정
	//삭제
	public void register(BoardVO board);
	public BoardVO get(Long bno);
	public List<BoardVO> list();
	public void modify(BoardVO board);
	public void delete(Long bno);
	public List<BoardVO> getListWithPaging(Criteria cri);
	public int getTotalCount(Criteria cri);
	public void viewcnt(Long bno);
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
