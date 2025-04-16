package com.fepeo.boot.course.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.course.model.vo.dto.RegionDto;

@Mapper
public interface CourseMapper {

	List<RegionDto> selectRegionList();
	
	
}
