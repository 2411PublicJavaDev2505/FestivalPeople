package com.fepeo.boot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/intro")
public class introController {

	@GetMapping("/intro")
	public String showIntro() {
		return "intro/intro";
	}
}
