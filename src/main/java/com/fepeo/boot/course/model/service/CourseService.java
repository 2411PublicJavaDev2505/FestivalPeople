package com.fepeo.boot.course.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fepeo.boot.course.model.vo.Course;
import com.fepeo.boot.course.model.vo.dto.RegionDto;
import com.fepeo.boot.festival.model.vo.Festival;


public interface CourseService {
	
	public List<RegionDto> getAllRegions();

	public int insertCourse(Course course);

	public List<Course> selectCourseByNo(int memberNo);
	

	
	
}
