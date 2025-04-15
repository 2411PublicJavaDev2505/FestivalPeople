package com.fepeo.boot.review.model.service.logic;

import org.springframework.stereotype.Service;

import com.fepeo.boot.review.model.mapper.CommentMapper;
import com.fepeo.boot.review.model.service.CommentService;
import com.fepeo.boot.review.model.vo.ReviewComment;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommentServiceLogic implements CommentService{
	
	private final CommentMapper mapper;
	
	//댓글등록!
	@Override
	public int insertComment(ReviewComment comment) {
		int result = mapper.insertComment(comment);
		return result;
	}
	
	
}
