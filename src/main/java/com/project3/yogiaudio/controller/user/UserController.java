package com.project3.yogiaudio.controller.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.dto.admin.AdminPageVO;
import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.common.PageVO;
import com.project3.yogiaudio.dto.playlist.PlayListStartDTO;
import com.project3.yogiaudio.dto.user.GoogleProfile;
import com.project3.yogiaudio.dto.user.HistoryListDTO;
import com.project3.yogiaudio.dto.user.KakaoProfile;
import com.project3.yogiaudio.dto.user.LikeMusicListDTO;
import com.project3.yogiaudio.dto.user.NaverProfile;
import com.project3.yogiaudio.dto.user.OAuthToken;
import com.project3.yogiaudio.dto.user.UpdateUserDTO;
import com.project3.yogiaudio.dto.user.UserDTO;
import com.project3.yogiaudio.filedb.service.FiledbService;
import com.project3.yogiaudio.handler.exception.UserRestfulException;
import com.project3.yogiaudio.repository.entity.History;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.playlist.Playlist;
import com.project3.yogiaudio.repository.entity.product.LikeMusic;
import com.project3.yogiaudio.service.MailService;
import com.project3.yogiaudio.service.UserService;
import com.project3.yogiaudio.service.playlist.PlaylistService;
import com.project3.yogiaudio.util.Define;

