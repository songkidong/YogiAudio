package com.project3.yogiaudio.handler.exception;

import org.springframework.http.HttpStatus;

public class UserRestfulException extends RuntimeException {

	public HttpStatus httpStatus;

	public UserRestfulException(String message, HttpStatus httpStatus) {
		super(message);
		this.httpStatus = httpStatus;
	}
}
