package com.fepeo.boot.common.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class ReviewFileConfig implements WebMvcConfigurer{
	
	private final String WEB_PATH ="/images/review/**";
	
	private final String REAL_PATH = "file:///home/ubuntu/util/uploadImage/";
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler(WEB_PATH).addResourceLocations(REAL_PATH);
	}
}
