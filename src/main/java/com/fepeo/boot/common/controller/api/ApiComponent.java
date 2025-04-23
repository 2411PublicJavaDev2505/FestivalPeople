package com.fepeo.boot.common.controller.api;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.ExchangeStrategies;
import org.springframework.web.reactive.function.client.WebClient;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fepeo.boot.common.util.WeatherUtils;
import com.fepeo.boot.course.model.vo.dto.KakaoPlaceResponseDto;
import com.fepeo.boot.course.model.vo.dto.PlaceDto;
import com.fepeo.boot.course.model.vo.dto.RegionDto;
import com.fepeo.boot.festival.model.vo.dto.WeatherApiResponse;
import com.fepeo.boot.festival.model.vo.dto.WeatherItem;
import com.fepeo.boot.report.controller.ReportController;

import io.github.bonigarcia.wdm.WebDriverManager;
import lombok.Getter;

@Getter
@Component
@PropertySource("classpath:app-info.properties")
public class ApiComponent {

    private final ReportController reportController;
    String nowTime = "";

	private final RestTemplate restTemplate;
	private final ObjectMapper objectMapper;
	//필드에 선언시 각 API를 따로 부를수가 없어서 방법 변경함
	//private final WebClient webClient = WebClient.create("http://apis.data.go.kr/1360000/MidFcstInfoService/getMidFcst");
	public ApiComponent(RestTemplateBuilder builder, ObjectMapper objectMapper, ReportController reportController) {
        this.restTemplate = builder.build();
        this.objectMapper = objectMapper;
        this.reportController = reportController;		
	}

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
	
	
	
	
	public  List<PlaceDto> kakaoCategorySearch(Map<String, String> festivalXY, String category) {
		String authorization = kakaoApiKey;
		WebClient webClient = WebClient.create("https://dapi.kakao.com");
			
	    KakaoPlaceResponseDto res = webClient.get()
	            .uri(uriBuilder -> uriBuilder
	                    .path("/v2/local/search/category.json")
	                    .queryParam("category_group_code", category)
	                    .queryParam("x", festivalXY.get("x"))
	                    .queryParam("y", festivalXY.get("y"))
	                    .queryParam("radius", 10000)
	                    .queryParam("sort", "distance")
	                    .build())
	            .header("Authorization", authorization)
	            .retrieve()
	            .bodyToMono(KakaoPlaceResponseDto.class)
	            .block();
	    
	    
	    List<PlaceDto> tt = res.getDocuments();
	    Random random = new Random();
	    int size = tt.size();
	    PlaceDto pd = tt.get(random.nextInt(size)); 
	    return tt;
		
	}
	
	// 축제 주소지 기준 추천 숙소 정보 15개 출력
	public List<PlaceDto> kakaoHotelApi(Map<String, String> festivalXY) {
		String authorization = kakaoApiKey;
		WebClient webClient = WebClient.create("https://dapi.kakao.com");
		
	    KakaoPlaceResponseDto res = webClient.get()
	            .uri(uriBuilder -> uriBuilder
	                    .path("/v2/local/search/category.json")
	                    .queryParam("category_group_code", "AD5")
	                    .queryParam("x", festivalXY.get("x"))
	                    .queryParam("y", festivalXY.get("y"))
	                    .queryParam("radius", 10000)
	                    .queryParam("sort", "distance")
	                    .build())
	            .header("Authorization", authorization)
	            .retrieve()
	            .bodyToMono(KakaoPlaceResponseDto.class)
	            .block();
	
	    List<PlaceDto> tt = res.getDocuments();
//	    System.out.println(tt);
	    // 랜덤으로 필터링하는건 다음에 사용
//	    Random random = new Random();
//	    int size = tt.size();
	    PlaceDto pd = tt.get(0);
	    //System.out.println(pd.getPlace_name() + pd.getRoad_address_name());	
	    return tt;	
	}
	
	// 축제 주소지 기준 추천 맛집 정보 15개 출력
	public  List<PlaceDto> kakaoMatzipApi(Map<String, String> festivalXY) {
		String authorization = kakaoApiKey;
		WebClient webClient = WebClient.create("https://dapi.kakao.com");
		
	    KakaoPlaceResponseDto res = webClient.get()
	            .uri(uriBuilder -> uriBuilder
	                    .path("/v2/local/search/category.json")
	                    .queryParam("category_group_code", "FD6")
	                    .queryParam("x", festivalXY.get("x"))
	                    .queryParam("y", festivalXY.get("y"))
	                    .queryParam("radius", 10000)
	                    .queryParam("sort", "distance")
	                    .build())
	            .header("Authorization", authorization)
	            .retrieve()
	            .bodyToMono(KakaoPlaceResponseDto.class)
	            .block();
	
	    List<PlaceDto> tt = res.getDocuments();
//	    System.out.println(tt);
	    Random random = new Random();
	    int size = tt.size();
	    PlaceDto pd = tt.get(0);
	    //System.out.println(pd.getPlace_name() + pd.getRoad_address_name());	
	    return tt;	
	}
	
