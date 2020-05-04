package com.myshop.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.CookieClearingLogoutHandler;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myshop.domain.AuthVO;
import com.myshop.domain.UserVO;
import com.myshop.service.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {
	@Autowired
	private UserService service;


//	회원가입
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

//	아이디 중복체크
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

//	회원정보 수정 페이지
	@PreAuthorize("hasRole('ROLE_USER')")
	@GetMapping("/update")
	public void update(Principal principal, Model model) {
		String userid = principal.getName();
		UserVO user = service.userGet(userid);
		model.addAttribute("user", user);
	}

//	회원 정보 수정
	@PreAuthorize("hasRole('ROLE_USER')")
	@PostMapping("/update")
	public String update(Principal principal, UserVO user) {
		user.setUserid(principal.getName());
		service.userUpdate(user);
		return "redirect:/";
	}

//	회원 탈퇴
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/delete")
	public String delete(Principal principal, HttpServletRequest req, HttpServletResponse res) throws Exception {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		service.userDelete(principal.getName());
		if (auth != null) {
			new SecurityContextLogoutHandler().logout(req, res, auth);
			new CookieClearingLogoutHandler().logout(req, res, auth);
		}
		return "redirect:/";
	}



}
