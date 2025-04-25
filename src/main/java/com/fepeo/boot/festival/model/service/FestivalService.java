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
	public List<Festival> searchFestivalListAll(int startRow, int endRow, Map<String, String> searchMap);
	
	public List<Festival> searchFestivalList(Map<String, String> searchMap);
	
	public int getSearchTotalCount(Map<String, String> searchMap);

	public List<Festival> selectFestivalListByWeather(List<String> goodWeatherRegions);
	
	// 날씨가 좋은 지역명으로 축제 검색
	public List<Festival> selectFestivalListByRegion(List<String> goodWeather, Map<String, String> mapPoint);
	
}
	
	
	


