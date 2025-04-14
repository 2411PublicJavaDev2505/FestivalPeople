package com.fepeo.boot.festival.model.service.logic;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fepeo.boot.festival.model.service.FestivalService;
import com.fepeo.boot.festival.model.vo.FestivalResponse;
import com.fepeo.boot.festival.model.vo.dto.FestivalItem;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FestivalServiceLogic  implements FestivalService{
	
	private final RestTemplate restTemplate = new RestTemplate();
	
	@Override
	public List<FestivalItem> getFestivalList() {
		String serviceKey = "R5JZpG4itajPJd4pwiwhXgOCT8w19Fvsbj0yIRorF531WoSQxud8S0J0r7zSQfQbcuvYYHgZp3nbd%2BR1DM24xQ%3D%3D";
        String url = "https://apis.data.go.kr/B551011/KorService1/searchFestival1"
                + "?serviceKey=" + serviceKey
                + "&numOfRows=10&pageNo=5&MobileOS=ETC&MobileApp=AppTest&_type=json&listYN=Y&arrange=A&eventStartDate=20170901";

        FestivalResponse response = restTemplate.getForObject(url, FestivalResponse.class);
        return response.getResponse().getBody().getItems().getItem();
	}

}
