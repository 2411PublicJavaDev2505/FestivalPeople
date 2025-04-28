package com.fepeo.boot.review.model.service;

import java.util.List;

import com.fepeo.boot.review.controller.dto.CommentAddRequest;
import com.fepeo.boot.review.model.vo.ReviewComment;

public interface CommentService {
	//댓글등록!!
	int insertComment(CommentAddRequest comment);
	//4/16 9:24 댓글 리스트 작성!
	List<ReviewComment> selectCommentList(int reviewNo);
	
	//4/27 댓글삭제 안되면 지우기!
	int CommentDelete(int commentNo);
	

}
