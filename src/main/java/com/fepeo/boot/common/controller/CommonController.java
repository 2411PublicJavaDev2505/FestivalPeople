package com.fepeo.boot.common.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.fepeo.boot.festival.model.service.FestivalService;
import com.fepeo.boot.festival.model.vo.Festival;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CommonController {
	
	private final FestivalService festivalService;
	
	@GetMapping("/")
	public String showMain(Model model) {
	    List<Festival> rfestivals =festivalService.getrFestivalList();
	    
	    model.addAttribute("rfestivals",rfestivals);
		
	    return "index";
	}
}
