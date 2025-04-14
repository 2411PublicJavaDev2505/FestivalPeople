//package com.fepeo.boot.festival.model.service.logic;
//
//import java.util.List;
//
//import org.springframework.stereotype.Service;
//import org.springframework.web.reactive.function.client.WebClient;
//
//import com.fepeo.boot.festival.model.service.FestivalService;
//import com.fepeo.boot.festival.model.vo.FestivalResponse;
//import com.fepeo.boot.festival.model.vo.dto.FestivalItem;
//
//import lombok.RequiredArgsConstructor;
//
//@Service
//@RequiredArgsConstructor
//public class FestivalServiceLogic implements FestivalService {
//
//	private final WebClient webClient;
//
//	@Override
//    public List<FestivalItem> getFestivalList() {
//        String serviceKey = "R5JZpG4itajPJd4pwiwhXgOCT8w19Fvsbj0yIRorF531WoSQxud8S0J0r7zSQfQbcuvYYHgZp3nbd%2BR1DM24xQ%3D%3D";
//
//        FestivalResponse response = webClient
//                .get()
//                .uri(uriBuilder -> uriBuilder
//                        .path("/B551011/KorService1/searchFestival1")
//                        .queryParam("serviceKey", serviceKey)
//                        .queryParam("numOfRows", 10)
//                        .queryParam("pageNo", 1)
//                        .queryParam("MobileOS", "ETC")
//                        .queryParam("MobileApp", "AppTest")
//                        .queryParam("_type", "json")
//                        .queryParam("listYN", "Y")
//                        .queryParam("arrange", "A")
//                        .queryParam("eventStartDate", "20240401")
//                        .build())
//                .header("Accept", "application/json")
//                .retrieve()
//                .bodyToMono(FestivalResponse.class)
//                .block();
//
//        return response.getResponse().getBody().getItems().getItem();
//    }
//}