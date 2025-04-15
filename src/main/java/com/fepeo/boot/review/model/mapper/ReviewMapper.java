package com.fepeo.boot.review.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.review.controller.dto.ReviewAddRequest;
import com.fepeo.boot.review.model.vo.Review;

@Mapper
public interface ReviewMapper {
	//리뷰등록!!//
	int insertReview(ReviewAddRequest review);
	//detail꺼!
	Review selectOneByNo(int reviewNo);

}
