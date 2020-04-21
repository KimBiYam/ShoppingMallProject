package com.myshop.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.myshop.domain.ProductVO;
import com.myshop.service.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	@Autowired
	ProductService service;
	@Resource(name = "uploadPath")
	String uploadPath;

	@GetMapping("/home")
	public void home(Model model) {
		List<String> categorys = service.categorylist();
		List<ProductVO> products = service.ProductList();
		model.addAttribute("categorys", categorys);
		model.addAttribute("products", products);
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/category/register")
	public void categoryRegister() {
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/category/list")
	public void categorylist(Model model) {
		List<String> list = service.categorylist();
		model.addAttribute("list", list);
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/category/register")
	public String categoryRegister(String categoryname) {
		service.categoryRegister(categoryname);
		return "redirect:/product/category/list";
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/category/delete")
	public String categoryDelete(String categoryname) {
		service.categoryDelete(categoryname);
		return "redirect:/product/category/list";
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/register")
	public void register(Model model) {
		List<String> categorys = service.categorylist();
		model.addAttribute("categorys", categorys);
	}

	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/register")
	public String productRegister(ProductVO product, Model model) throws Exception {
		// 파일 경로와 파일명 설정
		UUID uuid = UUID.randomUUID();
		String savedName = uuid.toString() + product.getFile().getOriginalFilename();
		File target = new File(uploadPath, savedName);
		// 실제 파일을 받아와서 업로드
		FileCopyUtils.copy(product.getFile().getBytes(), target);

		// 파일 경로 설정
		product.setSrc("/myshop/resources/img/" + savedName);

		service.productRegister(product);
		return "redirect:/";

	}

}
