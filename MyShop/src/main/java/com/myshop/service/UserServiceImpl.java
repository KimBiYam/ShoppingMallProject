package com.myshop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myshop.domain.AuthVO;
import com.myshop.domain.UserVO;
import com.myshop.mapper.BoardMapper;
import com.myshop.mapper.ProductMapper;
import com.myshop.mapper.ReplyMapper;
import com.myshop.mapper.UserMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService {
	@Autowired
	private UserMapper userMapper;
	@Autowired
	private ProductMapper productMapper; 
	@Autowired
	private PasswordEncoder pwencoder;
	@Autowired
	private BoardMapper boardMapper;
	@Autowired
	private ReplyMapper replyMapper;
	
	
	@Override
	@Transactional
	public void userJoin(UserVO user, AuthVO auth) {
		// TODO Auto-generated method stub
		user.setUserpw(pwencoder.encode(user.getUserpw()));		
		userMapper.userJoin(user);
		userMapper.userAuth(auth);
	}

	@Override
	public List<UserVO> userList() {
		// TODO Auto-generated method stub
		return userMapper.userList();
	}

	@Override
	public UserVO userGet(String userid) {
		// TODO Auto-generated method stub
		return userMapper.userGet(userid);				
	}

	@Override	
	@Transactional
	public void userUpdate(UserVO user) {
		// TODO Auto-generated method stub
		user.setUserpw(pwencoder.encode(user.getUserpw()));
		userMapper.userUpdate(user);
		replyMapper.updateName(user.getUsername());
		boardMapper.updateName(user.getUsername());
	}

	@Transactional
	@Override	
	public void userDelete(String userid) {
		// TODO Auto-generated method stub
		//카트, 주문내역 삭제
		productMapper.cartDeleteById(userid);		
		productMapper.orderDeleteById(userid);
		
		//자신이 쓴 댓글 삭제
		replyMapper.deleteUser(userid);
		List<Long> list = boardMapper.listById(userid);
		//자신이 쓴 글의 댓글 삭제
		for(int i=0; i<list.size(); i++) {
			replyMapper.deleteByBno(list.get(i));
		}
		//자신이 쓴 글 삭제
		boardMapper.deleteUser(userid);
		//권한, 계정정보 삭제		
		userMapper.authDelete(userid);
		userMapper.userDelete(userid);
	}

	@Override
	public String userIdCheck(String userid) {
		// TODO Auto-generated method stub
		return userMapper.userIdCheck(userid);
	}

	@Override
	public void authDelete(String userid) {
		// TODO Auto-generated method stub
		userMapper.authDelete(userid);
	}

}
