package com.myshop.controller;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
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

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

//	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
//		logger.info("Welcome home! The client locale is {}.", locale);

//		Date date = new Date();
//		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
//		
//		String formattedDate = dateFormat.format(date);
//		
//		model.addAttribute("serverTime", formattedDate );

		return "redirect:/product/home";
	}

//	네이버 로그인
	@RequestMapping(value = "/naver/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException {
		System.out.println("여기는 callback");
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		// 1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); // String형식의 json데이터
		System.out.println(apiResult);
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
		System.out.println(id);
		System.out.println(name);
		// 4.파싱 닉네임 세션으로 저장
		UserVO user = new UserVO();
		user.setUserid(id);
		user.setUserid(name);
		user.setUserpw("");
		
		List<AuthVO> authlist = new ArrayList<AuthVO>();		
		AuthVO auth = new AuthVO();
		auth.setUserid(id);
		auth.setUserauth("ROLE_USER");
		authlist.add(0, auth);
		
		user.setAuthlist(authlist);
		
		CustomUser customUser = new CustomUser(user);
		
		
		return "redirect:/";		
		
	}

	@GetMapping("/map")
	public void map() {

	}

}
