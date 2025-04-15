package com.fepeo.boot.course.controller;


import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.util.UriComponentsBuilder;

import com.fepeo.boot.common.controller.api.ApiComponent;
import com.fepeo.boot.course.model.service.CourseService;
import com.fepeo.boot.member.model.service.MemberService;
import com.fepeo.boot.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/course")
public class CourseController {

//	private final CourseService cService;
	private final MemberService mService;
	private final ApiComponent api;
	
	// 비회원은 확인 불가능한 회원 위치기반 전용 코스 추천 리스트 출력
	@GetMapping("/list")
	public String showCourse(HttpSession session) {
		
		// 로그인 회원 분기처리
		Member member = (Member)session.getAttribute("member");
		
		// 비회원은 안되어있으면 로그인페이지로
		if(member.getMemberId() == null) {
			return "member/login";
	    // 로그인된 회원 기준으로 주소지 가져오기
		}else {
			Member memberInfo = mService.selectOneByNo(member.getMemberNo());
			String memberAddress = memberInfo.getAddress();
//			Map<String,String> address = api.searchMemberAddress(memberAddress);
			
			
			
			
			
		}
		
		
		return "course/list";
	}
	
	@GetMapping("/detail")
	public String showCourseDetail() {

		
		return "course/courseDetail";
	}
	
	
}
