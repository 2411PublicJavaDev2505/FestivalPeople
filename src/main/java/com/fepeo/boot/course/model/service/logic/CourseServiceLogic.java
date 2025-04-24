package com.fepeo.boot.course.model.service.logic;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fepeo.boot.course.model.mapper.CourseMapper;
import com.fepeo.boot.course.model.service.CourseService;
import com.fepeo.boot.course.model.vo.Course;
import com.fepeo.boot.course.model.vo.dto.CourseDto;
import com.fepeo.boot.course.model.vo.dto.RegionDto;
import com.fepeo.boot.festival.model.vo.Festival;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CourseServiceLogic implements CourseService{
	
	private final CourseMapper mapper;

	@Override
	public List<RegionDto> getAllRegions() {
		return mapper.selectRegionList();
	}

	@Override
	public int insertCourse(String courseName, List<CourseDto> course, Festival festival) {
		return mapper.insertCourse(courseName, course, festival);
	}

	@Override
	public List<CourseDto> selectCourseByNo(int memberNo) {
		return mapper.selectCourseByNo(memberNo);
	}
	
}
