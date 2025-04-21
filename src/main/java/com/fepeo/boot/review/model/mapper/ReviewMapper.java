package com.fepeo.boot.review.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.fepeo.boot.review.controller.dto.ImgAddRequest;
import com.fepeo.boot.review.controller.dto.ReviewAddRequest;
import com.fepeo.boot.review.model.vo.Review;

@Mapper
public interface ReviewMapper {
	//리뷰등록!!//
	int insertReview(ReviewAddRequest review);
	//detail꺼!
	Review selectOneByNo(int reviewNo);
	
	//*여기도 정리되면 주석 지울것!!
	//여행후기 전체 리스트! 페이징(21:39)int currentPage
	//List<Review> selectReviewList(int currentPage);
	
	//원복중 4/17 09:36 Logic에서 만들어줌!
	//List<Review> selectReviewList();
	
//	//원복중 4/17 09:35분 아래꺼 주석(강사님코드) 등록 확인되면 다시 살렷서 시작!!
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
	//4/19 삭제 안되서 바꿔봄 안되면 다시 복귀!
	//int reviewDelete(Integer reviewNo);
	//리뷰 조회수 추가 4/19
	int reviewCount(int reviewNo);
	
	//검색!4/21 16:12
	List<Review> searchListByKeyword(RowBounds rowBounds, Map<String, String> paramMap);
	//검색 2 카운트 (추가할거 있음 할것!)(아래는 지워야하나??)
	int getTotalCountBySearch(Map<String, String> paramMap);
	
	
	//이미지등록4/17 20:32 (에러나면 지울것!)List로 받아야하니 아래 2개주석!23:53
	//int insertReview(ImgAddRequest review);
	//int insertImgAddRequest(ImgAddRequest img);
	
	//토탈카운트
//	int getTotalCount();
//	List<Review> selectReviewList(int currentPage);

}
