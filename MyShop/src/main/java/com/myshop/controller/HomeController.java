package com.myshop.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.myshop.domain.AuthVO;
import com.myshop.domain.UserVO;
import com.myshop.oauth.NaverLoginBO;
import com.myshop.security.CustomUser;
import com.myshop.service.UserService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	@Autowired
	private UserService service;

//	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpSession session) {

		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		// https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		// redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		// System.out.println("네이버:" + naverAuthUrl);
		// 네이버 링크 세션에 저장
		session.setAttribute("url", naverAuthUrl);

		return "redirect:/product/home";
	}

//	네이버 로그인
	@RequestMapping(value = "/naver/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException {
		// System.out.println("여기는 callback");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터
		// System.out.println(apiResult);
		/**
		 * apiResult json 구조 {"resultcode":"00", "message":"success",
		 * "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
		 **/
		// 2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		// 3. 데이터 파싱
		// Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		// response의 nickname값 파싱
		String id = (String) response_obj.get("id");
		String name = (String) response_obj.get("name");
		String email = (String) response_obj.get("email");

		UserVO user = new UserVO();
		List<AuthVO> authlist = new ArrayList<AuthVO>();
		AuthVO auth = new AuthVO();
		UUID uuid = UUID.randomUUID();
		auth.setUserid("NAVER" + id);
		auth.setUserauth("ROLE_USER");
		authlist.add(auth);

		user.setUserid("NAVER" + id);
		user.setAuthlist(authlist);
		user.setUserpw(uuid.toString());
		user.setUsername(name);
		user.setEmail(email);
		user.setTel("");
		user.setAddr("");
		user.setZipcode("");

		// db에 해당 유저가 없을경우 join
		if (service.userGet(user.getUserid()) == null) {
			service.userJoin(user, auth);
		}

		CustomUser customUser = new CustomUser(user);

		// 시큐리티 권한을 직접 세팅함
		Authentication authentication = new UsernamePasswordAuthenticationToken(customUser, null,
				customUser.getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(authentication);

		return "redirect:/";

	}

	@GetMapping("/map")
	public void map() {

	}

}
