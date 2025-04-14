package com.fepeo.boot.review.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.review.controller.dto.ReviewAddRequest;

@Mapper
public interface ReviewMapper {
	//리뷰등록!!//
	int insertReview(ReviewAddRequest review);

}
