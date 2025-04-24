package com.fepeo.boot.course.controller;


import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fepeo.boot.common.controller.api.ApiComponent;
import com.fepeo.boot.course.model.service.CourseService;
import com.fepeo.boot.course.model.vo.Course;
import com.fepeo.boot.course.model.vo.dto.Categories;
import com.fepeo.boot.course.model.vo.dto.PlaceDto;
import com.fepeo.boot.course.model.vo.dto.RegionDto;
import com.fepeo.boot.festival.model.service.FestivalService;
import com.fepeo.boot.festival.model.vo.Festival;
import com.fepeo.boot.member.model.service.MemberService;
import com.fepeo.boot.member.model.vo.Member;

import jakarta.annotation.PostConstruct;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/course")
public class CourseController {

	private final CourseService cService;
	private final MemberService mService;
	private final FestivalService fService;
	private final ApiComponent api;
	
	
	
	// 비회원은 확인 불가능한 회원 위치기반 전용 코스 추천 리스트 출력
	@GetMapping("/list")
	public String showCourseMain(HttpSession session, Model model) throws JsonMappingException, JsonProcessingException {
		// 로그인 회원 분기처리
		Member member = (Member)session.getAttribute("member");
		// 비회원은 안되어있으면 로그인페이지로
		if(member == null) {
			return "redirect:/member/login";
	    // 로그인된 회원 기준으로 주소지 가져오기
		}else {
			// 로그인 회원 정보 출력
			Member memberInfo = mService.selectOneByNo(member.getMemberNo());
			System.out.println("고속도로"+memberInfo);
			// 회원 정보에 저장된 주소지 값으로 위, 경도 좌표 출력
			String memberAddress = memberInfo.getAddress();

			String memberName = member.getMemberName();
			Map<String, String> mapPoint = api.searchMemberAddress(memberAddress);
//			System.out.println(mapPoint);
			// 현재 시간 기준 전국 날씨 추출
			List<RegionDto> regionList = cService.getAllRegions();
			
			String gWRegions = (String)session.getAttribute("gWRegions");
		    List<String> goodWeatherRegions = new ArrayList<>();
		    if(gWRegions == null) {
		    	goodWeatherRegions = api.callWeatherApi(regionList);
		    	gWRegions = "";
		    	for(int i=0;i<goodWeatherRegions.size();i++) {
		    		if(i != goodWeatherRegions.size() -1) {
		    			gWRegions += goodWeatherRegions.get(i)+",";
		    		}else {
		    			gWRegions += goodWeatherRegions.get(i);
		    		}
		    	}
		    	session.setAttribute("gWRegions", gWRegions);
		    }else {
		    	String[] strList = gWRegions.split(",");
		    	goodWeatherRegions = Arrays.asList(strList);
		    }

			//날씨 좋은 지역과 회원 좌표를 가지고 축제 리스트 출력
			List<Festival> fList = fService.selectFestivalListByRegion(goodWeatherRegions, mapPoint);
		
			if(fList.size() > 0 && !fList.isEmpty()) {
				model.addAttribute("fList", fList);			
				model.addAttribute("message", "회원님께 추천드리는 리스트에요!");
				model.addAttribute("memberName", memberName);
				return "course/list";
			}else {
				return "common/error";
			}
			
		}
	}
	
	//검색한 추천 리스트 출력
	@PostMapping("/search")
	public String showSearchfestival(HttpSession session
			, Model model
			,@RequestParam("searchCondition") String searchCondition
			,@RequestParam("searchKeyword") String searchKeyword) {		
		// session 멤버 확인
		Member member = (Member)session.getAttribute("member");
		String memberName = member.getMemberName();
		
		Map<String, String> searchMap = new HashMap<String, String>();
		searchMap.put("searchKeyword", searchKeyword);
		searchMap.put("searchCondition", searchCondition);
		
		
		List<Festival> fList = fService.searchFestivalList(searchMap);

		model.addAttribute("fList", fList);
		model.addAttribute("message", "회원님이 검색하신 리스트에요!");
		model.addAttribute("memberName", memberName);
		return "course/list";
	}
	
	
	@ResponseBody
	@PostMapping("/filter")
	public List<PlaceDto> filterByCategory(@RequestBody Categories categories) {
		System.out.println(categories.getCategories());
		System.out.println(categories.getFestivalNo());
		int festivalNo = categories.getFestivalNo();
		Festival festival = fService.selectFestivalByNo(festivalNo);
		Map<String, String> festivalXY = new HashMap<String, String>();
		festivalXY.put("X", festival.getMapVCode());
		festivalXY.put("Y", festival.getMapHCode());
		
		List<PlaceDto> placeList = new ArrayList<PlaceDto>(); 

		for(String cate : categories.getCategories()) {
			if(cate.equals("FD6")) {
				PlaceDto matzip = api.kakaoCourseApi(festivalXY, cate);
				placeList.add(matzip);
				System.out.println(matzip);
			}
			if(cate.equals("AD5")) {
				PlaceDto hotel = api.kakaoCourseApi(festivalXY, cate);
				placeList.add(hotel);
				System.out.println(hotel);
			}
			if(cate.equals("CE7")) {
				PlaceDto cafe = api.kakaoCourseApi(festivalXY, cate);
				placeList.add(cafe);
				System.out.println(cafe);
			}
			if(cate.equals("AT4")) {
				PlaceDto tour = api.kakaoCourseApi(festivalXY, cate);
				placeList.add(tour);
				System.out.println(tour);
			}
			if(cate.equals("PK6")) {
				PlaceDto parking = api.kakaoCourseApi(festivalXY, cate);
				placeList.add(parking);
				System.out.println(parking);
			}
			if(cate.equals("CT1")) {
				PlaceDto culture = api.kakaoCourseApi(festivalXY, cate);
				placeList.add(culture);
				System.out.println(culture);
			}	
			
			
		}
		System.out.println(placeList);
		return placeList;
	}
	

