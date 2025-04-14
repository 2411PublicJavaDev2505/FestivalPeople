package com.fepeo.boot.course.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.util.UriComponentsBuilder;

import com.fepeo.boot.course.model.service.CourseService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/course")
public class CourseController {

//	private final CourseService cService;
	
	@GetMapping("/list")
	public String showCourse() {
		return "course/list";
	}
	
	@GetMapping("/detail")
	public String showCourseDetail() {

		
		return "course/courseDetail";
	}
	
	
}
