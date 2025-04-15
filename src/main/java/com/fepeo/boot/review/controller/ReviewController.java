package com.fepeo.boot.review.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.fepeo.boot.member.model.vo.Member;
import com.fepeo.boot.review.controller.dto.ReviewAddRequest;
import com.fepeo.boot.review.model.service.ReviewService;
import com.fepeo.boot.review.model.vo.Review;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
@RequestMapping("/review")
public class ReviewController {

   
	
	private final ReviewService rService;

    
	
	@GetMapping("/list")
	public String showReviewList(HttpSession session
			) {
//		session.setAttribute("member", member);
//		String member = (String)session.getAttribute("memberId",member);
//		System.out.println(member);

		return "review/list";
	}
	
	//후기등록
	
	@GetMapping("/insert")
	public String showReviewInsert(HttpSession session) {
		return "review/insert";
	}
	
	@PostMapping("/insert")
	public String insertReview(@ModelAttribute ReviewAddRequest review,
			MultipartFile uploadFile
			,HttpSession session
			,Model model) {
		//19:22 
		int result = rService.insertReview(review);
		return "redirect:/review/list";
	}
	
	//등록성공하고 여기부터 시작! Service 메소드만들고!
	
	@GetMapping("/{reviewNo}")
	public String reviewDetail(@PathVariable("reviewNo") int reviewNo
			,Model model) {
		Review review = rService.selectOneByNo(reviewNo);
		model.addAttribute("review",review);
		return"review/detail";
	}
}


