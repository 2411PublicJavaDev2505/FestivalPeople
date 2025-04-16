package com.fepeo.boot.festival.controller;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fepeo.boot.common.util.PageUtil;
import com.fepeo.boot.festival.model.service.FestivalService;
import com.fepeo.boot.festival.model.vo.Festival;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/festival")
public class FestivalController {
	
	private final FestivalService festivalService;
	private final PageUtil pageUtil;

	
	@GetMapping("/list")
	public String showFestivalList(
	    @RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
	    Model model
	) {
	    int totalCount = festivalService.getTotalCount();
	    int itemsPerPage = 8;

	    Map<String, Integer> pageInfo = pageUtil.generatePageInfo(totalCount, currentPage, itemsPerPage);
	    List<Festival> festivals = festivalService.getFestivalList(pageInfo.get("startRow"), pageInfo.get("endRow"));
	    model.addAttribute("maxPage", pageInfo.get("maxPage"));
	    model.addAttribute("startNavi", pageInfo.get("startNavi"));
	    model.addAttribute("endNavi", pageInfo.get("endNavi"));
	    model.addAttribute("currentPage", currentPage);
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
