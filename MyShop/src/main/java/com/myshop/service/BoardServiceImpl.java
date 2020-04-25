package com.myshop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myshop.domain.BoardVO;
import com.myshop.domain.Criteria;
import com.myshop.mapper.BoardMapper;
import com.myshop.mapper.ReplyMapper;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService{
	@Setter(onMethod_= @Autowired)
	BoardMapper boardMapper;
	@Setter(onMethod_= @Autowired)
	ReplyMapper replyMapper;
	

	@Override
	public void register(BoardVO board) {
		// TODO Auto-generated method stub
		boardMapper.register(board);		
	}

	@Override
	public BoardVO get(Long bno) {
		// TODO Auto-generated method stub
		return boardMapper.get(bno);
	}

	@Override
	public List<BoardVO> list() {
		// TODO Auto-generated method stub
		return boardMapper.list();
	}

	@Override
	public void modify(BoardVO board) {
		// TODO Auto-generated method stub
		boardMapper.modify(board);
	}

	@Override
	@Transactional	
	public void delete(Long bno) {
		// TODO Auto-generated method stub
		replyMapper.deleteByBno(bno);
		boardMapper.delete(bno);
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		// TODO Auto-generated method stub
		return boardMapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return boardMapper.getTotalCount(cri);
	}

	@Override
	public void viewcnt(Long bno) {
		// TODO Auto-generated method stub
		boardMapper.viewcnt(bno);
	}
	
	

}
