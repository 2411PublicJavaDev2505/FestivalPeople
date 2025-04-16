package com.fepeo.boot.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.notice.controller.dto.NoticeAddRequest;
import com.fepeo.boot.notice.model.service.NoticeService;
import com.fepeo.boot.review.model.service.CommentService;
import com.fepeo.boot.review.model.service.ReviewService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/notice")
public class NoticeController {
	
	private final NoticeService nService;

	@GetMapping("/list")
	public String showNoticeList(HttpSession session
			) {
		return "notice/list";
	}
	
	@GetMapping("/insert")
	public String showNoticeInsert(HttpSession session
			) {
		return "notice/insert";
	}
	
	@PostMapping("/insert")
	public String insertNotice(@ModelAttribute NoticeAddRequest notice,
			MultipartFile uploadFile,
			HttpSession session,
			Model model) {

		int result = nService.insertNotice(notice);
		
		return "redirect:/notice/list";
	}
	
}
