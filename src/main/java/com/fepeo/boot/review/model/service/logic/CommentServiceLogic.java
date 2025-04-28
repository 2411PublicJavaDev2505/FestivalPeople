package com.fepeo.boot.review.model.service.logic;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fepeo.boot.review.controller.dto.CommentAddRequest;
import com.fepeo.boot.review.model.mapper.CommentMapper;
import com.fepeo.boot.review.model.mapper.ReviewMapper;
import com.fepeo.boot.review.model.service.CommentService;
import com.fepeo.boot.review.model.vo.ReviewComment;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommentServiceLogic implements CommentService{
	
	
	
	private final CommentMapper mapper;
	
	//댓글등록!
	@Override
	public int insertComment(CommentAddRequest comment) {
		int result = mapper.insertComment(comment);
		return result;
	}
	
	
	//댓글 리스트 
	@Override
	public List<ReviewComment> selectCommentList(int reviewNo) {
		return mapper.selectCommentList(reviewNo);
	}


	@Override
	public int commentDelete(int commentNo) {
		int result = mapper.commentDelete(commentNo);
		return result;
	}


	@Override
	public int selectMemberNoByCommentNo(int num) {
		return mapper.selectMemberNoByCommentNo(num);
	}


	@Override
	public ReviewComment selectOneByNo(int commentNo) {
		return mapper.selectOneByNo(commentNo);
	}
	
	
}
