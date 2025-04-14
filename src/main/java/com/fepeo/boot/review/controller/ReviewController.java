package com.fepeo.boot.review.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.fepeo.boot.member.model.vo.Member;
import com.fepeo.boot.review.controller.dto.ReviewAddRequest;
import com.fepeo.boot.review.model.service.ReviewService;

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
	
//	@GetMapping("/insert")
//	public String showReviewInsert(
//			//Model model
//			//,@ModelAttribute ReviewAddRequest review
//			//,MultipartFile images
//			//,@RequestParam("memberNo") int memberNo
//			//,HttpSession session) {
//			//System.out.println("확인2");
//			System.out.println(memberNo);
//			System.out.println(review);
//			
//			
//			//if(session.getAttribute("memberId") != null) {
//				//review.setMemberNo(memberNo);
//			}
//		
//		return "review/insert";
//	}

	
	//후기등록(여기부터 에러날수있으니 나면 지울것!)2시간15분부터 시작
	//MultipartFile~~은 코드확인후 수정!!19:43분 코드다듬기시작!
	
	@PostMapping("/insert")
	public String insertReview(@ModelAttribute ReviewAddRequest review,
			MultipartFile uploadFile
			,HttpSession session
			,Model model) {
		//19:22 
		int result = rService.insertReview(review);
		return "redirect:/review/list";
	}
	

	
	
		
		//postMapping부터 jsp까지 전체 수정!!
		//지금 쓴건 주석처리하 다시 작성!!밑에 images지우고 확인해볼것!
		//System.out.println(session.getAttribute("member"));
		//코드가 전혀 몰라 여기까지 입니다....예시코드?
		
//		Member member = (Member)session.getAttribute("member");
//		review.setReviewNo(review.getReviewNo());
//		review.setReviewTitle(review.getReviewTitle());
//		review.setReviewContent(review.getReviewContent());
//		review.setMemberNo(member.getMemberNo());
//		System.out.println("확인5");
//		int result = rService.insertReview(review);
//		System.out.println("확인6");
//		System.out.println(result);
//		return "redirect:/review/list";
		//18:37분 추가 코드작성!
		
		//아래는 그냥 막썼는데 원래 코드로 작성하기! 19:24분 주석처리!
//		try {
//			if(session.getAttribute("member") != null) {
//				Member member = (Member)session.getAttribute("member");
//				System.out.println(member);
////				review.setReviewNo(review.getReviewNo());
////				review.setReviewTitle(review.getReviewTitle());
////				review.setReviewContent(review.getReviewContent());
////				review.setMemberNo(member.getMemberNo());
//				System.out.println("확인!");
//			}else {
//				model.addAttribute("errorMsg","로그인이 필요합니다");
//			}
//			int result = rService.insertReview(review);
//			return "redirect:/review/list";
//		} catch (Exception e) {
//			// TODO: handle exception
//			model.addAttribute("errorMsg",e.getMessage());
//			return "common/error";
//		}
		
		
//		Member member = (Member)session.getAttribute("member");
//		review.setMemberNo(member.getMemberNo());
//		review.setReviewNo(review.getReviewNo());
//		review.setReviewTitle(review.getReviewTitle());
//		review.setReviewContent(review.getReviewContent());
//		System.out.println("확인5");
//		int result = rService.insertReview(review);
//		System.out.println("확인5");
//		System.out.println(result);
//		return "redirect:/review/list";

	//일단 지움!!주석처리!
//	@PostMapping("/insert")
//	public String insertReview(@ModelAttribute ReviewAddRequest review,
//			HttpSession session
//			,Model model) {
//		//postMapping부터 jsp까지 전체 수정!!
//		//지금 쓴건 주석처리하 다시 작성!!
//		try {
////			if(session.getAttribute("memberId") != null) {
////				String memberNo = session.getAttribute("memberId") != null
////						?(String)session.getAttribute("memberId");
//			}else {
//				model.addAttribute("errorMsg","로그인이 필요합니다");
//				return "common/error";
//			}
//			int result = rService.insertReview(review);
//			//System.out.println(result);
//			return "redirect:/review/list";
//			
//		} catch (Exception e) {
//			// TODO: handle exception
//			model.addAttribute("errorMsg",e.getMessage());
//			return "common/error";
//		}
		
//	}// * 여기부분작성전 옮겨둠
	//Member member = (Member)session.getAttribute("member");
//	review.setMemberNo(member.getMemberNo());
//	review.setReviewNo(review.getReviewNo());
//	review.setReviewTitle(review.getReviewTitle());
//	review.setReviewContent(review.getReviewContent());
//	System.out.println("확인5");
//	int result = rService.insertReview(review);
//	System.out.println("확인5");
//	System.out.println(result);
//	return "redirect:/review/list";
	
	//try {
//	if(session.getAttribute("member") != null) {
//		Member member = (Member)session.getAttribute("member");
//		review.setReviewNo(review.getReviewNo());
//		review.setReviewTitle(review.getReviewTitle());
//		review.setReviewContent(review.getReviewContent());
//		review.setMemberNo(member.getMemberNo());
//	}else {
//		model.addAttribute("error", "로그인이 필요합니다");
//		return "common/error";
//	}
//	int result = rService.insertReview(review);
//	System.out.println("확인7");
//	return "redirect:/review/list";
//} catch (Exception e) {
//	model.addAttribute("errorMsg", e.getMessage());
//	return "common/error";
}


