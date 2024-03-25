package com.project3.yogiaudio.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import com.project3.yogiaudio.dto.admin.AdminCriteria;
import com.project3.yogiaudio.dto.common.Criteria;
import com.project3.yogiaudio.dto.user.HistoryListDTO;
import com.project3.yogiaudio.dto.user.LikeMusicListDTO;
import com.project3.yogiaudio.dto.user.UserDTO;
import com.project3.yogiaudio.repository.entity.History;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.product.LikeMusic;
import com.project3.yogiaudio.repository.interfaces.UserRepository;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class UserService {

	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;

	@Autowired
	public UserService(UserRepository userRepository, PasswordEncoder passwordEncoder) {
		this.userRepository = userRepository;
		this.passwordEncoder = passwordEncoder;
	}

	/**
	 * @Method Name : createUser
	 * @작성일 : 2024. 3. 19.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 회원가입 기능
	 */
	@Transactional
	public User createUser(UserDTO dto) {
		validateSignUpForm(dto);
		checkExistingUser(dto.getEmail());
		User newUser = buildUserEntity(dto);
		userRepository.insert(newUser);
		log.info("새로운 사용자 생성: {}", newUser);
		return newUser;
	}

	/**
	 * @Method Name : validateSignUpForm
	 * @작성일 : 2024. 3. 18.
	 * @작성자 : 송기동
	 * @변경이력 :
	 * @Method 설명 : 회원가입 유효성 검사
	 */
	private void validateSignUpForm(UserDTO dto) {
		if (isEmpty(dto.getName()) || isEmpty(dto.getNickname()) || isEmpty(dto.getEmail())
				|| isEmpty(dto.getPassword())) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "모든 필드를 입력하세요");
		}
	}

	private boolean isEmpty(String value) {
		return value == null || value.trim().isEmpty();
	}

	// 아이디로 유저조회
	public User findById(@Param(value = "id") long id) {
		return userRepository.findById(id);
	}

	private void checkExistingUser(String email) {
		if (userRepository.findByEmail(email) != null) {
			log.warn("이미 등록된 이메일입니다: {}", email);
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "이미 등록된 이메일입니다");
		}
	}

	private User buildUserEntity(UserDTO dto) {
		return User.builder().name(dto.getName()).nickname(dto.getNickname()).email(dto.getEmail())
				.password(passwordEncoder.encode(dto.getPassword())).build();
	}

	public User signIn(UserDTO dto) {
		User userEntity = userRepository.findByEmail(dto.getEmail());
		
		if (userEntity == null || userEntity.getDeleteYn().equals("Y")
				|| !passwordEncoder.matches(dto.getPassword(), userEntity.getPassword())) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "탈퇴한 유저이거나 비밀번호가 일치하지 않습니다");
		}
		
		return userEntity;
	}

	// 이메일을 기준으로 사용자를 찾는 메서드 추가
	public User findUserByEmail(String email) {
		return userRepository.findByEmail(email);
	}

	public User findUserById(Long id) {
		return userRepository.findById(id);
	}

	// 회원 수정
	public int updateUser(User user) {

		return userRepository.updateById(user);
	}

	// 회원 탈퇴
	public int deleteUser(User user) {
		return userRepository.deleteById(user);
	}

	// 결제 내역 조회
	public List<HistoryListDTO> findAllHistory(AdminCriteria cri, Long userId) {
		return userRepository.findAllHistory(cri, userId);
	}
	public int countAllHistory(Long userId) {
		return userRepository.countAllHistory(userId);
	}
	
	// 환불 요청
	public int refund(int hno, int id) {
		return userRepository.refund(hno, id);
	}
	
	// 좋아요 내역 조회
	public List<LikeMusicListDTO> findAllLikeMusic(AdminCriteria cri, Long userId) {
		return userRepository.findAllLikeMusic(cri, userId);
	}
	public int countAllLikeMusic(Long userId) {
		return userRepository.countAllLikeMusic(userId);
	}
}
