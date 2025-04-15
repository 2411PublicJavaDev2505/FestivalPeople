package com.fepeo.boot.common.controller.api;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;

import com.fepeo.boot.common.controller.util.ApiKeyLoader;


@Component
@PropertySource("classpath:app-info.properties")
public class ApiComponent {

	//필드에 선언시 각 API를 따로 부를수가 없어서 방법 변경함
	//private final WebClient webClient = WebClient.create("http://apis.data.go.kr/1360000/MidFcstInfoService/getMidFcst");


	@Value("${weatherApiKey}")
    private String weatherApiKey;
	
	@Value("${festivalApiKey}")
	private String festivalApiKey;

	public String callFestivalApi() {
		
//		String festivalApiKey = ApiKeyLoader.get("festivalApiKey");
		WebClient webClient = WebClient.create("https://apis.data.go.kr/B551011/KorService1/searchFestival1");
		
		String response = webClient.get()
				.uri(uriBuilder -> uriBuilder
                        .queryParam("serviceKey", festivalApiKey)
                        .queryParam("numOfRows", 100)
                        .queryParam("pageNo", 2)
                        .queryParam("MobileOS", "ETC")
                        .queryParam("MobileApp", "AppTest")
                        .queryParam("_type", "Json")
                        .queryParam("listYN", "Y")
                        .queryParam("arrange", "A")
                        .queryParam("eventStartDate", "20240401")
                        .build())
                .header("Accept", "application/json")
                .retrieve()
                .bodyToMono(String.class)
                .block();
		
		return response;
		
	}
	
	
	// 기상청 중기 예보 출력 API
	public String callWeatherApi() {
		// 키 불러옴
		String weatherApiKey = ApiKeyLoader.get("weatherApiKey");

		
		// 이것도 각 메소드에서 API 따로 사용하려고 했던 방식
		//String apiAddress = ApiKeyLoader.get("weatherAddress");
		// 변경하여 webClient를 각 메소드에서 따로 불러야함
		WebClient webClient = WebClient.create("http://apis.data.go.kr/1360000/MidFcstInfoService/getMidFcst");
		// API 호출
        String response = webClient.get()
                .uri(uriBuilder -> uriBuilder
                    .queryParam("serviceKey", weatherApiKey)
                    .queryParam("pageNo", 2)
                    .queryParam("numOfRows", 10)
                    .queryParam("dataType", "JSON")
                    .queryParam("stnId", 109)
                    .queryParam("tmFc", "202504140600")
                    .build())
                .retrieve()
                .bodyToMono(String.class)
                .block();
            System.out.println(response);
            return response;
	
	}
	
	
}
