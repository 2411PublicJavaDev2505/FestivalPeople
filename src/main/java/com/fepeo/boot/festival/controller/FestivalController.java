package com.fepeo.boot.festival.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fepeo.boot.common.controller.api.ApiComponent;
import com.fepeo.boot.common.util.GridConverter;
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
	    
	    if (member != null) {
	        // 로그인 사용자 처리
	        Member memberInfo = memberService.selectOneByNo(member.getMemberNo());
	        String memberAddress = memberInfo.getAddress();
	        Map<String, String> mapPoint = api.searchMemberAddress(memberAddress);
	        
	        List<Festival> fList = festivalService.selectFestivalListByRegion(goodWeatherRegions, mapPoint);
	        
	        if (fList != null && !fList.isEmpty()) {
	            model.addAttribute("fList", fList);
	        } else {
	            model.addAttribute("fList", null);
	        }

	    } else {
	        // 비회원 추천 리스트
	        rfestivals = festivalService.selectFestivalListByWeather(goodWeatherRegions);
	        model.addAttribute("rfestivals", rfestivals);
	    }

	    // 전체 리스트는 공통으로 출력
	    List<Festival> festivals = festivalService.selectFestivalList(pageInfo.get("startRow"), pageInfo.get("endRow"));

	    model.addAttribute("festivals", festivals);
	    model.addAttribute("maxPage", pageInfo.get("maxPage"));
	    model.addAttribute("startNavi", pageInfo.get("startNavi"));
	    model.addAttribute("endNavi", pageInfo.get("endNavi"));
	    model.addAttribute("currentPage", currentPage);

	    return "festival/list";

	}
	
	
	
	
	//상세페이지
	@GetMapping("/detail/{festivalNo}")
	public String showFestivalDetail(@PathVariable  int festivalNo, Model model) {
		Festival festival = festivalService.selectFestivalByNo(festivalNo);

	    // 위도 경도 가져오기
	    double lat = Double.parseDouble(festival.getMapHCode()); 
	    double lon = Double.parseDouble(festival.getMapVCode()); 
	    
//	    System.out.println("lat: " + festival.getMapVCode() + ", lon: " + festival.getMapHCode());

	    // 위경도 → 격자 좌표 변환
	    int[] grid = GridConverter.convertToGrid(lat, lon);
	    String nx = String.valueOf(grid[0]);
	    String ny = String.valueOf(grid[1]);

	    // 디버깅용 로그
//	    System.out.println("lat: " + lat + ", lon: " + lon);
//	    System.out.println("nx: " + nx + ", ny: " + ny);

	    // 날짜 및 시간 생성
	    Map<String, String> dateTimeMap = WeatherUtils.getWeatherBaseDateTime("0500");
	    String baseDate = dateTimeMap.get("baseDate");
	    String baseTime = dateTimeMap.get("baseTime");

	    // 날씨 API 호출 및 파싱
	    String json = api.callShortWeatherApi(baseDate, baseTime, nx, ny);
	    Map<String, Map<String, String>> threeDaySummary = api.parseThreeDayWeather(json);
//	    System.out.println(json);
	    //3일치 날씨 리스트 출력
	    List<String> next3Days = WeatherUtils.getNext3Days();
	    
	    // 데이터 전달
	    model.addAttribute("days", next3Days);
	    model.addAttribute("weatherSummary", threeDaySummary);
	    model.addAttribute("festival", festival);
	    return "festival/festivalDetail";
	}
	
	//축제 최신화
	@GetMapping("/insert")
	@ResponseBody
	public String insertFestivalList() {
		festivalService.insertFestivalList();
		return "success";
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
//		System.out.println(searchCondition);
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
