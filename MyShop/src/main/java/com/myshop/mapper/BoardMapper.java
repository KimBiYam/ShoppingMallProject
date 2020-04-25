package com.myshop.mapper;

import java.util.List;

import com.myshop.domain.BoardVO;
import com.myshop.domain.Criteria;

public interface BoardMapper {
//	�۾���
//	����Ʈ
//	�󼼺���
//	����
//	����
//	��ȸ��
//	�� ����
//	ȸ�� Ż�� �� �� ����
	public void boardInsert(BoardVO board);
	public List<BoardVO> boardList(Criteria cri);
	public BoardVO boardGet(Long bnum);
	public void boardUpdate(BoardVO board);
	public void boardDelete(Long bnum);
	public void viewcnt(Long bnum);
	public void getcount(int type);
	public void userDelete(String userid);
}
