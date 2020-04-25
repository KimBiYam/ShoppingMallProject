package com.myshop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myshop.domain.Criteria;
import com.myshop.domain.ReplyPageDTO;
import com.myshop.domain.ReplyVO;
import com.myshop.mapper.BoardMapper;
import com.myshop.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper replyMapper;
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	
	@Transactional
	@Override	
	public int register(ReplyVO vo) {
		// TODO Auto-generated method stub
		boardMapper.updateReplyCnt(vo.getBno(), 1);
		return replyMapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long rno) {
		// TODO Auto-generated method stub
		return replyMapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) {
		// TODO Auto-generated method stub
		return replyMapper.update(vo);
	}

	@Transactional
	@Override
	public int remove(Long rno) {
		// TODO Auto-generated method stub
		ReplyVO vo = replyMapper.read(rno);
		
		boardMapper.updateReplyCnt(vo.getBno(), -1);
		return replyMapper.delete(rno);
	}

	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long bno) {
		// TODO Auto-generated method stub
		return new ReplyPageDTO(
				replyMapper.getCountByBno(bno),
				replyMapper.getListWithPaging(cri, bno)
				);
	}
	
	

}
