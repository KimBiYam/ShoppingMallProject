package com.myshop.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myshop.domain.CartVO;
import com.myshop.domain.OrderVO;
import com.myshop.domain.ProductVO;
import com.myshop.oauth.NaverLoginBO;
import com.myshop.service.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	@Autowired
	ProductService service;
	@Autowired
	ServletContext c;
	@Autowired
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	private String uploadPath;

//	��Ʈ�ѷ� �ʱ�ȭ �� ���� ������ ��θ� �޾ƿ� �̹��� ���� ��θ� ����
	@PostConstruct
	public void initController() {
		this.uploadPath = c.getRealPath("/resources/img");
		System.out.println("uploadPath:" + uploadPath);
	}

//	���� ������
	@GetMapping("/home")
	public void home(String category, Model model, HttpSession session) {
		List<String> categorys = service.categorylist();
		List<ProductVO> products = service.productList(category);
		model.addAttribute("categorys", categorys);
		model.addAttribute("products", products);

		/* ���̹����̵�� ���� URL�� �����ϱ� ���Ͽ� naverLoginBOŬ������ getAuthorizationUrl�޼ҵ� ȣ�� */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		// https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		System.out.println("���̹�:" + naverAuthUrl);
		// ���̹�
		model.addAttribute("url", naverAuthUrl);

	}

//	ī�װ� ����Ʈ
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/category/list")
	public void categorylist(Model model) {
		List<String> list = service.categorylist();
		model.addAttribute("list", list);
	}

//	ī�װ� ���
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/category/register")
	public String categoryRegister(String categoryname) {
		service.categoryRegister(categoryname);
		return "redirect:/product/category/list";
	}

//	ī�װ� ����
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/category/delete")
	public String categoryDelete(String categoryname) {
		service.categoryDelete(categoryname);
		return "redirect:/product/category/list";
	}

//	��ǰ ���  ������
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/register")
	public void register(Model model) {
		List<String> categorys = service.categorylist();
		model.addAttribute("categorys", categorys);
	}

//	��ǰ ���
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/register")
	public String productRegister(ProductVO product) throws Exception {
		// ���� ��ο� ���ϸ� ����
		UUID uuid = UUID.randomUUID();
		String savedName = uuid.toString() + "_" + product.getFile().getOriginalFilename();
		File target = new File(uploadPath, savedName);
		// ���� ������ �޾ƿͼ� ���ε�
		FileCopyUtils.copy(product.getFile().getBytes(), target);

		// ���� ��� ����
		product.setSrc("/myshop/resources/img/" + savedName);
		// ���ϸ� ����
		product.setImgname(savedName);

		service.productRegister(product);
		return "redirect:/";
	}

//	��ǰ ���� ������
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/update")
	public void productUpdate(int id, Model model) {
		List<String> categorys = service.categorylist();
		ProductVO product = service.productGet(id);
		model.addAttribute("product", product);
		model.addAttribute("categorys", categorys);
	}

//	��ǰ ����
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/update")
	public String productUpdate(ProductVO product, String imgModify) throws Exception {

		if (imgModify.equals("1")) {
			UUID uuid = UUID.randomUUID();
			String savedName = uuid.toString() + "_" + product.getFile().getOriginalFilename();
			File target = new File(uploadPath, savedName);

			FileCopyUtils.copy(product.getFile().getBytes(), target);

			product.setSrc("/myshop/resources/img/" + savedName);
//		System.out.println(product.getSrc());
//		System.out.println(product.getFile());
		}

		service.productUpdate(product);
		return "redirect:/";
	}

//	��ǰ ����
	@GetMapping("/get")
	public void get(int id, Model model) {
		List<String> categorys = service.categorylist();
		ProductVO product = service.productGet(id);
		model.addAttribute("categorys", categorys);
		model.addAttribute("product", product);
	}

//	��ǰ ����	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/delete")
	public String productDelete(int id) {

		ProductVO product = service.productGet(id);

		File file = new File(uploadPath + "/" + product.getImgname());

		// ��ο��� �̹��� ���� ����
		if (file.exists()) {
			if (file.delete()) {
				System.out.println("���ϻ��� ����");
			} else {
				System.out.println("���ϻ��� ����");
			}
		}

		service.productDelete(id);

		return "redirect:/";
	}

//	��ٱ��� �߰�
	@PreAuthorize("hasRole('ROLE_USER')")
	@PostMapping("/cart/add")
	public String cartAdd(CartVO cart) {
		service.cartAdd(cart);

		return "redirect:/";
	}

//	��ٱ��� üũ
	@PreAuthorize("hasRole('ROLE_USER')")
	@GetMapping("/cart/check")
	@ResponseBody
	public String cartCheck(String userid, int productid) {
//		System.out.println(userid);
//		System.out.println(productid);
		List<CartVO> cartlist = service.cartList(userid);

		String str = "YES";
		for (int i = 0; i < cartlist.size(); i++) {
			if (cartlist.get(i).getProductid() == productid) {
//				System.out.println("���� ��ǰ�� �̹� ��ϵ�");
				str = "NO";
			}
		}
		return str;
	}

