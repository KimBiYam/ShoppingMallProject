package com.myshop.service;

import java.util.List;

import com.myshop.domain.AuthVO;
import com.myshop.domain.UserVO;

public interface UserService {
//	ȸ������
//	ȸ������Ʈ
//	ȸ������
//	ȸ������
//	ȸ��Ż��
//	���̵� �ߺ� üũ
	public void userJoin(UserVO user, AuthVO auth);
	public List<UserVO> userList();
	public UserVO userGet(String userid);
	public void userUpdate(UserVO user);
	public void userDelete(String userid);
	public String userIdCheck(String userid);
}