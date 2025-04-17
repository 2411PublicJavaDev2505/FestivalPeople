package com.fepeo.boot.review.model.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.review.controller.dto.ReviewAddRequest;
import com.fepeo.boot.review.model.vo.Review;

public interface ReviewService {
	//리뷰등록2번째
	int insertReview(ReviewAddRequest review);
	//리뷰등록!! (에러나면 지울것!!)//다시작성하기!!
//	int insertReview(ReviewAddRequest review, MultipartFile images);
//	int insertReview(ReviewAddRequest review, MultipartFile images);
	
	//여긴 detail만들때 메소드만들어줌!
	Review selectOneByNo(int reviewNo);
	
	
	//리뷰 전체 리스트(커렌트 4/17 09:13원복중!)
	//List<Review> selectReviewList(int currentPage);
	//토탈카운드
	//int getTotalCount();

	List<Review> selectReviewList();

	


}
