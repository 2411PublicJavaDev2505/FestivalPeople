package com.fepeo.boot.festival.model.service.logic;



import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fepeo.boot.common.controller.api.ApiComponent;
import com.fepeo.boot.festival.model.mapper.FestivalMapper;
import com.fepeo.boot.festival.model.service.FestivalService;
import com.fepeo.boot.festival.model.vo.Festival;
import com.fepeo.boot.festival.model.vo.dto.FestivalItem;
import com.fepeo.boot.festival.model.vo.dto.FestivalResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FestivalServiceLogic implements FestivalService {

	private final ApiComponent apiComponent;
    private final FestivalMapper festivalMapper;
    
    @Override
    public void insertFestivalList() {
        try {
            // 1. API 호출
            String json = apiComponent.callFestivalApi();

            // 2. JSON → Java 객체 파싱
            ObjectMapper mapper = new ObjectMapper();
            FestivalResponse response = mapper.readValue(json, FestivalResponse.class);
            List<FestivalItem> items = response.getResponse().getBody().getItems().getItem();


            // 3. 각각 Festival 객체로 매핑 후 DB 저장
            for (FestivalItem item : items) {
            	
            	if (item.getAddr1() == null || item.getAddr1().trim().isEmpty()) {
                    System.out.println("[SKIP] 주소 정보 없음: " + item.getTitle());
                    continue; // 다음 아이템으로 넘어감
                }
                Festival festival = new Festival();
                festival.setFestivalName(item.getTitle());
                festival.setFestivalStartDate(Date.valueOf(formatDate(item.getEventstartdate())));
                festival.setFestivalEndDate(Date.valueOf(formatDate(item.getEventenddate())));
                festival.setFestivalFilePath(item.getFirstimage());
                festival.setFestivalPhone(item.getTel());
                festival.setFestivalAddress(item.getAddr1());
                festival.setFestivalDetailAddress(item.getAddr2());
                festival.setMapVCode(item.getMapx());
                festival.setMapHCode(item.getMapy());
//                System.out.println("주소 확인: " + item.getTitle() + " → " + item.getAddr1());

             // 중복 여부 체크
                if (!festivalMapper.isDuplicateFestival(festival)) {
                    festivalMapper.insertFestival(festival);
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String formatDate(String raw) {
        if (raw == null || raw.length() < 8) return "2000-01-01";
        return raw.substring(0, 4) + "-" + raw.substring(4, 6) + "-" + raw.substring(6, 8);
    }

    @Override
    public List<Festival> selectFestivalList(int startRow, int endRow) {
        Map<String, Integer> params = new HashMap<>();
        params.put("startRow", startRow-1);
        return festivalMapper.selectFestivalList(params);
    }


	@Override
	public Festival selectFestivalByNo(int festivalNo) {
		return festivalMapper.selectFestivalByNo(festivalNo);
	}

	@Override
	public int getTotalCount() {
		return festivalMapper.getTotalCount();
	}


	//축제에서 사용하는 축제 검색 기능 
	@Override
	public List<Festival> searchFestivalListAll(int startRow, int endRow, Map<String, String> searchMap) {
		Map<String, Integer> params = new HashMap<>();
		params.put("startRow", startRow-1);
		params.put("endRow", endRow);
		return festivalMapper.searchFestivalListAll(params,searchMap);
	}
	@Override
	public int getSearchTotalCount(Map<String, String> searchMap) {
		return festivalMapper.getSearchTotalCount(searchMap);
	}

	@Override
	public List<Festival> selectFestivalListByWeather(List<String> goodWeatherRegions) {
		List<Festival> rfestivals = festivalMapper.selectFestivalListByWeather(goodWeatherRegions);
		return rfestivals;
	}

	
	//코스추천에서 사용하는 축제 검색 기능
	@Override
	public List<Festival> searchFestivalList(Map<String, String> searchMap) {
		return festivalMapper.searchFestivalList(searchMap);
	}
	// 지역명 기반으로 축제리스트 출력 (코스 Controller에서 사용함 )
	@Override
	public List<Festival> selectFestivalListByRegion(List<String> goodWeather, Map<String, String> mapPoint) {		
		return festivalMapper.selectFestivalListByRegion(goodWeather, mapPoint);
	}

	

	}

