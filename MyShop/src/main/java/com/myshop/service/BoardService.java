package com.myshop.service;

import java.util.List;

import com.myshop.domain.BoardVO;
import com.myshop.domain.Criteria;

public interface BoardService {
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
	public List<BoardVO> getList(Criteria cri);
	public int getTotal(Criteria cri);
	public void viewcnt(Long bno);

}
