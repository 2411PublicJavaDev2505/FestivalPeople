package com.fepeo.boot.course.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.course.model.vo.Course;

import com.fepeo.boot.course.model.vo.dto.RegionDto;
import com.fepeo.boot.festival.model.vo.Festival;

@Mapper
public interface CourseMapper {

	List<RegionDto> selectRegionList();

	int insertCourse(Course course);

	List<Course> selectCourseByNo(int memberNo);

	Course selectOneByCourseNo(int courseNo);

	int deleteCourse(int memberNo, int courseNo);
	
	
}
