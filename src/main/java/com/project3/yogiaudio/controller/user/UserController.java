package com.project3.yogiaudio.controller.user;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.server.ResponseStatusException;

import com.project3.yogiaudio.dto.user.NaverProfile;
import com.project3.yogiaudio.dto.user.OAuthToken;
import com.project3.yogiaudio.dto.user.SignUpFormDTO;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.service.UserService;
import com.project3.yogiaudio.util.Define;

import jakarta.servlet.http.HttpSession;

/**
 * @FileName : UserController.java
 * @Project : yogiaudio
 * @Date : 2024. 3. 11.
 * @작성자 : 송기동
 * @변경이력 :
 * @프로그램 설명 : 유저 컨트롤러
 */
@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private HttpSession httpsession;

	/**
	 * @Method Name : signUpPage
	 * @작성일 : 2024. 3. 11.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 회원가입 화면
	 */
	@GetMapping("/signUp")
	public String signUpPage() {
		return "user/signUp";
	}

	/**
	 * @Method Name : signInPage
	 * @작성일 : 2024. 3. 11.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 로그인 화면
	 */
	@GetMapping("/signIn")
	public String signInPage() {
		return "user/signIn";
	}

	/**
	 * @Method Name : signUp
	 * @작성일 : 2024. 3. 11.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 회원가입 처리
	 */
	@PostMapping("/signUp")
	public String signUp(SignUpFormDTO dto) {
		if (dto.getName() == null) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "이름을 입력하세요");
		}
		if (dto.getNickname() == null) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "닉네임을 입력하세요");
		}
		if (dto.getEmail() == null) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "이메일을 입력하세요");
		}
		if (dto.getPassword() == null) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "비밀번호를 입력하세요");
		}

		userService.createUser(dto);
		return "redirect:/signIn";
	}

	/**
	 * @Method Name : signIn
	 * @작성일 : 2024. 3. 11.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 로그인 처리
	 */
	@PostMapping("/signIn")
	public String signIn(SignUpFormDTO dto) {
		User userEntity = userService.signIn(dto);

		if (userEntity == null) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "유저가 존재하지 않습니다");
		}

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
	    String url = "https://nid.naver.com/oauth2.0/token?" +
	            "grant_type=authorization_code" +
	            "&client_id=cLVvs14822OOyYydIWA1" +
	            "&client_secret=dV0yEpBLcq" +
	            "&code=" + code +
	            "&state=" + state;

	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<OAuthToken> responseEntity = restTemplate.postForEntity(url, null, OAuthToken.class);
	    return responseEntity.getBody();
	}

	private NaverProfile getNaverUserProfile(String accessToken) {
	    String url = "https://openapi.naver.com/v1/nid/me";
	    HttpHeaders headers = new HttpHeaders();
	    headers.add("Authorization", "Bearer " + accessToken);
	    HttpEntity<String> requestEntity = new HttpEntity<>(headers);
	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<NaverProfile> responseEntity = restTemplate.exchange(url, HttpMethod.GET, requestEntity, NaverProfile.class);
	    return responseEntity.getBody();
	}

	private SignUpFormDTO mapNaverProfileToSignUpFormDTO(NaverProfile naverProfile) {
	    return SignUpFormDTO.builder()
	            .name(naverProfile.getResponse().getName())
	            .nickname(naverProfile.getResponse().getNickname())
	            .email(naverProfile.getResponse().getEmail())
	            .password("naverpassword")
	            .build();
	}


}