	// 축제 주소지 기준 추천 정보 15개 출력
	public PlaceDto kakaoCourseApi(Map<String, String> festivalXY, String code) {
		String authorization = kakaoApiKey;
		WebClient webClient = WebClient.create("https://dapi.kakao.com");
		
		KakaoPlaceResponseDto res = webClient.get()
				.uri(uriBuilder -> uriBuilder
						.path("/v2/local/search/category.json")
						.queryParam("category_group_code", code)
						.queryParam("x", festivalXY.get("X"))
						.queryParam("y", festivalXY.get("Y"))
						.queryParam("radius", 10000)
						.queryParam("sort", "distance")
						.build())
				.header("Authorization", authorization)
				.retrieve()
				.bodyToMono(KakaoPlaceResponseDto.class)
				.block();
		
		List<PlaceDto> tt = res.getDocuments();
//	    System.out.println(tt);
		Random random = new Random();
		int size = tt.size();
		PlaceDto pd = tt.get(0);
		//System.out.println(pd.getPlace_name() + pd.getRoad_address_name());	
		return pd;	
	}

	// 저장된 회원 주소지로 좌표값 받아오기
	public Map<String, String> searchMemberAddress(String memberAddress) throws JsonMappingException, JsonProcessingException {
		String authorization = kakaoApiKey;
		WebClient webClient = WebClient.create("https://dapi.kakao.com");
				
		//Map<String, String> result = new HashMap<String, String>();	
		String result = webClient.get()
	            .uri(uriBuilder -> uriBuilder
	                    .path("/v2/local/search/address.json")
	                    .queryParam("query", memberAddress)
	                    .build())
	            .header("Authorization", authorization)
	            .retrieve()
	            .bodyToMono(String.class)
	            .block();  
		
		//String -> Json 파싱		
		ObjectMapper mapper = new ObjectMapper();
		JsonNode root = mapper.readTree(result);
		JsonNode documents = root.path("documents");
		
		Map<String, String> mapPoint = new HashMap<>();
		JsonNode firstDoc = documents.get(0);
		String x = firstDoc.path("x").asText(); //x 좌표값
		String y = firstDoc.path("y").asText(); //y 좌표값

		mapPoint.put("x", x);
		mapPoint.put("y", y);
		
		return mapPoint;	
	}

	
	// 기상청 중기 예보 향후 7일간 날씨가 좋은 지역 출력
	public List<String> callWeatherApi(List<RegionDto> regionList) throws JsonMappingException, JsonProcessingException {	
		// 변경하여 webClient를 각 메소드에서 따로 불러야함
		WebClient webClient = WebClient.create("http://apis.data.go.kr/1360000/MidFcstInfoService/getMidLandFcst");
		// API 호출
		int morning = 6;	
		Calendar calendar = Calendar.getInstance();
		if((calendar.HOUR-1)<morning) {
			calendar.add(Calendar.DATE, -1);
			nowTime = new SimpleDateFormat("yyyyMMdd").format(calendar.getTime()) + "1800";
		}else {			
			calendar.add(Calendar.DATE, 0);
			nowTime = new SimpleDateFormat("yyyyMMdd").format(calendar.getTime()) + "0600";
		}
		List<String> sunnyRegions = new ArrayList<>();
		for(RegionDto region : regionList) {
			//지역코드 출력 확인
			String response = webClient.get()
					.uri(uriBuilder -> uriBuilder
							.queryParam("serviceKey", weatherApiKey)
							.queryParam("pageNo", 1)
							.queryParam("numOfRows", 10)
							.queryParam("dataType", "JSON")
							.queryParam("regId", region.getRegionNo())
							.queryParam("tmFc", nowTime)
							.build())
					.retrieve()
					.bodyToMono(String.class)
					.block();
			//System.out.println("[" + region.getRegionName() + "] 응답 결과: " + response);
			
			ObjectMapper mapper = new ObjectMapper();
			JsonNode root = mapper.readTree(response);
			
			JsonNode items = root.path("response").path("body").path("items").path("item");		
			if(items.isArray() && items.size() > 0) {
				JsonNode item = items.get(0);
				// 확인할 키 목록
				//"wf4Am","wf4Pm","wf5Am", "wf5Pm","wf6Am","wf6Pm", "wf7Am", "wf7Pm"
				String[] weatherKeys = {"wf4Am","wf4Pm","wf5Am", "wf5Pm","wf6Am","wf6Pm", "wf7Am", "wf7Pm"};				
				boolean isValid = false;
				for(String key : weatherKeys) {
					String forecast = item.path(key).asText();
					if(forecast.equals("맑음")) {
						isValid = true;
						break;
					}	
				}
				if(isValid == true) {
				    sunnyRegions.add(region.getRegionName());
				}
			}
		} 
			return sunnyRegions;
	}
	
	

