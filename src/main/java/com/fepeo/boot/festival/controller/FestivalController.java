package com.fepeo.boot.festival.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fepeo.boot.common.controller.api.ApiComponent;
import com.fepeo.boot.common.util.PageUtil;
import com.fepeo.boot.common.util.WeatherUtils;
import com.fepeo.boot.course.model.service.CourseService;
import com.fepeo.boot.course.model.vo.dto.RegionDto;
import com.fepeo.boot.festival.model.service.FestivalService;
import com.fepeo.boot.festival.model.vo.Festival;
import com.fepeo.boot.member.model.service.MemberService;
import com.fepeo.boot.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/festival")
public class FestivalController {
	
	private final FestivalService festivalService;
	private final PageUtil pageUtil;
	private final MemberService memberService;
	private final CourseService courseService;
	private final ApiComponent api;

	
	@GetMapping("/list")
	public String showFestivalList(
	    @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
	    Model model,HttpSession session
	) throws JsonMappingException, JsonProcessingException {
		Member member = (Member)session.getAttribute("member");		
		//전체 리스트 출력시 페이지 네이션 코드 
	    int totalCount = festivalService.getTotalCount();
	    int itemsPerPage = 8;
	    Map<String, Integer> pageInfo = pageUtil.generatePageInfo(totalCount, currentPage, itemsPerPage);
	    List<Festival> rfestivals = null;
	    List<RegionDto> regionList = courseService.getAllRegions();
	    List<String> goodWeatherRegions = api.callWeatherApi(regionList);
	    
	    if(member != null) {
			//로그인 됬을때 
			Member memberInfo = memberService.selectOneByNo(member.getMemberNo());
	    	String memberAddress = memberInfo.getAddress();
	    	//회원주소에서 지역명 매핑
	    	String matchedRegion ="";
	    	for (String region : goodWeatherRegions) {
	            if (memberAddress.contains(region)) {
	                matchedRegion = region;
	                break;
	            }
	        }
	    	if(!matchedRegion.isEmpty()) {
	    		//해당 지역 축제만 필터링 하기
	    		rfestivals =festivalService.selectFestivalListByRegionName(matchedRegion);// 회원일 때 불러오는 리스트 
	    	}
	    	
		}else {
			rfestivals = festivalService.selectFestivalListByWeather(goodWeatherRegions); // 비회원일때 불러오는 리스트 
		}
	    //전체 리스트 출력 
	    List<Festival> festivals = festivalService.selectFestivalList(pageInfo.get("startRow"), pageInfo.get("endRow"));
	    model.addAttribute("maxPage", pageInfo.get("maxPage"));
	    model.addAttribute("startNavi", pageInfo.get("startNavi"));
	    model.addAttribute("endNavi", pageInfo.get("endNavi"));
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("festivals", festivals);
	    model.addAttribute("rfestivals",rfestivals);

	    return "festival/list";
	}
	//상세페이지
	@GetMapping("/detail/{festivalNo}")
	public String showFestivalDetail(@PathVariable  int festivalNo, Model model) {
		Festival festival = festivalService.selectFestivalByNo(festivalNo);
		//좌표 추출
		String nx = festival.getMapHCode();
		String ny = festival.getMapVCode();
		//날짜, 시간 생성
		Map<String, String> dateTimeMap = WeatherUtils.getWeatherBaseDateTime();
		String baseDate = dateTimeMap.get("baseDate");
		String baseTime = dateTimeMap.get("baseTime");
		String weatherJson = api.callShortWeatherApi(nx, ny);
		model.addAttribute("festival",festival);
		model.addAttribute("weather",weatherJson);
		return "festival/festivalDetail";
	}
	
	//축제 최신화
	@GetMapping("/insert")
	public String insertFestivalList(Model model) {
		festivalService.insertFestivalList();
		model.addAttribute("msg", "저장완료");
		return "festival/list";
	}
	//축제 검색
	@GetMapping("/search")
	public String searchFestivalList(HttpSession session
			,Model model
			,@RequestParam("searchCondition") String searchCondition
			,@RequestParam("searchKeyword") String searchKeyword
			,@RequestParam(value = "currentPage", defaultValue = "1") int currentPage){
		
		Map<String, String> searchMap = new HashMap <String, String>();
		searchMap.put("searchKeyword", searchKeyword);
		searchMap.put("searchCondition", searchCondition);
		System.out.println(searchCondition);
		int totalCount = festivalService.getSearchTotalCount(searchMap);
	    int itemsPerPage = 8;
	    Map<String, Integer> pageInfo = pageUtil.generatePageInfo(totalCount, currentPage, itemsPerPage);
	    List<Festival> festivals = festivalService.searchFestivalListAll(pageInfo.get("startRow"), pageInfo.get("endRow"),searchMap);
//	    System.out.println("검색된 축제 수 : " + festivals.size());
	    for (Festival f : festivals) {
//	        System.out.println("축제명: " + f.getFestivalName());
	    }
	    model.addAttribute("maxPage", pageInfo.get("maxPage"));
	    model.addAttribute("startNavi", pageInfo.get("startNavi"));
	    model.addAttribute("endNavi", pageInfo.get("endNavi"));
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("festivals",festivals);
	    
	    return "festival/festivalSearch";
	}
	

}
