package com.fepeo.boot.review.model.vo;

import java.sql.Timestamp;
import java.util.List;

import com.fepeo.boot.review.controller.dto.ImgAddRequest;


import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class Review {
	
	private	int			reviewNo;			//리뷰번호
	private	String		reviewTitle;		//리뷰제목
	private String		reviewContent;		//리뷰내용
	private	Timestamp	reviewWriteTime;	//리뷰작성시간
	private int			reviewCount;		//리뷰조회수
	private String		reviewYn;			//리뷰유무?
	private String		reviewFileName1;	//리뷰이름1
	private String		reviewFileRename1;	//리뷰파일변경이름1
	private String		reviewFilePath1;	//리뷰파일경로1
	private String		reviewFileName2;
	private String		reviewFileRename2;
	private String		reviewFilePath2;
	private String		reviewFileName3;
	private String		reviewFileRename3;
	private String		reviewFilePath3;
	private int			memberNo;
	//댓글목록 추가!! 옆에 commentList수정해야되는지확인할것!
	private List<ReviewComment> commentList;
	//다중파일 등록 추가 23:18
	private List<ImgAddRequest> imgList;
}
