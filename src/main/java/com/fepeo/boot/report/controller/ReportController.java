package com.fepeo.boot.report.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.ui.Model;

import com.fepeo.boot.chat.model.service.ChatService;
import com.fepeo.boot.chat.model.vo.ChatRoom;
import com.fepeo.boot.common.util.PageUtil;
import com.fepeo.boot.member.model.service.MemberService;
import com.fepeo.boot.member.model.vo.Member;
import com.fepeo.boot.report.model.service.ReportService;
import com.fepeo.boot.report.model.vo.dto.ReportDTO;
import com.fepeo.boot.review.model.service.CommentService;
import com.fepeo.boot.review.model.service.ReviewService;
import com.fepeo.boot.review.model.vo.Review;
import com.fepeo.boot.review.model.vo.ReviewComment;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/report")
public class ReportController {
	
	private final MemberService memberService;
	private final ReportService reportService;
	private final ChatService chatService;
	private final ReviewService reviewService;
	private final CommentService commentService;
	
	@GetMapping("/insert")
	public String showReportInsert(HttpSession session, 
			Model model
			,@RequestParam("num") int num
			,@RequestParam("target") String target) {
		// 신고 대상 
		// chat = 채팅방, rev = 후기글, com = 댓글
		// num = 번호(채팅방, 후기글, 댓글)
		model.addAttribute("target", target);
		model.addAttribute("num", num);
		return"report/reportInsert";
	}
	
	@PostMapping("/insert")
	@ResponseBody
	public String insertReport(ReportDTO report, HttpSession session) {
		
		Member member = (Member)session.getAttribute("member");
		
		JSONObject json = new JSONObject();
		
		if(member == null) {
			json.put("check", 0);
			return json.toString();
		}else {
			report.setMemberNo(member.getMemberNo());
			int result = reportService.insertReport(report);
			int memberNo = 0;
			switch(report.getReportObject()) {
				case "chat" : 
					memberNo = chatService.selectMemberNoByNo(report.getNum());
					break;
				case "rev" : 
					memberNo = reviewService.selectMemberNoByReviewNo(report.getNum());
					break;
				case "com" : 
					memberNo = commentService.selectMemberNoByCommentNo(report.getNum());
					break;
			}
			result += memberService.updateReportCount(memberNo);
			
			
			json.put("check", result);
			return json.toString();
		}
	}

	
	
}
