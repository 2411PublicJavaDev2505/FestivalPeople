package com.fepeo.boot.review.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.review.controller.dto.CommentAddRequest;
import com.fepeo.boot.review.model.vo.ReviewComment;

@Mapper
public interface CommentMapper {
	//댓글등록!!(
	int insertComment(CommentAddRequest comment);
	//댓글리스트! 23:48분 int reviewNo
	List<ReviewComment> selectCommentList(int reviewNo);
	//4/27 댓글삭제! 안되면 지우기!
	int commentDelete(int commentNo);
	
}
