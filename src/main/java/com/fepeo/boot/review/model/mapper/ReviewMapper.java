package com.fepeo.boot.review.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.fepeo.boot.review.controller.dto.ImgAddRequest;
import com.fepeo.boot.review.controller.dto.ReviewAddRequest;
import com.fepeo.boot.review.controller.dto.ReviewUpdateRequest;
import com.fepeo.boot.review.model.vo.Review;

@Mapper
public interface ReviewMapper {
	//리뷰등록
	int insertReview(ReviewAddRequest review);
	//상세
	Review selectOneByNo(int reviewNo);
	//게시판 리스트
	List<Review> selectReviewList(RowBounds rowBounds);
	//토탈카운트
	int getTotalCount();
	//이미지등록
	int insertReviewImageList(List<ImgAddRequest> imageList);
	int insertReviewFirstImage(ImgAddRequest img);
	int insertReviewSecondImage(ImgAddRequest img);
	int insertReviewThirdImage(ImgAddRequest img);
	int reviewDelete(int reviewNo);
	int reviewCount(int reviewNo);
	//검색
	List<Review> searchListByKeyword(RowBounds rowBounds, Map<String, String> paramMap);
	int getTotalCountBySearch(Map<String, String> paramMap);
	List<Review> selectReviewList();
	//이미지
	int updateReviewFirstImage(ImgAddRequest img);
	int updateReviewSecondImage(ImgAddRequest img);
	int updateReviewThirdImage(ImgAddRequest img);
	
	int reviewUpdate(ReviewUpdateRequest review);
	
	int reviewUpdate(ReviewAddRequest review);
	
	int selectMemberNoByReviewNo(int num);
	
	int selectMemberNoByCommentNo(int num);
	
	int getSearchTotalCount(Map<String, String> searchMap);
	
}
