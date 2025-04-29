package com.fepeo.boot.review.model.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class ReviewComment {
	
	private int			commentNo;
	private String		commentContent;
	private Timestamp	commentTime;
	private int			reviewNo;
	private int			memberNo;
	private String		deleteYn;
	private String 		nickname;
}