//	��ٱ��� ��� üũ
	@PreAuthorize("hasRole('ROLE_USER')")
	@GetMapping("/cart/stock")
	@ResponseBody
	public String cartStock(String userid) {
		String str = "";

		List<CartVO> cartlist = service.cartList(userid);

		for (int i = 0; i < cartlist.size(); i++) {
			ProductVO product = service.productGet(cartlist.get(i).getProductid());

			if (cartlist.get(i).getAmount() > product.getStock()) {
				service.cartDelete(cartlist.get(i).getCartid());
				str = "YES";
			}
		}

		return str;
	}

//	��ٱ��� ����
	@PreAuthorize("principal.username == #userid")
	@GetMapping("/cart")
	public void cart(@ModelAttribute("userid") String userid, Model model) {

		List<CartVO> cartlist = service.cartList(userid);

		model.addAttribute("cartlist", cartlist);
	}

//	��ٱ��� ����
	@PreAuthorize("principal.username == #userid")
	@GetMapping("/cart/delete")
	public String cartDelete(@ModelAttribute("userid") String userid, int cartid) {
		service.cartDelete(cartid);

		return "redirect:/product/cart?userid=" + userid;
	}

//	��ٱ��� ����
	@PreAuthorize("principal.username == #userid")
	@GetMapping("/cart/deleteById")
	public String cartDeleteById(@ModelAttribute("userid") String userid) {
		service.cartDeleteById(userid);

		return "redirect:/product/cart?userid=" + userid;
	}

//	��ٱ��� ���� ����
	@PreAuthorize("principal.username == #userid")
	@PostMapping("/cart/amount")
	public String cartAmount(int cartid, int amount, @ModelAttribute("userid") String userid) {
		service.cartAmount(cartid, amount);
		return "redirect:/product/cart?userid=" + userid;
	}

//	�ֹ� ������
	@PreAuthorize("principal.username == #userid")
	@GetMapping("/order")
	public String order(@ModelAttribute("userid") String userid, Model model) {
		List<CartVO> cartlist = service.cartList(userid);

		model.addAttribute("cartlist", cartlist);

		return "/product/order/order";
	}

//	��ǰ �ֹ�
	@PreAuthorize("hasRole('ROLE_USER')")
	@PostMapping("/order")
	public String order(@ModelAttribute("order") OrderVO order) throws Exception {

		List<CartVO> cartlist = service.cartList(order.getUserid());
		UUID ordercode = UUID.randomUUID();
		order.setOrdercode(ordercode.toString());

		for (int i = 0; i < cartlist.size(); i++) {

			order.setProductname(cartlist.get(i).getProductname());
			order.setProductprice(cartlist.get(i).getProductprice());
			order.setProductid(cartlist.get(i).getProductid());
			order.setAmount(cartlist.get(i).getAmount());

			ProductVO product = service.productGet(order.getProductid());
			String fileName = product.getImgname();

			File file = new File(uploadPath + "/" + fileName);
			File newFile = new File(uploadPath + "/order/" + fileName);

			if (file.exists()) {
				FileCopyUtils.copy(file, newFile);
			}

			order.setSrc("/myshop/resources/img/order/" + fileName);

			service.order(order, cartlist.get(i));
		}

		service.cartDeleteById(order.getUserid());

		return "redirect:/";
	}

//	�ֹ� ����Ʈ
	@PreAuthorize("principal.username == #userid")
	@GetMapping("/order/list")
	public void orderListById(@ModelAttribute("userid") String userid, Model model) {

		List<OrderVO> orderlist = service.orderListById(userid);

		model.addAttribute("orderlist", orderlist);

	}

//	�ֹ� ��������
	@PreAuthorize("principal.username == #userid")
	@GetMapping("/order/get")
	public void orderGet(@ModelAttribute("userid") String userid, String ordercode, Model model) {
		List<OrderVO> orderlist = service.orderListByCode(ordercode);

		int total = 0;
		for (int i = 0; i < orderlist.size(); i++) {
			total = total + (orderlist.get(i).getAmount() * orderlist.get(i).getProductprice());
		}

		model.addAttribute("total", total);
		model.addAttribute("orderlist", orderlist);
	}

//	������ �ֹ� ����Ʈ
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/order/admin/list")
	public String orderList(Model model) {

		List<OrderVO> orderlist = service.orderList();

		model.addAttribute("orderlist", orderlist);

		return "/product/order/adminlist";
	}

//	������ �ֹ� ��������
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/order/admin/get")
	public String orderAdminGet(String ordercode, Model model) {
		List<OrderVO> orderlist = service.orderListByCode(ordercode);

		int total = 0;
		for (int i = 0; i < orderlist.size(); i++) {
			total = total + (orderlist.get(i).getAmount() * orderlist.get(i).getProductprice());
		}

		model.addAttribute("total", total);
		model.addAttribute("orderlist", orderlist);

		return "/product/order/adminget";
	}

//	�ֹ� ���
	@PreAuthorize("principal.username == #userid or hasRole('ROLE_ADMIN')")
	@GetMapping("/order/cancel")
	public String orderCancel(@ModelAttribute("userid") String userid, String ordercode) {

		service.orderCancel(ordercode);

		List<OrderVO> orderlist = service.orderListByCode(ordercode);
		for (int i = 0; i < orderlist.size(); i++) {
			service.orderCancelAmount(orderlist.get(i).getProductid(), orderlist.get(i).getAmount());
		}

		return "redirect:/";
	}

//	�ֹ� ����
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/order/approval")
	public String orderApproval(String ordercode) {

		service.orderApproval(ordercode);

		return "redirect:/";
	}

}
