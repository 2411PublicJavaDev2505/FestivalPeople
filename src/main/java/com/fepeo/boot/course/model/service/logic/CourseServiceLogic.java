package com.fepeo.boot.course.model.service.logic;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fepeo.boot.course.model.mapper.CourseMapper;
import com.fepeo.boot.course.model.service.CourseService;
import com.fepeo.boot.course.model.vo.Course;
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
	public int insertCourse(Course course) {
		return mapper.insertCourse(course);
	}

	@Override
	public List<Course> selectCourseByNo(int memberNo) {
		return mapper.selectCourseByNo(memberNo);
	}

	@Override
	public Course selectOneByCourseNo(int courseNo) {
		return mapper.selectOneByCourseNo(courseNo);
	}

	@Override
	public int deleteCourse(int memberNo, int courseNo) {
		return mapper.deleteCourse(memberNo, courseNo);
	}
	
}