import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

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

	@Autowired
	private MailService mailService;

	@Autowired
	private PasswordEncoder passwordEncoder;

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
	public ResponseEntity<String> signIn(UserDTO dto) {

		try {
			User userEntity = userService.signIn(dto);
			httpsession.setAttribute(Define.PRINCIPAL, userEntity);

			return ResponseEntity.ok().build();
		} catch (UserRestfulException e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
		}
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
	 * @Method Name : paymentPage
	 * @작성일 : 2024. 3. 22.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 결제내역 페이지
	 */
	@GetMapping("/payment")
	public String paymentPage(AdminCriteria cri, Model model) {

		User user = (User) httpsession.getAttribute(Define.PRINCIPAL);
		List<HistoryListDTO> paymentList = userService.findAllHistory(cri, user.getId());
		model.addAttribute("paymentList", paymentList);

		AdminPageVO pageVO = new AdminPageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(userService.countAllHistory(user.getId()));
		model.addAttribute("pageVO", pageVO);

		return "/user/payment";
	}

	/**
	 * @Method Name : handleRefundRequest
	 * @작성일 : 2024. 3. 25.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 환불 요청
	 */
	@PostMapping("/refund")
	@ResponseBody
	public ResponseEntity<String> handleRefundRequest(@RequestBody Map<String, Integer> requestData) {
		int hno = requestData.get("hno");
		int id = requestData.get("id");

		try {
			// 환불 요청을 처리하는 비즈니스 로직을 작성합니다.
			userService.refund(hno, id);

			// 성공적으로 처리되었을 때의 응답을 반환합니다.
			return ResponseEntity.ok("success");
		} catch (Exception e) {
			// 처리 중 예외가 발생하였을 때의 응답을 반환합니다.
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("환불 요청 처리 중 오류가 발생하였습니다.");
		}
	}

	/**
	 * @Method Name : myPlaylistPage
	 * @작성일 : 2024. 3. 24.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 플레이리스트 페이지
	 */
	@GetMapping("/myPlaylist")
	public String myPlaylistPage(Model model) {
		User user = (User) httpsession.getAttribute(Define.PRINCIPAL);

		// playlist 조회
		List<PlayListStartDTO> playlist = playlistService.readPlaylistByUserId(user.getId(), Define.PLAYLIST);

		model.addAttribute("playlist", playlist);
		return "user/myPlaylist";
	}

	/**
	 * @Method Name : likemusicPage
	 * @작성일 : 2024. 3. 22.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 좋아요 페이지
	 */
	@GetMapping("/likemusic")
	public String likemusicPage(AdminCriteria cri, Model model) {

		User user = (User) httpsession.getAttribute(Define.PRINCIPAL);
		List<LikeMusicListDTO> likemusicList = userService.findAllLikeMusic(cri, user.getId());
		model.addAttribute("likemusicList", likemusicList);

		AdminPageVO pageVO = new AdminPageVO();
		pageVO.setCri(cri);
		pageVO.setTotalCount(userService.countAllLikeMusic(user.getId()));
		model.addAttribute("pageVO", pageVO);

		return "/user/likemusic";
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

		User existingUser = userService.findByEmail(naverProfile.getResponse().getEmail());

		if (existingUser != null) {
			// 사용자가 이미 존재하면 바로 로그인
			httpsession.setAttribute(Define.PRINCIPAL, existingUser);
		} else {
			UserDTO userDTO = UserDTO.builder().name(naverProfile.getResponse().getName())
					.nickname("네이버" + naverProfile.getResponse().getNickname())
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

		User existingUser = userService.findByEmail(kakaoProfile.getKakaoAccount().getEmail());
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
		User existingUser = userService.findByEmail(googleProfile.getEmail());
		if (existingUser != null) {
			// 사용자가 이미 존재하면 바로 로그인
			httpsession.setAttribute(Define.PRINCIPAL, existingUser);
		} else {
			// 사용자가 존재하지 않으면 새로 생성
			UserDTO dto = UserDTO.builder().name(googleProfile.getName()).nickname("구글" + googleProfile.getGiven_name())
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

		User userOld = userService.findById(id);

		if (userOld.getFilePath() == null || userOld.getFilePath().isEmpty()) {
			filePath = filedbService.saveFiles(dto.getProfileFile());

		} else {
			filePath = userOld.getFilePath();
		}

		// 비밀번호가 변경되지 않은 경우 이전 비밀번호 사용
		String encodedPassword;
		if (passwordEncoder.matches(dto.getPassword(), userOld.getPassword())) {
			encodedPassword = userOld.getPassword();
		} else {
			encodedPassword = passwordEncoder.encode(dto.getPassword());
		}

		// 유저정보 업데이트
		User user = new User();
		user.setId(id);
		user.setName(dto.getName());
		user.setNickname(dto.getNickname());
		user.setPassword(encodedPassword);
		user.setFilePath(filePath);

		userService.updateUser(user);
		
		User userNew = userService.findById(id);

		// 기존 이미지 삭제
		String originPath = userNew.getFilePath();
		String[] parts = originPath.split("/");
		String uuid = parts[parts.length - 1];
		filedbService.deleteByUuid(uuid);

		httpsession.setAttribute(Define.PRINCIPAL, userNew);

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

	/**
	 * @Method Name : forgotpasswordPage
	 * @작성일 : 2024. 3. 26.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 비밀번호 찾기 페이지
	 */
	@GetMapping("/forgotpassword")
	public String forgotpasswordPage() {
		return "user/forgotpassword";
	}

	/**
	 * @Method Name : forgotpassword
	 * @작성일 : 2024. 3. 26.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 임시비밀번호 이메일 전송, 비밀번호 수정
	 */
	@PostMapping("/forgotpassword")
	public String forgotpassword(@RequestParam("email") String email, @RequestParam("name") String name) {
		User userEntity = userService.findByEmail(email);
		if (userEntity != null && userEntity.getName().equals(name)) {
			String newPassword = mailService.passwordSend(email);
			User user = new User();
			user.setId(userEntity.getId());
			user.setName(name);
			user.setNickname(userEntity.getNickname());
			user.setPassword(passwordEncoder.encode(newPassword));

			userService.updateUser(user);
		} else {
			return "error";
		}
		return "redirect:/product/main";
	}

	/**
	 * @Method Name : forgotemailPage
	 * @작성일 : 2024. 3. 26.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 이메일 찾기 페이지
	 */
	@GetMapping("/forgotemail")
	public String forgotemailPage() {
		return "user/forgotemail";
	}

	/**
	 * @Method Name : forgotemail
	 * @작성일 : 2024. 3. 26.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 이름으로 이메일 조회
	 */
	@PostMapping("/forgotemail")
	public ResponseEntity<List<String>> forgotemail(@RequestParam("name") String name) {
		List<User> users = userService.findByName(name);
		List<String> emails = new ArrayList<>();
		for (User user : users) {
			emails.add(user.getEmail());
		}

		if (!emails.isEmpty()) {
			return ResponseEntity.ok(emails); // 이메일 목록이 있는 경우 200 OK 응답 반환
		} else {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null); // 이메일 목록이 없는 경우 404 Not Found 응답 반환
		}
	}
}
