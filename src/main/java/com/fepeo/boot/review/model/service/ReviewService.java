package com.fepeo.boot.review.model.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.review.controller.dto.ImgAddRequest;
import com.fepeo.boot.review.controller.dto.ReviewAddRequest;
import com.fepeo.boot.review.controller.dto.ReviewUpdateRequest;
import com.fepeo.boot.review.model.vo.Review;

public interface ReviewService {
	
	//리뷰등록(사진첨부파일(4/17 17:30) 20:51분체인지해줌!! 23:51분확인!!
	int insertReview(ReviewAddRequest review, List<MultipartFile> images) throws IllegalStateException, IOException;

	
	//여긴 detail만들때 메소드만들어줌!
	Review selectOneByNo(int reviewNo);
	
	
	//리뷰 전체 리스트(커렌트 4/17 09:13원복중!)
	List<Review> selectReviewList(int currentPage);
	
	//토탈카운트!4/17 10:21
	int getTotalCount();

	//4/18 16:20분 리뷰게시판 삭제
	int reviewDelete(int reviewNo);

	//리뷰 조회수 추가 4/19
	int reviewCount(int reviewNo);

	//후기 수정 1 ( 4/23일 강제 로 throws IllegalStateException, IOException 넣어줌!
	// 4/23 14:44분 아래 수정!
	//int reviewUpdate(ReviewUpdateRequest review) 원래코드!
	int reviewUpdate(ReviewUpdateRequest review) throws IllegalStateException, IOException;

	//리뷰검색 4/21 16:05
	List<Review> searchListByKeyword(Map<String, String> paramMap, int currentPage);


	//리뷰검색 2  4/21 18:54 
	int getTotalCount(Map<String, String> paramMap);

	//4/22 10:30 추가!detail에서 왔음!
	List<Review> selectReviewList();

}
