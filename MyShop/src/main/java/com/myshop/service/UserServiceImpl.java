package com.myshop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myshop.domain.AuthVO;
import com.myshop.domain.UserVO;
import com.myshop.mapper.BoardMapper;
import com.myshop.mapper.UserMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService {
	@Setter(onMethod_ = @Autowired)
	private UserMapper userMapper;
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;
	@Autowired
	private PasswordEncoder pwencoder;
	
	@Override
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
	public void userUpdate(UserVO user) {
		// TODO Auto-generated method stub
		user.setUserpw(pwencoder.encode(user.getUserpw()));
		userMapper.userUpdate(user);
	}

	@Transactional
	@Override	
	public void userDelete(String userid) {
		// TODO Auto-generated method stub
		boardMapper.userDelete(userid);		
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
