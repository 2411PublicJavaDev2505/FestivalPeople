package com.fepeo.boot.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

//메소드를 boot가 자동사용함
@Configuration
public class ChatFileConfig implements WebMvcConfigurer {

	private String WEB_PATH = "/images/chat/**"; // 브라우저를 통해 저장되는 url
	private String REAL_PATH = "file:///c:/uploadFile/chat/"; // 실제 서버 안에 저장되는 폴더 url
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler(WEB_PATH).addResourceLocations(REAL_PATH);
	}
	
}
