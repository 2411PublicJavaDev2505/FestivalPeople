package com.fepeo.boot.review.controller.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommentAddRequest {
	
	private String	commentContent;
	private int		reviewNo;
	private int		memberNo;
}
