package com.fepeo.boot.course.controller;


import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.fepeo.boot.course.model.vo.dto.Categories;
import com.fepeo.boot.course.model.vo.dto.CourseForm;
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
			// 회원 정보에 저장된 주소지 값으로 위, 경도 좌표 출력
			String memberAddress = memberInfo.getAddress();
			Map<String, String> mapPoint = api.searchMemberAddress(memberAddress);
//			System.out.println(mapPoint);
			// 현재 시간 기준 전국 날씨 추출
			List<RegionDto> regionList = cService.getAllRegions();
			List<String> goodWeather = api.callWeatherApi(regionList);
//			System.out.println(goodWeather);	
			//날씨 좋은 지역과 회원 좌표를 가지고 축제 리스트 출력
			List<Festival> fList = fService.selectFestivalListByRegion(goodWeather, mapPoint);
//			System.out.println(fList);
//			System.out.println(fList.size());
			
			if(fList.size() > 0 && !fList.isEmpty()) {
				model.addAttribute("fList", fList);				
			}

			//추후에 빈값 분기처리해서 메세지 넘기기
//			if(fList.size() == 0 && fList.isEmpty()) {
//				List<Festival> rList = fService.getrFestivalList();
//			}
			
			return "/course/list";
		}
	}
	
	@PostMapping("/list")
	public String showSearchCourse(HttpSession session
			, Model model
			,@RequestParam("searchCondition") String searchCondition
			,@RequestParam("searchKeyword") String searchKeyword) {
		
		Map<String, String> searchMap = new HashMap<String, String>();
		searchMap.put("searchKeyword", searchKeyword);
		searchMap.put("searchCondition", searchCondition);
		
		System.out.println(searchKeyword);
		System.out.println(searchCondition);
		
		
		List<Festival> fList = fService.searchFestivalList(searchMap);
		System.out.println(fList);
		model.addAttribute("fList", fList);
		
		return "/course/list";
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
	public String insertCourse(@ModelAttribute CourseForm courseForm, Model model) {
		List<PlaceDto> places = courseForm.getPlaces();
		System.out.println("왜 안되니 ㅠ"+places);
		
		return "/";
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
		// 축제 좌표값 근처로 가까운 밥집 리스트 15개 출력
//		List<PlaceDto> matZipList = api.kakaoMatzipApi(festivalXY);
//		// 축제 좌표값 근처로 가까운 숙박시설 리스트 15개 출력
//		List<PlaceDto> hotelList =  api.kakaoHotelApi(festivalXY);
//		
//			PlaceDto matZipRec = matZipList.get(0);
//			System.out.println(matZipRec);
			// 축제 좌표값으로 가까운 숙박시설 한개 선택
//			PlaceDto hotelRec = hotelList.get(0);
//			System.out.println(hotelRec);
			// 추천 코스 좌표값 매핑하기
			Map<String, String> coursePoint = new HashMap<String, String>();
			coursePoint.put("festivalX", festival.getMapVCode());
			coursePoint.put("festivalY", festival.getMapHCode());
//			coursePoint.put("matzipX", matZipRec.getX());
//			coursePoint.put("matzipY", matZipRec.getY());
//			coursePoint.put("hotelX", hotelRec.getX());
//			coursePoint.put("hotelY", hotelRec.getY());
//		System.out.println(coursePoint);
			// 이건 추후에 사용할 키 숨김
//		String kakaoKey = api.getKakaoApiKey();
			//System.out.println(festival.getFestivalFileName());		
//		model.addAttribute("kakaoKey", kakaoKey);
//			model.addAttribute("hotel", hotelRec);
//			model.addAttribute("matZip", matZipRec);
			model.addAttribute("festival", festival);
			model.addAttribute("coursePoint", coursePoint);
			return "course/courseDetail";
	
	}
}
