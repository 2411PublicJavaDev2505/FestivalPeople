package com.fepeo.boot.review.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.review.controller.dto.CommentAddRequest;
import com.fepeo.boot.review.model.vo.ReviewComment;

@Mapper
public interface CommentMapper {
	
	int insertComment(CommentAddRequest comment);
	List<ReviewComment> selectCommentList(int reviewNo);
	int commentDelete(int commentNo);
	int selectMemberNoByCommentNo(int num);
	ReviewComment selectOneByNo(int commentNo);
	
}
