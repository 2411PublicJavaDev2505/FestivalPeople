package com.fepeo.boot.festival.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fepeo.boot.festival.model.service.FestivalService;
import com.fepeo.boot.festival.model.vo.dto.FestivalItem;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/festival")
public class FestivalController {
	
    private final FestivalService festivalService;

    public FestivalController(FestivalService festivalService) {
        this.festivalService = festivalService;
    }
	
	@GetMapping("/list")
	public String showFestivalList() {
		return "festival/list";
	}
	
	@GetMapping("/detail")
	public String showFestivalDetail() {
		return "festival/festivalDetail";
	}
	
	@GetMapping("/api")
    public ResponseEntity<List<FestivalItem>> getFestivals() {
        return ResponseEntity.ok(festivalService.getFestivalList());
    }
}
