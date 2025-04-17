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
	
	//아래것도 적는게 맞는지 확인필요!지워줄것!!!
	//private final SqlSession session;
	
	private final ReviewMapper mapper;
	
	//파일업로드 추가 4/17 17:23~!
	private String webPath ="/images/review/";
	private String folderPath = "C:/uploadImage/review/";
	
	//insertReview(ReviewAddRequest review,MultipartFile images) 원래코드
	// 수정코드! 파일업로드파일 코드작성 4/17 17:25분!!코드 수정하고 추가해줌!!
//	@Override
//	public int insertReview(ReviewAddRequest review, MultipartFile images) {
//		int result = mapper.insertReview(review);
//			if(result == 0) return 0; 
//			
//			int reviewNo = 
//			//result = review.getReviewNo();
//		}
//		return result;
//		return mapper.insertReview(review); 원래코드!!
//	}
	
	
	//detail
	@Override
	public Review selectOneByNo(int reviewNo) {
		Review review = mapper.selectOneByNo(reviewNo);
		return review;
	}

	//원복중 다시 만듬(4/17:09:33)등록확인후 주석처리!정리되면 지울것!!
//	@Override
//	public List<Review> selectReviewList() {
//		List<Review> rList = mapper.selectReviewList();
//		return rList;
//	}
	
	//원복하고 4/17 10:02분 여기부터시작!
	
	@Override
	public List<Review> selectReviewList(int currentPage) {
		int limit =10;
		int offset =(currentPage-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit); 
		List<Review> rList = mapper.selectReviewList(rowBounds);
		return rList;

//		int limit =10;
//		int offset =(currentPage-1)*limit;
//		RowBounds rowBounds = new RowBounds(offset, limit); 
//		List<Review> rList = mapper.selectReviewList(rowBounds);
//		return rList;
		
	}

	//토탈카운트!!
	@Override
	public int getTotalCount() {
		int totalCount = mapper.getTotalCount();
		return totalCount;
	}

	@Override
	public int insertReview(ReviewAddRequest review, MultipartFile images) {
		// TODO Auto-generated method stub
		return 0;
	}



}
