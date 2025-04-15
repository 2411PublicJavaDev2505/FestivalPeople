package com.fepeo.boot.review.controller.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommentAddRequest {
	
	//4개인데 확인필요!!!(4/15 15:37)
	private int		commentNo;
	private String	commnetContent;
	private int		reviewNo;
	private int		memberNo;
}
