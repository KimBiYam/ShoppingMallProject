package com.myshop.service;

import java.util.List;

import com.myshop.domain.BoardVO;

public interface BoardService {
//	글쓰기
//	리스트
//	상세보기
//	수정
//	삭제
	public void boardInsert(BoardVO board);
	public List<BoardVO> boardList(int type);
	public BoardVO boardGet(Long bnum);
	public void boardUpdate(BoardVO board);
	public void boardDelete(Long bnum);
}
