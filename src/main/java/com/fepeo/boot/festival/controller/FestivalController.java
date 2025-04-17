package com.fepeo.boot.festival.controller;

import java.util.HashMap;
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

import jakarta.servlet.http.HttpSession;
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
	    List<Festival> rfestivals =festivalService.selectFestivalListById();
	    List<Festival> festivals = festivalService.selectFestivalList(pageInfo.get("startRow"), pageInfo.get("endRow"));
	    model.addAttribute("maxPage", pageInfo.get("maxPage"));
	    model.addAttribute("startNavi", pageInfo.get("startNavi"));
	    model.addAttribute("endNavi", pageInfo.get("endNavi"));
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("festivals", festivals);
	    model.addAttribute("rfestivals",rfestivals);

	    return "festival/list";
	}
	
	@GetMapping("/detail/{festivalNo}")
	public String showFestivalDetail(@PathVariable  int festivalNo, Model model) {
		Festival festival = festivalService.selectFestivalByNo(festivalNo);
		System.out.println("mapVCode: " + festival.getMapVCode());
		System.out.println("mapHcode: " + festival.getMapHcode());
		model.addAttribute("festival",festival);
		return "festival/festivalDetail";
	}
	

	@GetMapping("/insert")
	public String insertFestivalList(Model model) {
		festivalService.insertFestivalList();
		model.addAttribute("msg", "저장완료");
		return "festival/list";
	}
	
	@GetMapping("/search")
	public String searchFestivalList(HttpSession session
			,Model model
			,@RequestParam("searchCondition") String searchCondition
			,@RequestParam("searchKeyword") String searchKeyword
			,@RequestParam(value = "currentPage", defaultValue = "1") int currentPage){
		
		Map<String, String> searchMap = new HashMap <String, String>();
		searchMap.put("searchKeyword", searchKeyword);
		searchMap.put("searchCondition", searchCondition);
		System.out.println(searchKeyword);
		int totalCount = festivalService.getTotalCount();
	    int itemsPerPage = 8;
	    Map<String, Integer> pageInfo = pageUtil.generatePageInfo(totalCount, currentPage, itemsPerPage);
	    List<Festival> festivals = festivalService.searchFestivalListAll(pageInfo.get("startRow"), pageInfo.get("endRow"),searchMap);
	    System.out.println("검색된 축제 수 : " + festivals.size());
	    for (Festival f : festivals) {
	        System.out.println("축제명: " + f.getFestivalName());
	    }
	    model.addAttribute("maxPage", pageInfo.get("maxPage"));
	    model.addAttribute("startNavi", pageInfo.get("startNavi"));
	    model.addAttribute("endNavi", pageInfo.get("endNavi"));
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("festivals",festivals);
	    
	    return "/festivalSearch";
	}
	

}
