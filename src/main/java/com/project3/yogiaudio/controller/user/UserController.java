package com.project3.yogiaudio.controller.user;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.project3.yogiaudio.dto.playlist.PlayListStartDTO;
import com.project3.yogiaudio.dto.user.GoogleProfile;
import com.project3.yogiaudio.dto.user.KakaoProfile;
import com.project3.yogiaudio.dto.user.NaverProfile;
import com.project3.yogiaudio.dto.user.OAuthToken;
import com.project3.yogiaudio.dto.user.UpdateUserDTO;
import com.project3.yogiaudio.dto.user.UserDTO;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.playlist.Playlist;
import com.project3.yogiaudio.service.UserService;
import com.project3.yogiaudio.service.playlist.PlaylistService;
import com.project3.yogiaudio.util.Define;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private PlaylistService playlistService;
	
	@Autowired
	private FiledbService filedbService;

	@Autowired
	private HttpSession httpsession;

	@Autowired
	private RestTemplate restTemplate;

	/**
	 * @Method Name : signUpPage
	 * @작성일 : 2024. 3. 18.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 회원가입 페이지
	 */
	@GetMapping("/signUp")
	public String signUpPage() {
		return "user/signUp";
	}

	/**
	 * @Method Name : signInPage
	 * @작성일 : 2024. 3. 18.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 로그인 페이지
	 */
	@GetMapping("/signIn")
	public String signInPage() {
		return "user/signIn";
	}

	/**
	 * @Method Name : consentPage
	 * @작성일 : 2024. 3. 18.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 약관동의 페이지
	 */
	@GetMapping("/consent")
	public String consentPage() {
		return "user/consent";
	}
	

	@GetMapping("/myPlaylist")
	public String myPlaylistPage(Model model) {
		User user = (User)httpsession.getAttribute(Define.PRINCIPAL);
		
		// playlist 조회
		List<PlayListStartDTO> playlist = playlistService.readPlaylistByUserId(user.getId(), Define.PLAYLIST);
		
		model.addAttribute("playlist",playlist);
		return "user/myPlaylist";
	}

	/**
	 * @Method Name : signUp
	 * @작성일 : 2024. 3. 18.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 회원가입 기능
	 */
	@PostMapping("/signUp")
	public String signUp(UserDTO dto) {
		userService.createUser(dto);
		return "redirect:/signIn";
	}

	/**
	 * @Method Name : signIn
	 * @작성일 : 2024. 3. 18.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 로그인 기능
	 */
	@PostMapping("/signIn")
	public String signIn(UserDTO dto) {
		User userEntity = userService.signIn(dto);
		httpsession.setAttribute(Define.PRINCIPAL, userEntity);

		return "redirect:/product/main";
	}

	/**
	 * @Method Name : logout
	 * @작성일 : 2024. 3. 18.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 로그아웃 기능
	 */
	@GetMapping("/logout")
	public String logout() {
		httpsession.invalidate();
		return "redirect:/product/main";
	}

	/**
	 * @Method Name : accountPage
	 * @작성일 : 2024. 3. 19.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 내정보 페이지
	 */
	@GetMapping("/account/{id}")
	public String accountPage(@PathVariable("id") Long id, Model model) {

		User userEntity = userService.findUserById(id);
		model.addAttribute("user", userEntity);
		return "/user/account";
	}
	
	/**
	 * @Method Name : accountPage
	 * @작성일 : 2024. 3. 19.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 내정보 페이지
	 */
	@GetMapping("/payment/{id}")
	public String paymentPage(@PathVariable("id") Long id, Model model) {

		User userEntity = userService.findUserById(id);
		model.addAttribute("user", userEntity);
		return "/user/payment";
	}

	/**
	 * @Method Name : naverProc
	 * @작성일 : 2024. 3. 14.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 네이버 로그인 기능
	 */
	@GetMapping("/naver/login")
	public String naverProc(@RequestParam("code") String code, @RequestParam("state") String state,
			HttpSession session) {
		String tokenReqUrl = "https://nid.naver.com/oauth2.0/token";
		String userReqUrl = "https://openapi.naver.com/v1/nid/me";
		HttpHeaders headers = new HttpHeaders();

		// 네이버 인증 토큰 가져오기
		String clientId = "cLVvs14822OOyYydIWA1";
		String clientSecret = "dV0yEpBLcq";
		String url = tokenReqUrl + "?grant_type=authorization_code" + "&client_id=" + clientId + "&client_secret="
				+ clientSecret + "&code=" + code + "&state=" + state;
		ResponseEntity<OAuthToken> tokenResponseEntity = restTemplate.postForEntity(url, null, OAuthToken.class);
		OAuthToken authToken = tokenResponseEntity.getBody();

		// 네이버 사용자 프로필 가져오기
		HttpHeaders userHeaders = new HttpHeaders();
		userHeaders.set("Authorization", "Bearer " + authToken.getAccessToken());
		HttpEntity<String> userRequestEntity = new HttpEntity<>(userHeaders);
		ResponseEntity<NaverProfile> userResponseEntity = restTemplate.exchange(userReqUrl, HttpMethod.GET,
				userRequestEntity, NaverProfile.class);
		NaverProfile naverProfile = userResponseEntity.getBody();

		User existingUser = userService.findUserByEmail(naverProfile.getResponse().getEmail());

		if (existingUser != null) {
			// 사용자가 이미 존재하면 바로 로그인
			httpsession.setAttribute(Define.PRINCIPAL, existingUser);
		} else {
			UserDTO userDTO = UserDTO.builder().name(naverProfile.getResponse().getName())
					.nickname("네이버유저" + naverProfile.getResponse().getNickname())
					.email(naverProfile.getResponse().getEmail()).password("naverpassword").build();

			User naverUser = userService.createUser(userDTO);
			httpsession.setAttribute(Define.PRINCIPAL, naverUser);
		}

		return "redirect:/product/main";

	}

	/**
	 * @Method Name : kakaoProc
	 * @작성일 : 2024. 3. 14.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 카카오 로그인 기능
	 */
	@GetMapping("/kakao/login")
	public String kakaoProc(@RequestParam("code") String code, HttpSession session) {
		String tokenReqUrl = "https://kauth.kakao.com/oauth/token";
		String userReqUrl = "https://kapi.kakao.com/v2/user/me";
		HttpHeaders headers = new HttpHeaders();
		headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// 카카오 인증 토큰 가져오기
		MultiValueMap<String, String> tokenParams = new LinkedMultiValueMap<>();
		tokenParams.add("grant_type", "authorization_code");
		tokenParams.add("client_id", "d4f846759e28d648d1c4296141742ccb");
		tokenParams.add("redirect_uri", "http://localhost/kakao/login");
		tokenParams.add("code", code);
		HttpEntity<MultiValueMap<String, String>> tokenRequestEntity = new HttpEntity<>(tokenParams, headers);
		ResponseEntity<OAuthToken> tokenResponseEntity = restTemplate.exchange(tokenReqUrl, HttpMethod.POST,
				tokenRequestEntity, OAuthToken.class);
		OAuthToken authToken = tokenResponseEntity.getBody();

		// 카카오 사용자 프로필 가져오기
		HttpHeaders userHeaders = new HttpHeaders();
		userHeaders.set("Authorization", "Bearer " + authToken.getAccessToken());
		userHeaders.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		HttpEntity<MultiValueMap<String, String>> userRequestEntity = new HttpEntity<>(userHeaders);
		ResponseEntity<KakaoProfile> userResponseEntity = restTemplate.exchange(userReqUrl, HttpMethod.POST,
				userRequestEntity, KakaoProfile.class);
		KakaoProfile kakaoProfile = userResponseEntity.getBody();

		User existingUser = userService.findUserByEmail(kakaoProfile.getKakaoAccount().getEmail());
		if (existingUser != null) {
			// 사용자가 이미 존재하면 바로 로그인
			httpsession.setAttribute(Define.PRINCIPAL, existingUser);
		} else {
			// 회원가입 폼 DTO로 매핑
			UserDTO userDTO = UserDTO.builder().name(kakaoProfile.getProperties().getNickname())
					.nickname("카카오" + kakaoProfile.getProperties().getNickname())
					.email(kakaoProfile.getKakaoAccount().getEmail()).password("kakaopassword").build();

			User kakaoUser = userService.createUser(userDTO);
			httpsession.setAttribute(Define.PRINCIPAL, kakaoUser);
		}

		return "redirect:/product/main";

	}

	/**
	 * @Method Name : googleProc
	 * @작성일 : 2024. 3. 15.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 구글 로그인 기능
	 */
	@GetMapping("/google/login")
	public String googleProc(@RequestParam("code") String code) {
		String tokenReqUrl = "https://oauth2.googleapis.com/token";
		String userReqUrl = "https://www.googleapis.com/oauth2/v3/userinfo";
		HttpHeaders headers = new HttpHeaders();
		headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

		// 클라이언트 ID와 시크릿은 구글 개발자 콘솔에서 발급받은 값을 사용합니다.
		String clientId = "411584291074-u6va1riq7hp0gubh4uoe9kk6gvcgp59k.apps.googleusercontent.com";
		String clientSecret = "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";

		// 구글 인증토큰 받아오기
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", clientId);
		params.add("client_secret", clientSecret);
		params.add("redirect_uri", "http://localhost/google/login");
		params.add("code", code);

		HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity<>(params, headers);
		ResponseEntity<OAuthToken> responseEntity = restTemplate.exchange(tokenReqUrl, HttpMethod.POST, requestEntity,
				OAuthToken.class);

		// 구글 사용자 정보 받아오기
		HttpHeaders headers2 = new HttpHeaders();
		headers2.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		headers2.add("Authorization", "Bearer " + responseEntity.getBody().getAccessToken());

		HttpEntity<MultiValueMap<String, String>> requestEntity2 = new HttpEntity<>(headers2);
		ResponseEntity<GoogleProfile> responseEntity2 = restTemplate.exchange(userReqUrl, HttpMethod.POST,
				requestEntity2, GoogleProfile.class);

		GoogleProfile googleProfile = responseEntity2.getBody();

		// 사용자가 이미 존재하는지 확인
		User existingUser = userService.findUserByEmail(googleProfile.getEmail());
		if (existingUser != null) {
			// 사용자가 이미 존재하면 바로 로그인
			httpsession.setAttribute(Define.PRINCIPAL, existingUser);
		} else {
			// 사용자가 존재하지 않으면 새로 생성
			UserDTO dto = UserDTO.builder().name(googleProfile.getName()).nickname(googleProfile.getGiven_name())
					.email(googleProfile.getEmail()).password("googlepassword").build();

			User googleUser = userService.createUser(dto);
			httpsession.setAttribute(Define.PRINCIPAL, googleUser);
		}

		return "redirect:/product/main";
	}

	/**
	  * @Method Name : updateUser
	  * @작성일 : 2024. 3. 20.
	  * @작성자 : 송기동
	  * @변경이력 : 
	  * @Method 설명 : 회원정보 수정
	  */
	@PostMapping("/updateUser/{id}")
	public String updateUser(@PathVariable("id") Long id, @ModelAttribute UpdateUserDTO dto) {
		
	    String filePath;
	    
        User userUpload = userService.findById(id);
        
        String originPath = userUpload.getFilePath();
        String[] parts = originPath.split("/");
        String uuid = parts[parts.length -1];
        filedbService.deleteByUuid(uuid);

	    if(dto.getProfileFile() == null || dto.getProfileFile().isEmpty()) {
	        // 기존 이미지의 경로를 가져와서 사용
	        filePath = userUpload.getFilePath();
	    } else {
	        // dto의 프로필 파일이 null이 아닌 경우 새로운 파일 업로드
	        filePath = filedbService.saveFiles(dto.getProfileFile());
	    }

		User user = new User();
		user.setId(id);
		user.setName(dto.getName());
		user.setNickname(dto.getNickname());
		user.setPassword(dto.getPassword());
		user.setFilePath(filePath);
		
		userService.updateUser(user);
		User userSession = userService.findById(id);
		httpsession.setAttribute(Define.PRINCIPAL, userSession);
		
	
		return "redirect:/product/main";
	}
	
	/**
	  * @Method Name : deleteUser
	  * @작성일 : 2024. 3. 20.
	  * @작성자 : 송기동
	  * @변경이력 : 
	  * @Method 설명 : 회원 탈퇴
	  */
	@PostMapping("/deleteUser/{id}")
	public String deleteUser(@PathVariable("id") Long id, @ModelAttribute User user) {
		
		userService.deleteUser(user);
		
		httpsession.invalidate();
		
		return "redirect:/product/main";
	}
	
}