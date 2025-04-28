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
	//리뷰등록!!//
	int insertReview(ReviewAddRequest review);
	//detail꺼!
	Review selectOneByNo(int reviewNo);
	
	//게시판 리스트
	List<Review> selectReviewList(RowBounds rowBounds);
	//토탈카운트 4/17 10:24추가
	int getTotalCount();
	//이미지등록 ( 4/18 00:46) 아래 4개 이미지 detail 꺼!!
	int insertReviewImageList(List<ImgAddRequest> imageList);
	int insertReviewFirstImage(ImgAddRequest img);
	int insertReviewSecondImage(ImgAddRequest img);
	int insertReviewThirdImage(ImgAddRequest img);
	//4/18 16:23분 리뷰게시판 삭제!
	int reviewDelete(int reviewNo);
	
	//리뷰 조회수 추가 4/19
	int reviewCount(int reviewNo);
	
	//검색!4/21 16:12 // 4/26 일 코드수정해야해서 원래 코드는 주석 안되면 다시 원복하기!
	List<Review> searchListByKeyword(RowBounds rowBounds, Map<String, String> paramMap);
	//List<Review> searchListByKeyword(RowBounds rowBounds, Map<String, String> paramMap,int reviewNo );
	//검색 2 카운트 (추가할거 있음 할것!)(아래는 지워야하나??)
	int getTotalCountBySearch(Map<String, String> paramMap);
	//4/22 10:32분 추가 안되면 지울것!!
	List<Review> selectReviewList();
	
	
	//04/24 20:48 분 아래 1개 코드 추가...소용없어 다시 주석
	//int insertReviewImageList1(List<ImgAddRequest> imageList);
	int updateReviewFirstImage(ImgAddRequest img);
	int updateReviewSecondImage(ImgAddRequest img);
	int updateReviewThirdImage(ImgAddRequest img);
	//내용제목만수정 4/24 16:10추가!
	int reviewUpdate(ReviewUpdateRequest review);
	int reviewUpdate(ReviewAddRequest review);
	
	int selectMemberNoByReviewNo(int num);
	int selectMemberNoByCommentNo(int num);
	
	
	
	
	
	//리뷰 수정1(제목 내용만) 4/23일 21:16
	//이미지 파일 수정 코드 추가하면서 여기는 안건드림...
	//추가할거있다면 여기 추가하기!???
	//4/24 14:19분 코드작성 다시 하기위해 코드 주석처리!
	//int reviewUpdate(ReviewUpdateRequest review);
	
}
