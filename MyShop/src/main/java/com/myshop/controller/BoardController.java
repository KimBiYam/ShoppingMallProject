package com.myshop.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.myshop.domain.BoardVO;
import com.myshop.domain.Criteria;
import com.myshop.domain.PageDTO;
import com.myshop.service.BoardService;

@RequestMapping("/board/*")
@Controller
public class BoardController {
	@Autowired
	BoardService service;

//	리스트
	@GetMapping("/list")
	public void list(@ModelAttribute("btype") int btype, Criteria cri, Model model) {

		List<BoardVO> list = service.boardList(cri);

		int total = service.getcount(cri);
		int rowNo = total - ((cri.getPageNum() - 1) * cri.getAmount());

		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("rowNo", rowNo);

		model.addAttribute("list", list);
	}

//	글쓰기 페이지
	@GetMapping("/insert")
	public void insert(@ModelAttribute("btype") int btype, Model model) {
	}

//	글쓰기
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/insert")
	public String insert(@ModelAttribute("btype") int btype, BoardVO board) {
		service.boardInsert(board);
		return "redirect:/board/list?btype=" + btype;
	}

//	공지사항 글쓰기 페이지
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/admin/insert")
	public String adminInsert(@ModelAttribute("btype") int btype, Model model) {
		return "/board/insert";
	}

//	공지사항 글쓰기
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/admin/insert")
	public String adminInsert(@ModelAttribute("btype") int btype, BoardVO board) {
		service.boardInsert(board);
		return "redirect:/board/list?btype=" + btype;
	}

//	글 보기
	@GetMapping("/get")
	public void get(Long bnum, Model model) {
		BoardVO board = service.boardGet(bnum);
		service.viewcnt(bnum);
		model.addAttribute("board", board);
	}

//	글 수정 페이지
	@GetMapping("/update")
	public void update(Long bnum, Model model) {
		BoardVO board = service.boardGet(bnum);
		model.addAttribute("board", board);
	}

//	글 수정
	@PreAuthorize("hasRole('ROLE_ADMIN') or principal.username == #board.userid")
	@PostMapping("/update")
	public String update(BoardVO board) {
		service.boardUpdate(board);
		return "redirect:/board/list?btype=" + board.getBtype();
	}

//	공지사항 글 수정
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/admin/update")
	public String adminUpdate(BoardVO board) {
		service.boardUpdate(board);
		return "redirect:/board/list?btype=" + board.getBtype();
	}

//	글 삭제
	@PreAuthorize("hasRole('ROLE_ADMIN') or principal.username == #userid")
	@GetMapping("/delete")
	public String delete(Long bnum, String userid, int btype) {
		service.boardDelete(bnum);
		return "redirect:/board/list?btype=" + btype;
	}

//	공지사항 글 삭제
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/admin/delete")
	public String adminDelete(Long bnum, int btype) {
		service.boardDelete(bnum);
		return "redirect:/board/list?btype=" + btype;
	}

}
