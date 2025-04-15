package com.fepeo.boot.festival.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fepeo.boot.festival.model.service.FestivalService;
import com.fepeo.boot.festival.model.vo.Festival;
import com.fepeo.boot.festival.model.vo.dto.FestivalItem;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/festival")
public class FestivalController {
	
    private final FestivalService festivalService;

	
	@GetMapping("/list")
	public String showFestivalList(Model model) {
		List<Festival> festivals = festivalService.getFestivalList();
	    model.addAttribute("festivals", festivals);  
	    return "festival/list";
	}
	
	@GetMapping("/detail/{festivalNo}")
	public String showFestivalDetail(@PathVariable  int festivalNo, Model model) {
		Festival festival = festivalService.getFestivalByNo(festivalNo);
		model.addAttribute("festival",festival);
		return "festival/festivalDetail";
	}
	
	@GetMapping("/insert")
	public String insertFestivalList(Model model) {
		festivalService.insertFestivalList();
		model.addAttribute("msg", "저장완료");
		return "festival/list";
		
	}
	
}
