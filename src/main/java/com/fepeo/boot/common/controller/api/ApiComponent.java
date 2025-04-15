package com.fepeo.boot.common.controller.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fepeo.boot.course.model.vo.dto.KakaoPlaceResponseDto;
import com.fepeo.boot.course.model.vo.dto.PlaceDto;

import lombok.Getter;

@Getter
@Component
@PropertySource("classpath:app-info.properties")
public class ApiComponent {

	//필드에 선언시 각 API를 따로 부를수가 없어서 방법 변경함
	//private final WebClient webClient = WebClient.create("http://apis.data.go.kr/1360000/MidFcstInfoService/getMidFcst");


	@Value("${weatherApiKey}")
    private String weatherApiKey;
	
	@Value("${festivalApiKey}")
	private String festivalApiKey;
	
	@Value("${kakaoApiKey}")
	private String kakaoApiKey;
	
	@Value("${kakao_client_id}")
	private String kakao_client_id;
	
	@Value("${naver_client_id}")
	private String naver_client_id;
	
	@Value("${naver_client_secret}")
	private String naver_client_secret;
	
	@Value("${google_client_id}")
	private String google_client_id;
	
	@Value("${google_client_secret}")
	private String google_client_secret;
	
	public Map<String,String> googleLogin(String code) throws JsonMappingException, JsonProcessingException {
		WebClient client = WebClient.create("https://oauth2.googleapis.com");

	    String token = client.post()
	            .uri("/token")
	            .contentType(MediaType.APPLICATION_FORM_URLENCODED)
	            .body(BodyInserters.fromFormData("code", code)
	                    .with("client_id", "242617315070-ldaq9mj659bp7t82r97ae0gcp2uinugc.apps.googleusercontent.com")
	                    .with("client_secret", "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")
	                    .with("redirect_uri", "http://localhost:8888/member/google")
	                    .with("grant_type", "authorization_code"))
	            .retrieve()
	            .bodyToMono(String.class)
	            .block();
	    
	    ObjectMapper mapper = new ObjectMapper();
		JsonNode root = mapper.readTree(token);
		String accessToken = root.path("access_token").asText();
	    
		WebClient userClient = WebClient.create();
		String userInfo = userClient.get()
		        .uri("https://www.googleapis.com/oauth2/v2/userinfo")
		        .header(HttpHeaders.AUTHORIZATION, "Bearer " + accessToken)
		        .retrieve()
		        .bodyToMono(String.class)
		        .block();
		
		Map<String, String> loginMap = new HashMap<>();
		loginMap.put("userInfo", userInfo);
		loginMap.put("accessToken", accessToken);
		
		return loginMap;
	}
	
	public Map<String,String> naverLogin(String code, String state) throws JsonMappingException, JsonProcessingException {
		WebClient client = WebClient.create("https://nid.naver.com");

	    String token = client.post()
	            .uri(uriBuilder -> uriBuilder.path("/oauth2.0/token")
	                    .queryParam("grant_type", "authorization_code")
	                    .queryParam("client_id", "vtFv0628kUp2Kt2meM2v")
	                    .queryParam("client_secret", "9OON4RGUOZ")
	                    .queryParam("code", code)
	                    .queryParam("state", state)
	                    .build())
	            .retrieve()
	            .bodyToMono(String.class)
	            .block();
	    
	    ObjectMapper mapper = new ObjectMapper();
		JsonNode root = mapper.readTree(token);
		String accessToken = root.path("access_token").asText();
	    
	    WebClient userClient = WebClient.create("https://openapi.naver.com");

	    String userInfo = userClient.get()
	            .uri("/v1/nid/me")
	            .header(HttpHeaders.AUTHORIZATION, "Bearer " + accessToken)
	            .retrieve()
	            .bodyToMono(String.class)
	            .block();
	    
	    Map<String, String> loginMap = new HashMap<>();
		loginMap.put("userInfo", userInfo);
		loginMap.put("accessToken", accessToken);
		
		return loginMap;
	}
	
	
	public Map<String,String> kakaoLogin(String code) throws JsonMappingException, JsonProcessingException {
		WebClient webClient = WebClient.create("https://kauth.kakao.com");
		String token = webClient.post().uri("/oauth/token")
				.contentType(MediaType.APPLICATION_FORM_URLENCODED)
				.body(BodyInserters.fromFormData("grant_type", "authorization_code")
						.with("client_id", "05ae1e70e0b04614496a16fb554e7110")
						.with("redirect_uri", "http://localhost:8888/member/kakao")
						.with("code", code)).retrieve()
				.bodyToMono(String.class).block();
		
		ObjectMapper mapper = new ObjectMapper();
		JsonNode root = mapper.readTree(token);
		String accessToken = root.path("access_token").asText();
		WebClient webClient2 = WebClient.create("https://kapi.kakao.com");
		String userInfo = webClient2.get()
	            .uri("/v2/user/me")
	            .header(HttpHeaders.AUTHORIZATION, "Bearer " + accessToken)
	            .retrieve()
	            .bodyToMono(String.class)
	            .block(); 
		
		Map<String, String> loginMap = new HashMap<>();
		loginMap.put("userInfo", userInfo);
		loginMap.put("accessToken", accessToken);
		
		return loginMap;
	}
	
	public String kakaoMapApi() {
		String authorization = kakaoApiKey;
		WebClient webClient = WebClient.create("https://dapi.kakao.com");
		
	    KakaoPlaceResponseDto res = webClient.get()
	            .uri(uriBuilder -> uriBuilder
	                    .path("/v2/local/search/category.json")
	                    .queryParam("category_group_code", "FD6")
	                    .queryParam("x", 126.968357810931)
	                    .queryParam("y", 37.6063916960376)
	                    .queryParam("radius", 1000)
	                    .queryParam("sort", "distance")
	                    .build())
	            .header("Authorization", authorization)
	            .retrieve()
	            .bodyToMono(KakaoPlaceResponseDto.class)
	            .block();
	
	    List<PlaceDto> tt = res.getDocuments();
	    System.out.println(tt);
	    Random random = new Random();
	    int size = tt.size();
	    PlaceDto pd = tt.get(random.nextInt(size));
	    System.out.println(pd.getPlace_name() + pd.getRoad_address_name());	
	    
	    return "Hello world";	
	}
	
	// 축제 호출
	public String callFestivalApi() {
//		String festivalApiKey = ApiKeyLoader.get("festivalApiKey");
		WebClient webClient = WebClient.create("https://apis.data.go.kr/B551011/KorService1/searchFestival1");
		
		String response = webClient.get()
				.uri(uriBuilder -> uriBuilder
                        .queryParam("serviceKey", festivalApiKey)
                        .queryParam("numOfRows", 10)
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
