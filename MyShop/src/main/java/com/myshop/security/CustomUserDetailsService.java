package com.myshop.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.myshop.domain.UserVO;
import com.myshop.mapper.UserMapper;

public class CustomUserDetailsService implements UserDetailsService {
	@Autowired
	private UserMapper userMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		System.out.println("username:" + username);
		UserVO user = userMapper.userGet(username);
		System.out.println(user.getUserid());
		System.out.println(user.getUserpw());

		return user == null ? null : new CustomUser(user);
	}

}