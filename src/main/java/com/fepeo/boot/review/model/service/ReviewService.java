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
	
	//리뷰등록
	int insertReview(ReviewAddRequest review, List<MultipartFile> images) throws IllegalStateException, IOException;
	//상세
	Review selectOneByNo(int reviewNo);
	//리뷰 전체 리스트
	List<Review> selectReviewList(int currentPage);
	//토탈카운트
	int getTotalCount();
	//리뷰게시판 삭제
	int reviewDelete(int reviewNo);
	//리뷰
	int reviewCount(int reviewNo);
	//리뷰검색
	List<Review> searchListByKeyword(Map<String, String> paramMap, int currentPage);
	//리뷰검색2 
	int getTotalCount(Map<String, String> paramMap);
	//상세에서
	List<Review> selectReviewList();
	//수정
	int reviewUpdate(ReviewAddRequest review, List<MultipartFile> images) throws IllegalStateException, IOException;

	int selectMemberNoByReviewNo(int num);

}
