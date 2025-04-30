package com.fepeo.boot.review.model.service;

import java.util.List;

import com.fepeo.boot.review.controller.dto.CommentAddRequest;
import com.fepeo.boot.review.model.vo.ReviewComment;

public interface CommentService {
	//댓글등록
	int insertComment(CommentAddRequest comment);
	//댓글 리스트
	List<ReviewComment> selectCommentList(int reviewNo);
	//댓글삭제
	int commentDelete(int commentNo);
	
	int selectMemberNoByCommentNo(int num);
	
	ReviewComment selectOneByNo(int commentNo);

}
