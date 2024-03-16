package com.project3.yogiaudio.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.server.ResponseStatusException;

import com.project3.yogiaudio.dto.user.NaverProfile;
import com.project3.yogiaudio.dto.user.OAuthToken;
import com.project3.yogiaudio.dto.user.SignUpFormDTO;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.service.UserService;
import com.project3.yogiaudio.util.Define;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private HttpSession httpsession;

	@GetMapping("/signUp")
	public String signUpPage() {
		return "user/signUp";
	}

	@GetMapping("/signIn")
	public String signInPage() {
		return "user/signIn";
	}
	
	@GetMapping("/consent")
	public String consentPage() {
		return "user/consent";
	}

	@PostMapping("/signUp")
	public String signUp(SignUpFormDTO dto) {
		if (!isValidSignUpForm(dto)) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "모든 필드를 입력하세요");
		}
		userService.createUser(dto);
		return "redirect:/signIn";
	}

	private boolean isValidSignUpForm(SignUpFormDTO dto) {
		return dto.getName() != null && dto.getNickname() != null && dto.getEmail() != null
				&& dto.getPassword() != null;
	}

	@PostMapping("/signIn")
	public String signIn(SignUpFormDTO dto) {
		User userEntity = userService.signIn(dto);
		httpsession.setAttribute(Define.PRINCIPAL, userEntity);
		
		
		return "redirect:/product/main";
	}

	@GetMapping("/logout")
	public String logout() {
		httpsession.invalidate();
		return "redirect:/product/main";
	}
	
	@GetMapping("/mypage/{id}")
	public String mypage(@PathVariable("id") Long id, Model model) {
		
		User userEntity = userService.findUserById(id);
		model.addAttribute("user", userEntity);
		return "redirect:/mypage";
	}

	@Autowired
	private RestTemplate restTemplate;

	/**
	 * @Method Name : naverProc
	 * @작성일 : 2024. 3. 14.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 네이버 로그인
	 */
	@GetMapping("/naver/login")
	public String naverProc(@RequestParam("code") String code, @RequestParam("state") String state) {
		OAuthToken authToken = getNaverAccessToken(code, state);
		NaverProfile naverProfile = getNaverUserProfile(authToken.getAccessToken());
		SignUpFormDTO signUpFormDTO = mapNaverProfileToSignUpFormDTO(naverProfile);
		userService.createUser(signUpFormDTO);
		httpsession.setAttribute(Define.PRINCIPAL, signUpFormDTO);
		return "redirect:/product/main";
	}

	private OAuthToken getNaverAccessToken(String code, String state) {
		String url = "https://nid.naver.com/oauth2.0/token?" + "grant_type=authorization_code"
				+ "&client_id=cLVvs14822OOyYydIWA1" + "&client_secret=dV0yEpBLcq" + "&code=" + code + "&state=" + state;
		ResponseEntity<OAuthToken> responseEntity = restTemplate.postForEntity(url, null, OAuthToken.class);
		return responseEntity.getBody();
	}

	private NaverProfile getNaverUserProfile(String accessToken) {
		String url = "https://openapi.naver.com/v1/nid/me";
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer " + accessToken);
		HttpEntity<String> requestEntity = new HttpEntity<>(headers);
		ResponseEntity<NaverProfile> responseEntity = restTemplate.exchange(url, HttpMethod.GET, requestEntity,
				NaverProfile.class);
		return responseEntity.getBody();
	}

	private SignUpFormDTO mapNaverProfileToSignUpFormDTO(NaverProfile naverProfile) {
		return SignUpFormDTO.builder().name(naverProfile.getResponse().getName())
				.nickname("네이버유저" + naverProfile.getResponse().getNickname())
				.email(naverProfile.getResponse().getEmail()).password("naverpassword").build();
	}



	// 카카오 인증 토큰 가져오는 코드
	private OAuthToken getKakaoAccessToken(String code) {
		String url = "https://kauth.kakao.com/oauth/token";
		HttpHeaders headers = new HttpHeaders();
		headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "d4f846759e28d648d1c4296141742ccb");
		params.add("redirect_uri", "http://localhost/kakao/login");
		params.add("code", code);
		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(params, headers);
		ResponseEntity<OAuthToken> responseEntity = restTemplate.exchange(url, HttpMethod.POST, requestEntity,
				OAuthToken.class);
		return responseEntity.getBody();
	}




	
}