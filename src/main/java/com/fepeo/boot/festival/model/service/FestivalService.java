package com.fepeo.boot.festival.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.fepeo.boot.festival.model.vo.Festival;


@Service
public interface FestivalService {
	
	public void insertFestivalList();

	public List<Festival> getFestivalList(int startRow, int endRow);

	public Festival getFestivalByNo(int festivalNo);

	public int getTotalCount();

	// 날씨가 좋은 지역명으로 축제 검색
	public List<Festival> selectFestivalListByRegion(List<String> goodWeather, Map<String, String> mapPoint);

	public List<Festival> getrFestivalList();

	
}
	
	
	


