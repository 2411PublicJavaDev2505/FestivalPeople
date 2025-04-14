package com.fepeo.boot.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.fepeo.boot.common.controller.api.ApiComponent;

import lombok.RequiredArgsConstructor;

@Controller
public class CommonController {
	
	@GetMapping("/")
	public String showMain() {
		return "index";
	}
}
