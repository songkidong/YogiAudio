package com.project3.yogiaudio.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {
	@GetMapping("/test")
	public String test() {
		return "user/signIn";
	}
	@GetMapping("/test2")
	public String test2() {
		return "user/signIn2";
	}
}
