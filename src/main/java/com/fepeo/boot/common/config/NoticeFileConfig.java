package com.fepeo.boot.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

// 메소드를 boot가 자동사용함
@Configuration
public class NoticeFileConfig implements WebMvcConfigurer{

	// images/ 이하의 모든 경로 처리
	private final String WEB_PATH = "/images/notice/**";
	// 실제 경로 입력 
	private final String REAL_PATH = "file:///home/ubuntu/util/uploadImage/";
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler(WEB_PATH).addResourceLocations(REAL_PATH);
	}
}
