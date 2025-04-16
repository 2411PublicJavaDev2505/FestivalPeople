package com.fepeo.boot.review.model.service.logic;


import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.review.controller.dto.ReviewAddRequest;
import com.fepeo.boot.review.model.mapper.ReviewMapper;
import com.fepeo.boot.review.model.service.ReviewService;
import com.fepeo.boot.review.model.vo.Review;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewServiceLogic implements ReviewService {
	
	//아래것도 적는게 맞는지 확인필요!
	//private final SqlSession session;
	
	private final ReviewMapper mapper;
	
	//insertReview(ReviewAddRequest review,MultipartFile images) 원래코드
	// 수정코드!
	@Override
	public int insertReview(ReviewAddRequest review) {
		//성공후 아래코드 작성..작성전 mapper.xml에 코드 수정했으나 제약조건 뜸..
		//코드 수정아래 적어줌...에러나면 지울것!15:10
		int result = mapper.insertReview(review);
			if(result > 0) {
			result = review.getReviewNo();
		}
		return result;
//		return mapper.insertReview(review); 원래코드!!
	}
	
	
	//detail
	@Override
	public Review selectOneByNo(int reviewNo) {
		Review review = mapper.selectOneByNo(reviewNo);
		return review;
	}

}
