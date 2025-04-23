package com.fepeo.boot.common.controller;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

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
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CommonController {
	
	private final FestivalService festivalService;
	private final CourseService courseService;
	private final ApiComponent api;

	@GetMapping("/")
	public String showMain(Model model)
		throws JsonMappingException, JsonProcessingException {
			// 현재 날짜 기준으로 어제 날짜 포맷 설정

		
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.DATE, -1);
			
			
			String nowTime = new SimpleDateFormat("yyyyMMdd").format(calendar.getTime()) + "1800";
			
		
			//전체 리스트 출력시 페이지 네이션 코드 
		    List<Festival> rfestivals = null;
		    List<RegionDto> regionList = courseService.getAllRegions();
		    List<String> goodWeatherRegions = api.callWeatherApi(regionList);
			rfestivals = festivalService.selectFestivalListByWeather(goodWeatherRegions); // 비회원일때 불러오는 리스트 
			model.addAttribute("rfestivals", rfestivals);
		    return "index";
		}

}
