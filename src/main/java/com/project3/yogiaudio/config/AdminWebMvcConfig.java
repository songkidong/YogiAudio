package com.project3.yogiaudio.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.project3.yogiaudio.handler.AdminAuthInterceptor;

// @Configuration --> 스프링부트 설정 클래스이다.
@Configuration // IoC 대상 : 2개 이상에 IoC(Bean) 사용
public class AdminWebMvcConfig implements WebMvcConfigurer{
	
	@Autowired // DI
	private AdminAuthInterceptor adminAuthInterceptor;

	// 요청 올때마다 domain URI 검사할 예정
	// /account/xxx <- 으로 들어오는 도메인을 다 검사해!!! / 도메이란? 범주화
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		
		registry.addInterceptor(adminAuthInterceptor) // 수정
				.addPathPatterns("/admin/**"); // 수정
	}
	
	/* 실행 오류
	 * @Bean // IoC 대상 - 싱글톤 처리 public PasswordEncoder passwordEncoder() { return
	 * new BCryptPasswordEncoder(); }
	 */
	
	// 리소스 등록처리
	// 서버 컴퓨터에 위치한 리소스를 활용하는 방법(프로젝트 외부 폴더 접근)
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// 가짜 경로 <--
		registry.addResourceHandler("/images/upload/**") // 이런 경로로 지정되어 있다면
		.addResourceLocations("file:///C:\\work_spring\\upload/"); // 이 경로로 변경한다!
	}
}
