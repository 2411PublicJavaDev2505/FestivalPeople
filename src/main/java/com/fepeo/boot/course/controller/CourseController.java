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
import com.fepeo.boot.course.model.vo.dto.CourseDto;
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
			
			return "course/list";
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
			
			
		System.out.println(placeList);
		}
		System.out.println(placeList);
		return placeList;
	}
	

	@PostMapping("/insert")
	public String insertCourse(@RequestParam("category_group_code") List<String> category
			,@RequestParam("place_name") List<String> placeName
			,@RequestParam("x") List<String> xs
			,@RequestParam("y") List<String> ys
			,@RequestParam("courseName") String courseName
			,@RequestParam("festivalNo") int festivalNo
			,Model model
			,HttpSession session) {
		
		CourseDto matzip = new CourseDto();
		CourseDto hotel = new CourseDto();
		CourseDto cafe = new CourseDto();
		CourseDto tour = new CourseDto();
		CourseDto parking = new CourseDto();
		CourseDto culture = new CourseDto();
		List<CourseDto> course = new ArrayList<CourseDto>();
		Festival festival = fService.selectFestivalByNo(festivalNo);

		Member member = (Member)session.getAttribute("member");
		

	
		
		
		for(int i = 0; i < category.size(); i++) {
			
			if(category.get(i).equals("FD6")) {
				matzip.setCategoryCode(category.get(i));
				matzip.setPlaceName(placeName.get(i));
				matzip.setX(xs.get(i));
				matzip.setY(ys.get(i));
				course.add(matzip);
			}
			
			
			if(category.get(i).equals("AD5")) {
				hotel.setCategoryCode(category.get(i));
				hotel.setPlaceName(placeName.get(i));
				hotel.setX(xs.get(i));
				hotel.setY(ys.get(i));
				course.add(hotel);
			}
			
			
			if(category.get(i).equals("CE7")) {
				cafe.setCategoryCode(category.get(i));
				cafe.setPlaceName(placeName.get(i));
				cafe.setX(xs.get(i));
				cafe.setY(ys.get(i));
				course.add(cafe);
			}
			
			
			if(category.get(i).equals("AT4")) {
				tour.setCategoryCode(category.get(i));
				tour.setPlaceName(placeName.get(i));
				tour.setX(xs.get(i));
				tour.setY(ys.get(i));
				course.add(tour);
			}
			
			
			if(category.get(i).equals("PK6")) {
				parking.setCategoryCode(category.get(i));
				parking.setPlaceName(placeName.get(i));
				parking.setX(xs.get(i));
				parking.setY(ys.get(i));
				course.add(parking);
			}
			
			
			if(category.get(i).equals("CT1")) {
				culture.setCategoryCode(category.get(i));
				culture.setPlaceName(placeName.get(i));
				culture.setX(xs.get(i));
				culture.setY(ys.get(i));
				course.add(culture);
			}
			
		int result = cService.insertCourse(courseName, course, festival);
			
		}

		
		return "course/list";
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
