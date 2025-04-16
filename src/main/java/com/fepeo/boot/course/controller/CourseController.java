package com.fepeo.boot.course.controller;


import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fepeo.boot.common.controller.api.ApiComponent;
import com.fepeo.boot.course.model.service.CourseService;
import com.fepeo.boot.course.model.vo.dto.RegionDto;
import com.fepeo.boot.member.model.service.MemberService;
import com.fepeo.boot.member.model.vo.Member;

import ch.qos.logback.core.model.Model;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/course")
public class CourseController {

	private final CourseService cService;
	private final MemberService mService;
	private final ApiComponent api;
	
	// 비회원은 확인 불가능한 회원 위치기반 전용 코스 추천 리스트 출력
	@GetMapping("/list")
	public String showCourse(HttpSession session, Model model) throws JsonMappingException, JsonProcessingException {
		// 로그인 회원 분기처리
		Member member = (Member)session.getAttribute("member");
		// 날씨 검색을 위한 현재시간 기준 변수 (날씨 API 호출시 넘김)
		String nowTime = "";
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, -1);
		nowTime = new SimpleDateFormat("yyyyMMdd").format(calendar.getTime()) + "1800";

		// 비회원은 안되어있으면 로그인페이지로
		if(member.getMemberId() == null) {
			return "member/login";
	    // 로그인된 회원 기준으로 주소지 가져오기
		}else {
			// 로그인 회원 정보 출력
			Member memberInfo = mService.selectOneByNo(member.getMemberNo());
			// 회원 정보에 저장된 주소지 값으로 위, 경도 좌표 출력
			String memberAddress = memberInfo.getAddress();
			Map<String, String> mapPoint = api.searchMemberAddress(memberAddress);
			System.out.println(mapPoint);
			// 현재 시간 기준 전국 날씨 추출
			List<RegionDto> regionList = cService.getAllRegions();
			System.out.println(regionList);
			List<String> weatherInfo = api.callWeatherApi(nowTime, regionList);
			System.out.println(weatherInfo);
			
		}
		
		
		return "course/list";
	}
	
	
	@GetMapping("/detail")
	public String showCourseDetail() {

		return "course/courseDetail";
	}
	
	
}
