package com.fepeo.boot.review.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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

import com.fepeo.boot.common.controller.api.ApiComponent;
import com.fepeo.boot.common.util.PageUtil;
import com.fepeo.boot.common.util.Util;
import com.fepeo.boot.festival.model.service.FestivalService;
import com.fepeo.boot.festival.model.vo.Festival;
import com.fepeo.boot.notice.model.service.logic.NoticeServiceLogic;
import com.fepeo.boot.review.controller.dto.CommentAddRequest;
import com.fepeo.boot.review.controller.dto.ImgAddRequest;
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
	
	private final CommentService cService;
	private final FestivalService festivalService;
	private final ReviewService rService;
	
	private final ApiComponent api;
	private final PageUtil pageUtil;


    //여행후기게시판리스트
	
	@GetMapping("/list")
	public String showReviewList(@RequestParam(value="page",defaultValue="1") int currentPage
			,HttpSession session
			,Model model) {
			List<Review> rList = rService.selectReviewList(currentPage);
			int totalCount = rService.getTotalCount();
			Map<String, Integer> pageInfo
			= pageUtil.generatePageInfo(totalCount, currentPage);
			model.addAttribute("maxPage", pageInfo.get("maxPage"));
			model.addAttribute("startNavi" ,pageInfo.get("startNavi"));
			model.addAttribute("endNavi", pageInfo.get("endNavi"));
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("pageInfo",pageInfo);
			model.addAttribute("rList",rList);
			
			String gWRegions = (String)session.getAttribute("gWRegions");
			if(gWRegions != null) {
				List<Festival> rfestivals = null;
				String[] strList = gWRegions.split(",");
				List<String> goodWeatherRegions = new ArrayList<>();
				goodWeatherRegions = Arrays.asList(strList);
				rfestivals = festivalService.selectFestivalListByWeather(goodWeatherRegions);
				int num1 = (int)(Math.random()*(rfestivals.size()-1));
				int num2 = (int)(Math.random()*(rfestivals.size()-1));
				while(num1 == num2) {
					num2 = (int)(Math.random()*(rfestivals.size()-1));
				}
				Festival festival1 = rfestivals.get(num1);
				Festival festival2 = rfestivals.get(num2);
				model.addAttribute("festival1",festival1);
				model.addAttribute("festival2",festival2);
			}else {
				model.addAttribute("festival1",null);
				model.addAttribute("festival2",null);
			}
	    	
			return "review/list";
}

	//게시판등록
	
	@GetMapping("/insert")
	public String showReviewInsert() {
		return "review/insert";
	}
	//후기등록 
	
	@PostMapping("/insert")
	public String insertReview(@ModelAttribute ReviewAddRequest review,
			@RequestParam(value="images",required=false) List<MultipartFile> images,
			HttpSession session
			,Model model) throws IllegalStateException, IOException {
		int result = rService.insertReview(review,images);
		return "redirect:/review/list";
	}
	//게시판상세
	
	@GetMapping("/detail")
	public String reviewDetail(@RequestParam("reviewNo") int reviewNo
			,Model model) {
		Review review = rService.selectOneByNo(reviewNo);
		int result = rService.reviewCount(reviewNo);
		model.addAttribute("review",review);
		model.addAttribute("reviewNo",reviewNo);
		List<Review> rList = rService.selectReviewList();
		model.addAttribute("rList",rList);
		return"review/detail";
	}
	//수정
	
	@GetMapping("/update")
	public String showReviewUpdate(@RequestParam("reviewNo") int reviewNo
				,Model model) {
		Review review = rService.selectOneByNo(reviewNo);
		model.addAttribute("review",review); 
		return "review/update";
	}
	
	//수정
	
	@PostMapping("/update")
	public String updateReview(@ModelAttribute ReviewAddRequest review,
			@RequestParam(value="images",required=false) List<MultipartFile> images,
			HttpSession session
			,Model model) throws IllegalStateException, IOException { 
			int result = rService.reviewUpdate(review,images);
			return "redirect:/review/list";
	}
	

	
	//게시글 삭제
	
	@GetMapping("/delete")
	public String reviewDelete(@RequestParam("reviewNo") int reviewNo
			,Model model) {
		int result = rService.reviewDelete(reviewNo);
		return "redirect:/review/list";
		
	}
	
	//검색 
	
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
			model.addAttribute("pageInfo",pageInfo);
			List<Review> rList = rService.selectReviewList(currentPage);
			model.addAttribute("rList",rList);
			return "review/search";
	}
	//댓글등록
	
	@ResponseBody
	@PostMapping("/comment/insert")
	public int insertComment(@RequestBody CommentAddRequest comment) {
		int result = cService.insertComment(comment);
		return result;
	}
	//댓글목록
	
	@ResponseBody
	@GetMapping("/comment/list")
	public List<ReviewComment> selectCommentList(int reviewNo) {
		return cService.selectCommentList(reviewNo);
	}
	
	//댓글삭제
	
	@ResponseBody
	@GetMapping("/comment/delete")
	public String commentDelete(@RequestParam("commentNo") int commentNo
			,Model model) {
		int result = cService.commentDelete(commentNo);
		return result+"";
	}
	
}


