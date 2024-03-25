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
import com.project3.yogiaudio.handler.exception.UserRestfulException;
import com.project3.yogiaudio.repository.entity.History;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.entity.product.LikeMusic;
import com.project3.yogiaudio.repository.interfaces.UserRepository;
import com.project3.yogiaudio.util.Define;

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
			throw new UserRestfulException(Define.INVALID_FIELDS, HttpStatus.BAD_REQUEST);
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
			throw new UserRestfulException(Define.EMAIL_ALREADY_REGISTERED, HttpStatus.BAD_REQUEST);
		}
	}

	private User buildUserEntity(UserDTO dto) {
		return User.builder().name(dto.getName()).nickname(dto.getNickname()).email(dto.getEmail())
				.password(passwordEncoder.encode(dto.getPassword())).build();
	}

	public User signIn(UserDTO dto) {
		if (dto.getEmail() == null || dto.getEmail().isEmpty()) {
			throw new UserRestfulException(Define.EMAIL_REQUIRED, HttpStatus.BAD_REQUEST);
		}
		if (dto.getPassword() == null || dto.getPassword().isEmpty()) {
			throw new UserRestfulException(Define.PASSWORD_REQUIRED, HttpStatus.BAD_REQUEST);
		}

		User userEntity = userRepository.findByEmail(dto.getEmail());

		if (userEntity == null) {
			throw new UserRestfulException(Define.EMAIL_NOT_FOUND, HttpStatus.BAD_REQUEST);

		}

		if (userEntity.getDeleteYn().equals("Y")) {
			throw new UserRestfulException(Define.USER_DELETED, HttpStatus.BAD_REQUEST);
		}

		if (!passwordEncoder.matches(dto.getPassword(), userEntity.getPassword())) {
			throw new UserRestfulException(Define.PASSWORD_NOT_MATCH, HttpStatus.BAD_REQUEST);
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
