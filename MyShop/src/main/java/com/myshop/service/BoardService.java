package com.myshop.service;

import java.util.List;

import com.myshop.domain.BoardVO;

public interface BoardService {
//	�۾���
//	����Ʈ
//	�󼼺���
//	����
//	����
	public void boardInsert(BoardVO board);
	public List<BoardVO> boardList(int type);
	public BoardVO boardGet(Long bnum);
	public void boardUpdate(BoardVO board);
	public void boardDelete(Long bnum);
}