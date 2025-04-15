package com.fepeo.boot.review.model.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ReviewComment {
	
	//detail 댓글 작업시작하면서 주석풀어줌!4/15 10:15
	private int			commentNo;
	private String		commentContent;
	private Timestamp	commentTime;
	private int			reviewNo;
	private int			memberNo;
	private String		deleteYn;
}
