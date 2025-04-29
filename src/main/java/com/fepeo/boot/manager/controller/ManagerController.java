package com.fepeo.boot.manager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fepeo.boot.chat.model.service.ChatService;
import com.fepeo.boot.chat.model.vo.ChatRoom;
import com.fepeo.boot.common.util.PageUtil;
import com.fepeo.boot.manager.controller.dto.MemberDeleteRequest;
import com.fepeo.boot.manager.controller.dto.ReportAcceptRequest;
import com.fepeo.boot.manager.model.service.ManagerService;
import com.fepeo.boot.member.model.service.MemberService;
import com.fepeo.boot.member.model.vo.Member;
import com.fepeo.boot.report.model.service.ReportService;
import com.fepeo.boot.report.model.vo.Report;
import com.fepeo.boot.review.model.service.CommentService;
import com.fepeo.boot.review.model.service.ReviewService;
import com.fepeo.boot.review.model.vo.Review;
import com.fepeo.boot.review.model.vo.ReviewComment;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/manager")
public class ManagerController {
	

	private final MemberService mService;
	private final ReportService rService;
	private final ChatService cService;
	private final ReviewService reService;
	private final CommentService coService;
	private final PageUtil pageutil;
	
	@GetMapping("/rSearch")
	public String searchReportList(HttpSession session
			,Model model
			,@RequestParam("searchCondition") String searchCondition
			,@RequestParam("searchKeyword") String  searchKeyword
			,@RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		
		Map<String, String> searchMap = new HashMap<String, String>();
		
		searchMap.put("searchKeyword", searchKeyword);
		searchMap.put("searchCondition", searchCondition);
		
		
		
		
		
		return "";
	}
	
	
	// 회원 검색 기능
	@GetMapping("/search")
	public String searchMemberList(HttpSession session
			,Model model
			,@RequestParam("searchCondition") String searchCondition
			,@RequestParam("searchKeyword") String searchKeyword
			,@RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		// 검색조건 가져오기(값 확인했음)
		Map<String, String> searchMap = new HashMap<String, String>();
		
		// 검색값 넣어주고
		searchMap.put("searchKeyword", searchKeyword);
		searchMap.put("searchCondition", searchCondition);
		
		// 검색 수 가져오고
		int totalCount = mService.getSearchTotalCount(searchMap);
		Map<String, Integer> pageInfo = pageutil.generatePageInfo(totalCount, currentPage);
		List<Member> mList = mService.searchMemberList(searchMap, currentPage);
		
		if(mList.size() > 0) {
			model.addAttribute("mList",mList);
			model.addAttribute("currentPage",currentPage);
			model.addAttribute("pageInfo", pageInfo);
			return "manager/memberList";
		}else {
			return "common/error";
		}						
	}
	
	@GetMapping("/mypage")
	public String showMemberList(HttpSession session, 
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			Model model) {
		
		Member member = (Member)session.getAttribute("member");
		if(member.getManagerYn().equals("Y")) {

			int totalCount = mService.getMemberTotalCount();
			
			Map<String, Integer> pageInfo = pageutil.generatePageInfo(totalCount, currentPage);
			
			List<Member> mList = mService.selectMemberList(currentPage);
			model.addAttribute("mList", mList);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("pageInfo", pageInfo);
			int maxPage = 0;
			pageInfo.get(maxPage);
			
			
			
			session.setAttribute("mList", mList);
			return "manager/memberList";
			
		}else if(member.getManagerYn().equals("N")) {
			return "common/error";
		} else {
			return "common/error";
		}
	}
	
	@GetMapping("/report")
	public String showReportList(HttpSession session,
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			Model model) {
		
		
		int totalCount = rService.getTotalCount();
		//System.out.println(totalCount);
		Map<String, Integer> pageInfo = pageutil.generatePageInfo(totalCount, currentPage);
		//System.out.println(pageInfo);
		List<Report> rList = rService.selectReportList(currentPage);
		
		model.addAttribute("rList", rList);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("pageInfo", pageInfo);
		
		return "manager/reportList";
	}
	
	@GetMapping("/rdetail")
	public String showReportDetail(@RequestParam("reportNo") int reportNo
			,Model model) {
		Report report = rService.selectOneByNo(reportNo);
		
		int chatRoomNo = report.getChatRoomNo();
		int commentNo = report.getCommentNo();
		int reviewNo = report.getReviewNo();
		
		int memberNo = report.getMemberNo();
		Member member = mService.selectOneByNo(memberNo);
		model.addAttribute("member",member);
		
		if(chatRoomNo > 0) {
			ChatRoom cRoom = cService.selectChatRoomByNo(chatRoomNo);
			model.addAttribute("report",report);
			model.addAttribute("cRoom",cRoom);
			return "manager/reportDetail";
		}else if(commentNo > 0) {
			ReviewComment comment = coService.selectOneByNo(commentNo);
			model.addAttribute("report",report);
			model.addAttribute("comment",comment);
			return "manager/reportDetail";
		}else if(reviewNo > 0) {
			Review review = reService.selectOneByNo(reviewNo);
			model.addAttribute("report",report);
			model.addAttribute("review",review);
			return "manager/reportDetail";
		}else {
			return "common/error";
		}
	}
	
	
	@ResponseBody
	@PostMapping("delmem")
	public String deleteMember(MemberDeleteRequest member) {
		int result = 0;
		switch(member.getSocialYn()) {
			case "Y": 
				result = mService.deleteSocialMember(member.getMemberNo());
				break;
			case "N": 
				result = mService.deleteMember(member.getMemberNo());
				break;
		}
		return result+"";
	}
	

	
	@ResponseBody
	@GetMapping("/delre")
	public String deleteReport(@RequestParam("reportNo") int reportNo) {
		
		int result = 0;
		Report report = rService.selectOneByNo(reportNo);
		int memberNo = 0;
		switch(report.getReportObject()) {
			case "CHATROOM" : 
				memberNo = cService.selectMemberNoByNo(report.getChatRoomNo());
				break;
			case "REPORT" : 
				memberNo = reService.selectMemberNoByReviewNo(report.getReviewNo());
				break;
			case "REPORT_COMMENT" : 
				memberNo = coService.selectMemberNoByCommentNo(report.getCommentNo());
				break;
		}
		result += mService.substractReportCount(memberNo);
		result += rService.deleteReport(reportNo);
		
		return result + "";
	}
	
	@ResponseBody
	@PostMapping("/accept")
	public String acceptReport(@ModelAttribute ReportAcceptRequest reportAccept) {
		int result = 0;
		
		switch(reportAccept.getReportObject()) {
			case "CHATROOM" :
				result = cService.deleteCahtRoom(reportAccept.getChatRoomNo());
				break;
			case "REPORT" : 
				result = reService.reviewDelete(reportAccept.getReviewNo());
				break;
			case "REPORT_COMMENT" :
				result = coService.commentDelete(reportAccept.getCommentNo());
				break;
		}
		
		Report report = rService.selectOneByNo(reportAccept.getReportNo());
		switch(report.getReportObject()) {
		case "CHATROOM" :
			result += rService.deleteChatroomReport(report.getChatRoomNo());
			break;
		case "REPORT" : 
			result += rService.deleteReviewReport(report.getReviewNo());
			break;
		case "REPORT_COMMENT" :
			result += rService.deleteCommentReport(report.getCommentNo());
			break;
		}
		
		return result + "";
	}
	
}