	// 축제 호출
		public String callFestivalApi() {
			WebClient webClient = WebClient.builder()
					.baseUrl("https://apis.data.go.kr/B551011/KorService1/searchFestival1")
					.exchangeStrategies(
							ExchangeStrategies.builder()
							.codecs(configurer -> configurer.defaultCodecs().maxInMemorySize(10 * 1024 * 1024)) // 10MB
			                .build()
			        )
			        .build();
			String response = webClient.get()
					.uri(uriBuilder -> uriBuilder
	                        .queryParam("serviceKey", festivalApiKey)
	                        .queryParam("numOfRows", 1000)
	                        .queryParam("pageNo", 1)
	                        .queryParam("MobileOS", "ETC")
	                        .queryParam("MobileApp", "AppTest")
	                        .queryParam("_type", "Json")
	                        .queryParam("listYN", "Y")
	                        .queryParam("arrange", "A")
	                        .queryParam("eventStartDate", "20240101")
	                        .build())
	                .header("Accept", "application/json")
	                .retrieve()
	                .bodyToMono(String.class)
	                .block();
			

			return response;

		}
		
	//기상청 단기예보
		public String callShortWeatherApi(String baseDate, String baseTime, String nx, String ny) {
		    WebClient webClient = WebClient.builder()
		        .baseUrl("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst")
		        .build();

		    return webClient.get()
		        .uri(uriBuilder -> uriBuilder
		            .queryParam("serviceKey", weatherApiKey) 
		            .queryParam("pageNo", 1)
		            .queryParam("numOfRows", 1000)
		            .queryParam("dataType", "JSON")
		            .queryParam("base_date", baseDate)      
		            .queryParam("base_time", baseTime)
		            .queryParam("nx", nx)
		            .queryParam("ny", ny)
		            .build())
		        .retrieve()
		        .bodyToMono(String.class)
		        .block();
		}
		
		public Map<String, String> parseTodayClosestWeather(String json) {
		    Map<String, String> result = new HashMap<>();
		    ObjectMapper mapper = new ObjectMapper();
		    
		    try {
		        JsonNode root = mapper.readTree(json);
		        JsonNode items = root.path("response").path("body").path("items").path("item");

		        // 현재 날짜, 시간 계산
		        LocalDate today = LocalDate.now();
		        String todayStr = today.format(DateTimeFormatter.ofPattern("yyyyMMdd"));

		        LocalTime now = LocalTime.now();
		        // 기준 시간: 지금 시간에서 가장 가까운 예보 시간 찾기
		        int closestDiff = Integer.MAX_VALUE;
		        String targetFcstTime = null;

		        for (JsonNode item : items) {
		            if (!item.path("fcstDate").asText().equals(todayStr)) continue;

		            String fcstTime = item.path("fcstTime").asText();
		            int diff = Math.abs(Integer.parseInt(fcstTime) - now.getHour() * 100);
		            if (diff < closestDiff) {
		                closestDiff = diff;
		                targetFcstTime = fcstTime;
		            }
		        }

		        // 가장 가까운 시간의 TMP, PCP, SKY 값 추출
		        for (JsonNode item : items) {
		            String fcstDate = item.path("fcstDate").asText();
		            String fcstTime = item.path("fcstTime").asText();
		            String category = item.path("category").asText();
		            String value = item.path("fcstValue").asText();

		            if (!fcstDate.equals(todayStr) || !fcstTime.equals(targetFcstTime)) continue;

		            switch (category) {
		                case "TMP":
		                    result.put("기온", value + "℃");
		                    break;
		                case "PCP":
		                    result.put("강수량", value);
		                    break;
		                case "SKY":
		                    result.put("하늘상태", parseSky(value));
		                    break;
		            }
		        }

		    } catch (Exception e) {
		        e.printStackTrace();
		    }

		    return result;
		}

		private String parseSky(String value) {
		    switch (value) {
		        case "1": return "맑음";
		        case "3": return "구름 많음";
		        case "4": return "흐림";
		        default: return "정보 없음";
		    }
		}

}
