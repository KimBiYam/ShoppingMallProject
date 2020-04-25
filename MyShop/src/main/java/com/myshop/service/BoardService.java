package com.myshop.service;

import java.util.List;

import com.myshop.domain.BoardVO;
import com.myshop.domain.Criteria;

public interface BoardService {
//	글쓰기
//	리스트
//	상세보기
//	수정
//	삭제
	public void boardInsert(BoardVO board);
	public List<BoardVO> boardList(Criteria cri);
	public BoardVO boardGet(Long bnum);
	public void boardUpdate(BoardVO board);
	public void boardDelete(Long bnum);
	public void viewcnt(Long bnum);
	public int getcount(Criteria cri);
}
