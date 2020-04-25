package com.myshop.service;

import java.util.List;

import com.myshop.domain.BoardVO;
import com.myshop.domain.Criteria;

public interface BoardService {
//	�۾���
//	����Ʈ
//	�󼼺���
//	����
//	����
	public void boardInsert(BoardVO board);
	public List<BoardVO> boardList(Criteria cri);
	public BoardVO boardGet(Long bnum);
	public void boardUpdate(BoardVO board);
	public void boardDelete(Long bnum);
	public void viewcnt(Long bnum);
	public int getcount(Criteria cri);
}
