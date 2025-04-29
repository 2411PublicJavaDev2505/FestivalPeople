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
		
	//댓글서비스
	private final CommentService cService;
	private final FestivalService festivalService;
	private final ReviewService rService;
	
	private final ApiComponent api;
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
	// 수정 (4/24일 14:23분 코드 다시 작성해주는 작업시작!새로 작성위해 
	//주석처리함!!
	
	// 4/24 14:28분 수정하기 다시작성시작!!\
	
	@GetMapping("/update")
	public String showReviewUpdate(@RequestParam("reviewNo") int reviewNo
				,Model model) {
		//출력?
		Review review = rService.selectOneByNo(reviewNo);
		model.addAttribute("review",review); 
		return "review/update";
	}
	
	//수정!!
	
	@PostMapping("/update")
	public String updateReview(@ModelAttribute ReviewAddRequest review,
			@RequestParam(value="images",required=false) List<MultipartFile> images,
			//@RequestParam("reviewNo") int reviewNo,
			HttpSession session
			,Model model) throws IllegalStateException, IOException { //강제로 넣기!
			//아래 코드 주석하니 제목이랑 내용 다시 수정됨! 04/24 19:22
			//int result = rService.updateReview(review,images);
		
			//여기부분 추가해보고 안되면 원
			//Review review = rService.updateReview(review,images);
			
			//제목,내용만수정 ? 
			//04/24 19:47 아래 코드 수정할예정!수정전 주석처리해줌
			//int result = rService.reviewUpdate(review);
			//04-24 20:28 코드추가수정!
			int result = rService.reviewUpdate(review,images);
			
			System.out.println("확인");
			//추가코드
			//model.addAttribute("reviewNo",reviewNo);
			//int result = rService.reviewUpdate(review,images);
			
		return "redirect:/review/list";
		//return "redirect:/review/detail?reviewNo=" + result;
	}
	
//	
//	@GetMapping("/update")
//	public String showreviewUpdate(@RequestParam("reviewNo") int reviewNo
//			,Model model) {
//		Review review = rService.selectOneByNo(reviewNo);
//		model.addAttribute("review",review); 
//		return "review/update";
//	}
//	//수정 4/23 20:456분 아래 원래 파일!넣어줬음
//	//@RequestParam(value="images" , required=false) List<MultipartFile> images 
//	
//	@PostMapping("/update")
//	public String reviewUpdate(@ModelAttribute ReviewUpdateRequest review,
//			@RequestParam(value="images" , required=false) List<MultipartFile> images , 
//			@RequestParam("reviewNo") int reviewNo,
//			HttpSession session
//			,Model model ) throws IllegalStateException, IOException {
//		//4/23 21:03 아래 원래코드에서 추가함!주석처리!
//		//int result = rService.reviewUpdate(review);
//		//int result = rService.reviewUpdate(review,images);
//		model.addAttribute("reviewNo",reviewNo);
//		System.out.println("확인");
//		System.out.println(review);
//		//이미지 수정도되면 아래 주석풀어서 확인할것!
//		return "redirect:/review/detail?/reviewNo="+review.getReviewNo();
//		return "redirect:/review/list";
//	}
	
	//4/23 21:00 이미지파일 수정 코드작성!!
	//4/24 9~부터 작성인데 시작못함..
	//ReviewAddRequest review, 
	//images로 하는게 맞는거 같은데 몰라서 일단 notice꺼로 써보기!!안되면 
	//원복!!?? 오류창보고 그냥 버튼 눌러봄!! 그래서 아래코드 완성....
//	@PostMapping("/updatefile")
//	public String updateFile(
//			List<ImgAddRequest> imageList
//			) throws IllegalStateException, IOException {
//		//int reviewNo = review.getReviewNo();
//		String filePath = "";
//		if(imageList != null && !imageList.isEmpty()) {
//			//4/24:09:08분정도 어제하다만 코드작성다시시작!
//			//ImgAddRequest img = new ImgAddRequest();
//			//img.setReviewNo(reviewNo);
//			String fileName = ((MultipartFile) imageList).getOriginalFilename();
//			String fileRename = Util.fileRename(fileName);
//			filePath ="/images/review/"+fileRename;
//			((MultipartFile) imageList).transferTo(new File("C:/uploadImage/review/"+fileRename));
//		
//			}
//		return filePath;
//	}
	//다시 아래 작성 4/24 11:16 // 오전 코드 작성하고 insert처럼 코드 작성위해 아래 코드 주석처리!
	
//	@ResponseBody
//	@PostMapping("/updatefile")
//	public String updateFile(
//			//ImgAddRequest 에서 가져옴!!
//			MultipartFile imageFile
//			) throws IllegalStateException, IOException {
//		String filePath = "";
//		if(imageFile != null && !imageFile.isEmpty()) {
//			String fileName = imageFile.getOriginalFilename();
//			String fileRename = Util.fileRename(fileName);
//			filePath = "/images/review/"+fileRename;
//			imageFile.transferTo(new File("C:/uploadImage/review/"+fileRename));
//			
//			}
//			return filePath;
//	}
	
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
	
	//
	
	
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
	
	@ResponseBody
	@GetMapping("/comment/list")
	public List<ReviewComment> selectCommentList(int reviewNo) {
		return cService.selectCommentList(reviewNo);
	}
	
	//4/27 댓글 삭제 코드 작성!삭제 안됨...지울것!
	
	@ResponseBody
	@GetMapping("/comment/delete")
	public String commentDelete(@RequestParam("commentNo") int commentNo
			,Model model) {
		int result = cService.commentDelete(commentNo);
		return result+"";
	}
	
}