	@PostMapping("/insert")
	@ResponseBody
	public ResponseEntity<String> insertCourse(@RequestParam("category_group_code") List<String> category
			,@RequestParam("place_name") List<String> placeName
			,@RequestParam("x") List<String> xs
			,@RequestParam("y") List<String> ys
			,@RequestParam("courseName") String courseName
			,@RequestParam("festivalNo") int festivalNo
			,Model model
			,HttpSession session) {
		
		Course course = new Course();
		Festival festival = fService.selectFestivalByNo(festivalNo);

		Member member = (Member)session.getAttribute("member");
		course.setMemberNo(member.getMemberNo());
		course.setFestivalNo(festival.getFestivalNo());
		course.setFestivalName(festival.getFestivalName());
		course.setFestivalImg(festival.getFestivalFilePath());
		course.setCourseName(courseName);
		
		
		for(int i = 0; i < category.size(); i++) {
			
			if(category.get(i).equals("FD6")) {
				course.setMatzipCategory(category.get(i));
				course.setMatzipPlaceName(placeName.get(i));
				course.setMatzipMAPX(xs.get(i));
				course.setMatzipMAPY(ys.get(i));			
			}else if(category.get(i).equals("AD5")) {
				course.setHotelCategory(category.get(i));
				course.setHotelPlaceName(placeName.get(i));
				course.setHotelMAPX(xs.get(i));
				course.setHotelMAPY(ys.get(i));
			}else if(category.get(i).equals("CE7")) {
				course.setCafeCategory(category.get(i));
				course.setCafePlaceName(placeName.get(i));
				course.setCafeMAPX(xs.get(i));
				course.setCafeMAPY(ys.get(i));
			}else if(category.get(i).equals("AT4")) {
				course.setTourCategory(category.get(i));
				course.setTourPlaceName(placeName.get(i));
				course.setTourMAPX(xs.get(i));
				course.setTourMAPY(ys.get(i));
			}else if(category.get(i).equals("PK6")) {
				course.setParkingCategory(category.get(i));
				course.setParkingPlaceName(placeName.get(i));
				course.setParkingMAPX(xs.get(i));
				course.setParkingMAPY(ys.get(i));
			}else if(category.get(i).equals("CT1")) {
				course.setCultureCategory(category.get(i));
				course.setCulturePlaceName(placeName.get(i));
				course.setCultureMAPX(xs.get(i));
				course.setCultureMAPY(ys.get(i));				
			}		
		}

		int result = cService.insertCourse(course);
		if(result > 0) {
			return ResponseEntity.ok("success");
		}
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail");
	}
	

	
	
	@GetMapping("/detail")
	public String showCourseDetail(@RequestParam("festivalNo") int festivalNo
			,Model model
			) {
		
		String sort = "";	
		// 선택한 축제 번호로 축제 정보 가져오기
		Festival festival = fService.selectFestivalByNo(festivalNo);
		
		// 축제 주소 좌표값 설정
		Map<String, String> festivalXY = new HashMap<String, String>();
		festivalXY.put("x", festival.getMapVCode());
		festivalXY.put("y", festival.getMapHCode());

			// 추천 코스 좌표값 매핑하기
			Map<String, String> coursePoint = new HashMap<String, String>();
			coursePoint.put("festivalX", festival.getMapVCode());
			coursePoint.put("festivalY", festival.getMapHCode());
			
			model.addAttribute("festival", festival);
			model.addAttribute("coursePoint", coursePoint);
			return "course/courseDetail";
	
	}
}
