package com.fepeo.boot.review.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.common.util.PageUtil;
import com.fepeo.boot.notice.model.service.logic.NoticeServiceLogic;
import com.fepeo.boot.review.controller.dto.CommentAddRequest;
import com.fepeo.boot.review.controller.dto.ReviewAddRequest;
import com.fepeo.boot.review.controller.dto.ReviewUpdateRequest;
import com.fepeo.boot.review.model.service.CommentService;
import com.fepeo.boot.review.model.service.ReviewService;
import com.fepeo.boot.review.model.vo.Review;
import com.fepeo.boot.review.model.vo.ReviewComment;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
@RequestMapping("/review")
public class ReviewController {

    private final NoticeServiceLogic noticeServiceLogic;

   
	//댓글서비스
	private final CommentService cService;
	
	private final ReviewService rService;
	
	
	private final PageUtil pageUtil;


    //후기 게시판 페이지시작
	
	@GetMapping("/list")
	public String showReviewList(@RequestParam(value="page",defaultValue="1") int currentPage
			,HttpSession session
			,Model model) {
			//캐치 해줘야한다?
			List<Review> rList = rService.selectReviewList(currentPage);
			int totalCount = rService.getTotalCount();
			Map<String, Integer> pageInfo
			= pageUtil.generatePageInfo(totalCount, currentPage);
			model.addAttribute("maxPage", pageInfo.get("maxPage"));
			model.addAttribute("startNavi" ,pageInfo.get("startNavi"));
			model.addAttribute("endNavi", pageInfo.get("endNavi"));
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("rList",rList);
			return "review/list";
}

	//게시판등록
	
	@GetMapping("/insert")
	public String showReviewInsert() {
		return "review/insert";
	}
	//후기등록 이미지파일 시작하며 코드 추가!코드확인!!23:13
	
	@PostMapping("/insert")
	public String insertReview(@ModelAttribute ReviewAddRequest review,
			@RequestParam(value="images",required=false) List<MultipartFile> images,
			HttpSession session
			,Model model) throws IllegalStateException, IOException {
		//4/17 21:47
		int result = rService.insertReview(review,images);
		return "redirect:/review/list";
		//return "redirect:/review/detail?reviewNo=" + result;
	}
	//게시판상세
	
	@GetMapping("/detail")
	public String reviewDetail(@RequestParam("reviewNo") int reviewNo
			,Model model) {
		Review review = rService.selectOneByNo(reviewNo);
		//4/19 조회수 추가 코드 작성 !!했으나 안됨...확인필요!되는거 확인! dto?에 추가!
		int result = rService.reviewCount(reviewNo);
		model.addAttribute("review",review);
		//4/19추가해도 삭제 안됨
		model.addAttribute("reviewNo",reviewNo);
		//4/22 12:28분 추가 2개 추가 ! 안되면 다시 원복하기!!
		List<Review> rList = rService.selectReviewList();
		model.addAttribute("rList",rList);
		return"review/detail";
	}
	// 수정
	
	@GetMapping("/update")
	public String showreviewUpdate(@RequestParam("reviewNo") int reviewNo
			,Model model) {
		Review review = rService.selectOneByNo(reviewNo);
		model.addAttribute("review",review); 
		return "review/update";
	}
	//수정
	
	@PostMapping("/update")
	public String reviewUpdate(@ModelAttribute ReviewUpdateRequest review,
			@RequestParam("reviewNo") int reviewNo,
			HttpSession session
			,Model model ) throws IllegalStateException, IOException {
		int result = rService.reviewUpdate(review);
		model.addAttribute("reviewNo",reviewNo);
		System.out.println("확인");
		System.out.println(review);
//		return "redirect:/review/detail?/reviewNo="+review.getReviewNo();
		return "redirect:/review/list";
	}
	
	//게시글 삭제
	
	@GetMapping("/delete")
	public String reviewDelete(@RequestParam("reviewNo") int reviewNo
			,Model model) {
		
		int result = rService.reviewDelete(reviewNo);
		//System.out.println(reviewNo);
		return "redirect:/review/list";
		
	}
	
	//검색 4/21 15:21
	
	@GetMapping("/search")
	public String showSearchList(
			@RequestParam("searchCondition") String searchCondition
			,@RequestParam("searchKeyword") String searchKeyword
			,@RequestParam(value="page", defaultValue="1") int currentPage
			,Model model) {
			Map<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("searchCondition", searchCondition);
			paramMap.put("searchKeyword", searchKeyword);
			List<Review> searchList = rService.searchListByKeyword(paramMap,currentPage);
			int totalCount = rService.getTotalCount(paramMap);
			Map<String, Integer> pageInfo = pageUtil.generatePageInfo(totalCount, currentPage);
			System.out.println(searchList);
			model.addAttribute("maxPage",pageInfo.get("maxPage"));
			model.addAttribute("startNavi",pageInfo.get("startNavi"));
			model.addAttribute("endNavi",pageInfo.get("endNavi"));
			model.addAttribute("seachList", searchList);
			model.addAttribute("searchCondition",searchCondition);
			model.addAttribute("searchKeyword",searchKeyword);
			//4/22 11:27분 추가! 에러나면 지울것!!
			List<Review> rList = rService.selectReviewList(currentPage);
			model.addAttribute("rList",rList);
			return "review/search";
	}
	
	
	//댓글 등록 !!4/15 시작!!
	
	@ResponseBody
	@PostMapping("/comment/insert")
	public int insertComment(@RequestBody CommentAddRequest comment) {
		//아래확인하고 지울것!!
		System.out.println(comment);
		int result = cService.insertComment(comment);
		//아래것도 정리할때 지울것!
		System.out.println(result);
		return result;
	}
	
	//등록해주고 작성!4/16 오전 9:24분작성시작 
	
	@GetMapping("/comment/list")
	public List<ReviewComment> selectCommentList(int reviewNo) {
		return cService.selectCommentList(reviewNo);
	}
	
}


