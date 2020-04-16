package com.myshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myshop.domain.AuthVO;
import com.myshop.domain.UserVO;
import com.myshop.service.UserService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
@RequestMapping("/user/*")
public class UserController {
	UserService service;

	@PostMapping("/join")
	public String userJoin(UserVO user, AuthVO auth, String admincode) {
		if (admincode.equals("1234")) {
			auth.setUserauth("ROLE_ADMIN");
		} else {
			auth.setUserauth("ROLE_USER");
		}

		service.userJoin(user, auth);
		return "redirect:/";
	}

	@GetMapping("/idcheck")
	@ResponseBody
	public String idCheck(String userid) {
		String checkid = service.userIdCheck(userid);
		if (checkid == null) {
			return "yes";
		} else {
			return "no";
		}

	}
}
