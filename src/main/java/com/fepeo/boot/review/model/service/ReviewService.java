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
	//이미지수정추가코드 있어 원래코드는 주석처리하고 다시 작성!
	//4/23 21:05
	//int reviewUpdate(ReviewUpdateRequest review) throws IllegalStateException, IOException;
	//4/24 14:22분 코드 다시 작성위해 아래 주석처리
	//int reviewUpdate(ReviewUpdateRequest review, List<MultipartFile> images) throws IllegalStateException, IOException;

	//리뷰검색 4/21 16:05
	List<Review> searchListByKeyword(Map<String, String> paramMap, int currentPage);


	//리뷰검색 2  4/21 18:54 
	int getTotalCount(Map<String, String> paramMap);

	//4/22 10:30 추가!detail에서 왔음!
	List<Review> selectReviewList();

	//4/24 15:01분 추가!
	int updateReview(ReviewUpdateRequest review, List<MultipartFile> images)throws IllegalStateException, IOException;

	//4/24 16:08분 다시 추가.....
	int reviewUpdate(ReviewUpdateRequest review) throws IllegalStateException, IOException;

	//어쩌다가 만듬....4/24 11:31분 이미지수정 코드작업중...
	//처음부터 작성위해 아래코드 주석처리!1
	//4/24 14:18
	//int reviewUpdate(ReviewUpdateRequest review) throws IllegalStateException, IOException;

}
