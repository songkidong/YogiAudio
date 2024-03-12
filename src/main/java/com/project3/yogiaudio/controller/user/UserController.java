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
	@ResponseBody
	public String naverProc(@RequestParam("code") String code, @RequestParam("state") String state) {

		String url = "https://nid.naver.com/oauth2.0/token?" + "grant_type=authorization_code"
				+ "&client_id=cLVvs14822OOyYydIWA1" + "&client_secret=dV0yEpBLcq" + "&code=" + code + "&state=" + state;

        // RestTemplate 객체 생성
        RestTemplate restTemplate = new RestTemplate();

        // HTTP 요청 헤더 설정
        HttpHeaders headers = new HttpHeaders();

        // HTTP 요청 생성
        HttpEntity<String> requestEntity = new HttpEntity<>(headers);

        // HTTP 요청 실행
        ResponseEntity<OAuthToken> responseEntity = restTemplate.exchange(url, HttpMethod.POST, requestEntity, OAuthToken.class);

        // RestTemplate 객체 생성
        RestTemplate restTemplate2 = new RestTemplate();
        
     // HTTP 요청 헤더 설정
        HttpHeaders headers2 = new HttpHeaders();
        headers2.add("Authorization", "Bearer " + responseEntity.getBody().getAccessToken());
        
        // HTTP 요청 생성
        HttpEntity<String> requestEntity2 = new HttpEntity<>(headers2);
        
		// 사용자 정보 요청
		ResponseEntity<NaverProfile> response2 = restTemplate2.exchange("https://openapi.naver.com/v1/nid/me",
				HttpMethod.POST, requestEntity2, NaverProfile.class);
		
		NaverProfile naverProfile = response2.getBody();
		
		SignUpFormDTO signUpFormDTO = SignUpFormDTO.builder()
				.name(naverProfile.getResponse().getName())
				.nickname(naverProfile.getResponse().getNickname())
				.email(naverProfile.getResponse().getEmail())
				.password("naverpassword")
				.build();
		
		userService.createUser(signUpFormDTO);

        httpsession.setAttribute(Define.PRINCIPAL, signUpFormDTO);
        
        return "redirect:/product/main";
        
	}

}
