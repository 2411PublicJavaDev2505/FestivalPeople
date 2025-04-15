package com.fepeo.boot.festival.model.mapper;


import java.util.List;


import org.apache.ibatis.annotations.Mapper;


import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.festival.model.vo.Festival;

@Mapper
public interface FestivalMapper {
	
	int insertFestival(Festival festival);
    
	List<Festival> selectFestivalList();
	
	
}
