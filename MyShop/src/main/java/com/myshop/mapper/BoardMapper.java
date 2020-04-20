package com.myshop.mapper;

import java.util.List;

import com.myshop.domain.BoardVO;

public interface BoardMapper {
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
	public void viewcnt(Long bnum);
	public void getcount(int type);
}