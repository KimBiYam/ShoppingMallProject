package com.myshop.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.myshop.domain.BoardVO;
import com.myshop.service.BoardService;

@RequestMapping("/board/*")
@Controller
public class BoardController {
	@Autowired
	BoardService service;

//	리스트
	@GetMapping("/list")
	public void list(int type, Model model) {
		List<BoardVO> list = service.boardList(type);
		model.addAttribute("type", type);
		model.addAttribute("list", list);
	}

//	글쓰기 페이지
	@GetMapping("/insert")
	public void insert(int type, Model model) {
		model.addAttribute("type", type);
	}

//	글쓰기
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/insert")
	public String insert(BoardVO board) {
		service.boardInsert(board);
		return "redirect:/board/list/?type=" + board.getType();
	}

//	공지사항 글쓰기 페이지
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/admin/insert")
	public String adminInsert(int type, Model model) {
		model.addAttribute("type", type);
		return "/board/insert";
	}

//	공지사항 글쓰기
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/admin/insert")
	public String adminInsert(BoardVO board) {
		service.boardInsert(board);
		return "redirect:/board/list/?type=" + board.getType();
	}

//	글 보기
	@GetMapping("/get")
	public void get(Long bnum, Model model) {
		BoardVO board = service.boardGet(bnum);
		model.addAttribute("board", board);
	}

}
