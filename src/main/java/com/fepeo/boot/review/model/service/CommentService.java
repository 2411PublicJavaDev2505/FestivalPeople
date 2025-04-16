package com.fepeo.boot.review.model.service;

import com.fepeo.boot.review.controller.dto.CommentAddRequest;
import com.fepeo.boot.review.model.vo.ReviewComment;

public interface CommentService {
	//댓글등록!!
	int insertComment(CommentAddRequest comment);

}
