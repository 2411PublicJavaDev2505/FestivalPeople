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

	Festival selectFestivalByNo(int festivalNo);

	int getTotalCount();

	List<Festival> selectFestivalListByRegion(@Param("regionNames") List<String> regionNames, Map<String,String> mapPoint);
	
}
