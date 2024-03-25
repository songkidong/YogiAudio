package com.project3.yogiaudio.handler;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.project3.yogiaudio.handler.exception.UserRestfulException;

@ControllerAdvice
public class UserRestfulExceptionHandler {

	// 모든 예외 클래스 설정
	@ExceptionHandler(Exception.class)
	public void exception(Exception e) {
		System.out.println("--------------");
		System.out.println(e.getClass().getName());
		System.out.println(e.getMessage());
		System.out.println("--------------");
	}

	@ExceptionHandler(UserRestfulException.class)
	public String basicException(UserRestfulException e) {
		String message = e.getMessage();
		return message;
	}

}
