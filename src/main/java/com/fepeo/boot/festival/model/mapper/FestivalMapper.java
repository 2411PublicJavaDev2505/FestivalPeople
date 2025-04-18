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

	List<Festival> selectFestivalListById ();

	Festival selectFestivalByNo(int festivalNo);

	int getTotalCount();
	
	List<Festival> searchFestivalListAll(@Param("params")Map<String, Integer> params,@Param("searchMap") Map<String, String> searchMap);
	//search paginaiton 받는 값
	int getSearchTotalCount(@Param("searchMap")Map<String, String> searchMap);



	//코스에서 사용하는 메소드
	List<Festival> selectFestivalListByRegion(@Param("regionNames") List<String> regionNames, Map<String,String> mapPoint);
	
	List<Festival> searchFestivalList(Map<String, String> searchMap);
	
}
