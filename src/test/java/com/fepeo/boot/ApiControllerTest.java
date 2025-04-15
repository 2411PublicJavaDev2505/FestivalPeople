package com.fepeo.boot;



import org.junit.jupiter.api.AutoClose;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.fepeo.boot.common.controller.api.ApiComponent;


@SpringBootTest
public class ApiControllerTest {

	
	private static final Logger LOGGER
	= LoggerFactory.getLogger(ApiControllerTest.class);

	
	@Autowired
	private ApiComponent aService;
	
	@BeforeAll
	public static void setUp() {
		LOGGER.info("테스트 시작");
	}
	
	@Test
	public void testApiLoader() {

//		String apiKey = aService.callWeatherApi();
		String apiKey = aService.callFestivalApi();
		System.out.println(apiKey);
		
		//System.out.println(apiKey);
		
	}
	

	
}
