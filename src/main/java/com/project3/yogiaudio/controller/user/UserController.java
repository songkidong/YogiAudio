package com.project3.yogiaudio.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.server.ResponseStatusException;

import com.project3.yogiaudio.dto.user.KakaoProfile;
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

	@Autowired
	private RestTemplate restTemplate;

	@GetMapping("/signUp")
	public String signUpPage() {
		return "user/signUp";
	}

	@GetMapping("/signIn")
	public String signInPage() {
		return "user/signIn";
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
		headers.add("Authorization", "Bearer " + accessToken);
		HttpEntity<String> requestEntity = new HttpEntity<>(headers);
		ResponseEntity<NaverProfile> responseEntity = restTemplate.exchange(url, HttpMethod.GET, requestEntity,
				NaverProfile.class);
		return responseEntity.getBody();
	}

	private SignUpFormDTO mapNaverProfileToSignUpFormDTO(NaverProfile naverProfile) {
		return SignUpFormDTO.builder().name(naverProfile.getResponse().getName())
				.nickname(naverProfile.getResponse().getNickname()).email(naverProfile.getResponse().getEmail())
				.password("naverpassword").build();
	}

	@GetMapping("/kakao/login")
	@ResponseBody
	public String kakaoProc(@RequestParam("code") String code) {
		RestTemplate rt = new RestTemplate();

		// HttpHeader 오브젝트 생성
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		// HttpBody 오브젝트 생성
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "d4f846759e28d648d1c4296141742ccb");
		params.add("redirect_uri", "http://localhost/kakao/login");
		params.add("code", code);
		// 헤더와 바디를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(params, headers);

		// Http 요청
		ResponseEntity<String> response = rt.exchange("https://kauth.kakao.com/oauth/token", HttpMethod.POST,
				kakaoTokenRequest, String.class);

		return "카카오 토큰 요청" + response.getBody();
	}
}
