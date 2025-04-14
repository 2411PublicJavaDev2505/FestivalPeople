package com.fepeo.boot.review.model.service;

import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.review.controller.dto.ReviewAddRequest;

public interface ReviewService {
	//리뷰등록2번째
	int insertReview(ReviewAddRequest review);
	//리뷰등록!! (에러나면 지울것!!)//다시작성하기!!
//	int insertReview(ReviewAddRequest review, MultipartFile images);
//	int insertReview(ReviewAddRequest review, MultipartFile images);


}
