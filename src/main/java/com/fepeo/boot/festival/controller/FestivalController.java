package com.fepeo.boot.festival.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fepeo.boot.festival.model.service.FestivalService;
import com.fepeo.boot.festival.model.vo.Festival;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/festival")
public class FestivalController {
	
	private FestivalService festivalService;

	
	@GetMapping("/list")
	public String showFestivalList(Model model) {
		List<Festival> list = festivalService.getFestivalList();
		model.addAttribute("festivals", list);
	    return "festival/list";
	}
	
	@GetMapping("/detail")
	public String showFestivalDetail() {
		return "festival/festivalDetail";
	}
	

	@GetMapping("/insert")
	public String insertFestivalList(Model model) {
		festivalService.insertFestivalList();
		model.addAttribute("msg", "저장완료");
		return "festival/list";
		
	}


}
