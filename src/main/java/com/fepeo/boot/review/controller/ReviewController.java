package com.fepeo.boot.review.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
@RequestMapping("/review")
public class ReviewController {
	
	//후기리스트
	
	@GetMapping("/list")
	public String showReviewList() {
		//System.out.println("확인");
		return "review/list";
	}
	
	//후기등록
	
	@GetMapping("/insert")
	public String insertReview() {
		return "review/insert";
	}
}
