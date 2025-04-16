package com.fepeo.boot;



import java.util.List;
import java.util.Map;

import org.junit.jupiter.api.AutoClose;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fepeo.boot.common.controller.api.ApiComponent;
import com.fepeo.boot.festival.model.vo.dto.FestivalItem;


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
	public void testApiLoader() throws JsonMappingException, JsonProcessingException {

		//날씨 테스트
		//Map<String, String> apiKey = aService.callWeatherApi("202504160600");
		// 축제 테스트
//		String apiKey = aService.callFestivalApi();
		//String apiKey = aService.callseoulWeather();
		// 지도 테스트
//		String apiKey = aService.kakaoMapApi();
		// 좌표 테스트
//		Map<String, String> apiKey = aService.searchMemberAddress("서울시 평창 10길 3");
		//System.out.println(apiKey);
		

//		List<FestivalItem> apiKey = aService.callFestivalApi();
//		String apiKey = aService.kakaoMapApi();
//		System.out.println(apiKey);

		//System.out.println(apiKey);
		
	}
	

	
}
