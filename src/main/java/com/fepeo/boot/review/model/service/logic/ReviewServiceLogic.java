package com.fepeo.boot.review.model.service.logic;


import java.util.List;

import org.apache.ibatis.session.RowBounds;
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

	//원복중 다시 만듬(4/17:09:33)
	@Override
	public List<Review> selectReviewList() {
		List<Review> rList = mapper.selectReviewList();
		return rList;
	}
	
	//리뷰 전체 리스트(4/17)//리스트커렌트페이지00:20분시작
	//코드 수정할부분있음!!!!!!!!!!!****** 
	//return rList; List<Review> rList //int currentPage 서비스로 연결!거꾸로!!
	//아래코드 원복중 주석처리 4/17 09:32
//	@Override
//	public List<Review> selectReviewList(int currentPage) {
//		//int limit =10;
//		//int offset =(currentPage-1)*limit;
////		RowBounds rowBounds = new RowBounds(offset, limit); 
////		List<Review> review = mapper.selectReviewList();//2개도 출력가능하다!!
////		return review;(가로 안에 원래 스프링부트로쓰면 어떻게 써야함???? )
////		List<Review> rList = mapper.selectReviewList(null,rowBounds);
////		List<Review> rList = mapper.selectReviewList(currentPage);
//		int limit =10;
//		int offset =(currentPage-1)*limit;
//		RowBounds rowBounds = new RowBounds(offset, limit); 
//		List<Review> rList = mapper.selectReviewList(rowBounds);
//		return rList;
//		
//	}

//
//	@Override
//	public int getTotalCount() {
//		int totalCount = mapper.getTotalCount();
//		return totalCount;
//	}

}
