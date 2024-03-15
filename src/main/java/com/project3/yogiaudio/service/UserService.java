package com.project3.yogiaudio.service;

import com.project3.yogiaudio.dto.user.SignUpFormDTO;
import com.project3.yogiaudio.repository.entity.User;
import com.project3.yogiaudio.repository.interfaces.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

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

    @Transactional
    public User createUser(SignUpFormDTO dto) {
        log.info("createUser 메서드 호출됨");
        validateSignUpForm(dto);
        checkExistingUser(dto.getEmail());
        User newUser = buildUserEntity(dto);
        userRepository.insert(newUser);
        log.info("새로운 사용자 생성: {}", newUser);
        return newUser;
    }

    private void validateSignUpForm(SignUpFormDTO dto) {
        if (isEmpty(dto.getName()) || isEmpty(dto.getNickname()) || isEmpty(dto.getEmail()) || isEmpty(dto.getPassword())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "모든 필드를 입력하세요");
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }

    private void checkExistingUser(String email) {
        if (userRepository.findByEmail(email) != null) {
            log.warn("이미 등록된 이메일입니다: {}", email);
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "이미 등록된 이메일입니다");
        }
    }

    private User buildUserEntity(SignUpFormDTO dto) {
        return User.builder()
                .name(dto.getName())
                .nickname(dto.getNickname())
                .email(dto.getEmail())
                .password(passwordEncoder.encode(dto.getPassword()))
                .build();
    }

    public User signIn(SignUpFormDTO dto) {
        User userEntity = userRepository.findByEmail(dto.getEmail());
        if (userEntity == null || !passwordEncoder.matches(dto.getPassword(), userEntity.getPassword())) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "유저가 존재하지 않거나 비밀번호가 일치하지 않습니다");
        }
        return userEntity;
    }

    // 이메일을 기준으로 사용자를 찾는 메서드 추가
    public User findUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }
}
