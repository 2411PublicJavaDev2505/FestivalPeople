package com.fepeo.boot.course.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fepeo.boot.course.model.vo.dto.CourseDto;
import com.fepeo.boot.course.model.vo.dto.RegionDto;
import com.fepeo.boot.festival.model.vo.Festival;


public interface CourseService {
	
	public List<RegionDto> getAllRegions();

	public int insertCourse(String courseName, List<CourseDto> course, Festival festival);
	

	
	
}
