package com.fepeo.boot.common.controller;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fepeo.boot.common.controller.api.ApiComponent;
import com.fepeo.boot.course.model.service.CourseService;
import com.fepeo.boot.course.model.vo.dto.RegionDto;
import com.fepeo.boot.festival.model.service.FestivalService;
import com.fepeo.boot.festival.model.vo.Festival;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CommonController {
	
	private final FestivalService festivalService;
	private final CourseService courseService;
	private final ApiComponent api;

	@GetMapping("/")
	public String showMain(Model model, HttpSession session)
		throws JsonMappingException, JsonProcessingException {
		// 현재 날짜 기준으로 어제 날짜 포맷 설정
		
		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DATE, -1);
		
		
		String nowTime = new SimpleDateFormat("yyyyMMdd").format(calendar.getTime()) + "1800";
		
	
		//전체 리스트 출력시 페이지 네이션 코드 
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
	    
		rfestivals = festivalService.selectFestivalListByWeather(goodWeatherRegions); // 비회원일때 불러오는 리스트 
		model.addAttribute("rfestivals", rfestivals);
	    return "index";
	}

}
