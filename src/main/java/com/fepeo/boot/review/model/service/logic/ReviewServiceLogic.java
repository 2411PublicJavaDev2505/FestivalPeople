package com.fepeo.boot.review.model.service.logic;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.common.util.Util;
import com.fepeo.boot.review.controller.dto.ImgAddRequest;
import com.fepeo.boot.review.controller.dto.ReviewAddRequest;
import com.fepeo.boot.review.controller.dto.ReviewUpdateRequest;
import com.fepeo.boot.review.model.mapper.ReviewMapper;
import com.fepeo.boot.review.model.service.ReviewService;
import com.fepeo.boot.review.model.vo.Review;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewServiceLogic implements ReviewService {
	

	
	private final ReviewMapper mapper;
	//파일업로드 
	private String webPath ="/images/review/";
	private String folderPath = "C:/uploadImage/review/";
	
	
	//게시판 상세 
	@Override
	public Review selectOneByNo(int reviewNo) {
		Review review = mapper.selectOneByNo(reviewNo);
		return review;
	}

	
	//전체리스트
	@Override
	public List<Review> selectReviewList(int currentPage) {
		int limit =10;
		int offset =(currentPage-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit); 
		List<Review> rList = mapper.selectReviewList(rowBounds);
		return rList;
		
	}

	//토탈카운트!!
	@Override
	public int getTotalCount() {
		int totalCount = mapper.getTotalCount();
		return totalCount;
	}
	
	//리뷰게시글등록(첨부파일포함)
	@Override
	public int insertReview(ReviewAddRequest review, List<MultipartFile> images)
			throws IllegalStateException, IOException {
		int result = mapper.insertReview(review);
		if(result == 0) return 0;
		int reviewNo = review.getReviewNo();
		if(images != null) {
			for(int i = 0; i < images.size(); i++) {
				if(images.get(i).getSize() > 0) {
					ImgAddRequest img = new ImgAddRequest();
					img.setReviewNo(reviewNo);
					String fileName = images.get(i).getOriginalFilename();
					String fileRename = Util.fileRename(fileName);
					String filePath = "/images/review/"+fileRename;
					img.setReviewFileName(fileName);
					img.setReviewFileRename(fileRename);
					img.setReviewFilePath(filePath);
					images.get(i).transferTo(new File("C:/uploadImage/review/"+fileRename));
					if(i == 0) {
						result += mapper.insertReviewFirstImage(img);
					}else if(i == 1) {
						result += mapper.insertReviewSecondImage(img);
					}else if(i == 2) {
						result += mapper.insertReviewThirdImage(img);
					}
				}
			}
		}
		return result;
	}
	
	//리뷰 게시판 삭제
	@Override
	public int reviewDelete(int reviewNo) {
		int result = mapper.reviewDelete(reviewNo);
		System.out.println("확인");
		return reviewNo;
	}
	
	//리뷰
	
	@Override
	public int reviewCount(int reviewNo) {
		return mapper.reviewCount(reviewNo);
	}

	//리뷰검색
	@Override
	public List<Review> searchListByKeyword(Map<String, String> paramMap,int currentPage) {
		int limit =10;
		int offset =(currentPage-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit); 
		List<Review> searchList = mapper.searchListByKeyword(rowBounds, paramMap);
		return searchList;
	}

	//검색 2
	@Override
	public int getTotalCount(Map<String, String> paramMap) {
		int totalCount = mapper.getTotalCountBySearch(paramMap);
		return totalCount;
	}


	//상세작성자
	@Override
	public List<Review> selectReviewList() {
		List<Review> rList = mapper.selectReviewList();
		return rList;
	}

	
	//리뷰수정
	@Override
	public int reviewUpdate(ReviewAddRequest review, List<MultipartFile> images) throws IllegalStateException, IOException {
		int result = mapper.reviewUpdate(review);
		if(result == 0) return 0;
		int reviewNo = review.getReviewNo();
		if(images != null) {
			for(int i = 0; i < images.size(); i++) {
				if(images.get(i).getSize() > 0) {
					ImgAddRequest img = new ImgAddRequest();
					img.setReviewNo(reviewNo);
					String fileName = images.get(i).getOriginalFilename();
					String fileRename = Util.fileRename(fileName);
					String filePath = "/images/review/"+fileRename;
					img.setReviewFileName(fileName);
					img.setReviewFileRename(fileRename);
					img.setReviewFilePath(filePath);
					images.get(i).transferTo(new File("C:/uploadImage/review/"+fileRename));
					if(i == 0) {
						result += mapper.updateReviewFirstImage(img);
					}else if(i == 1) {
						result += mapper.updateReviewSecondImage(img);
					}else if(i == 2) {
						result += mapper.updateReviewThirdImage(img);
					}
				}
			}
		}
		return result;
	}



	@Override
	public int selectMemberNoByReviewNo(int num) {
		return mapper.selectMemberNoByReviewNo(num);
	}
}
