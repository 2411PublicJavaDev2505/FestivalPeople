package com.fepeo.boot.review.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.review.controller.dto.CommentAddRequest;
import com.fepeo.boot.review.model.vo.ReviewComment;

@Mapper
public interface CommentMapper {
	//댓글등록!!(
	int insertComment(CommentAddRequest comment);

}
