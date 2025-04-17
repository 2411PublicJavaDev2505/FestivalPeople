package com.fepeo.boot.festival.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.fepeo.boot.festival.model.vo.Festival;


@Service
public interface FestivalService {
	
	public void insertFestivalList();

	public List<Festival> selectFestivalList(int startRow, int endRow);

	public Festival selectFestivalByNo(int festivalNo);

	public int getTotalCount();

	//날씨 기반으로 추천 리스트 출력
	public List<Festival> selectFestivalListById();
	
	// 날씨가 좋은 지역명으로 축제 검색
	public List<Festival> selectFestivalListByRegion(List<String> goodWeather, Map<String, String> mapPoint);
	
	public List<Festival> searchFestivalList(Map<String, String> searchMap);

	
}
	
	
	


