package com.fepeo.boot.festival.model.mapper;


import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.fepeo.boot.festival.model.vo.Festival;

@Mapper
public interface FestivalMapper {
	
	int insertFestival(Festival festival);
    
	List<Festival> selectFestivalList(Map<String, Integer> params);
	//회원인 경우 추천 축제 리스트
	List<Festival> selectFestivalListByRegionName(String matchedRegion);
	//비회원 날씨 기준 추천 리스트
	List<Festival> selectFestivalListByWeather(@Param("list") List<String> list);

	Festival selectFestivalByNo(int festivalNo);

	int getTotalCount();
	
	List<Festival> searchFestivalListAll(@Param("params")Map<String, Integer> params,@Param("searchMap") Map<String, String> searchMap);
	//search paginaiton 받는 값
	int getSearchTotalCount(@Param("searchMap")Map<String, String> searchMap);


	//코스에서 사용하는 메소드
	List<Festival> selectFestivalListByRegion(@Param("regionNames") List<String> regionNames, Map<String,String> mapPoint);
	
	List<Festival> searchFestivalList(Map<String, String> searchMap);


	
}
