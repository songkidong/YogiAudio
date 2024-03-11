package com.project3.yogiaudio.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.server.ResponseStatusException;

import com.project3.yogiaudio.dto.SignUpFormDTO;
import com.project3.yogiaudio.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@GetMapping("/signIn")
	public String sign() {
		return "user/signIn";
	}

	@PostMapping("/signIn")
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
		return "redirect:/user/signIn";
	}
}
