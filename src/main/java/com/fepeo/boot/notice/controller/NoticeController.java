package com.fepeo.boot.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@GetMapping("/list")
	public String showNoticeList(HttpSession session
			) {
		return "notice/list";
	}
	
}
