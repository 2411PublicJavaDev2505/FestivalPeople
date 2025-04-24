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
	
	//파일업로드 추가 4/17 17:23~!
	private String webPath ="/images/review/";
	private String folderPath = "C:/uploadImage/review/";
	
	
	@Override
	public Review selectOneByNo(int reviewNo) {
		Review review = mapper.selectOneByNo(reviewNo);
		return review;
	}

	
	
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
		//게시글 번호 꺼내기!!
		int reviewNo = review.getReviewNo();
		//4/11 코드 추가해줌!그리고 if 안에 코드넣어주고 아래 4/11
		if(images != null) {
			for(int i = 0; i < images.size(); i++) {
				if(images.get(i).getSize() > 0) {
					ImgAddRequest img = new ImgAddRequest();
					//img에 파일 정보를 담기!!
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
	
	//04/18 16:21 리뷰 게시판 삭제 원래 아래 int reviewNo임!!
	@Override
	public int reviewDelete(int reviewNo) {
		int result = mapper.reviewDelete(reviewNo);
		System.out.println("확인");
		return reviewNo;
	}
	
	//리뷰조회수!
	
	@Override
	public int reviewCount(int reviewNo) {
		return mapper.reviewCount(reviewNo);
	}

	
	//4/23 강제로 throws IllegalStateException, IOException 넣어줌!
	//4/23 21:07 이미지 수정코드 작성하면서 주석하고 다시 작성!
//	
//	@Override
//	public int reviewUpdate(ReviewUpdateRequest review) throws IllegalStateException, IOException {
//		int result = mapper.reviewUpdate(review);
//		return result;
		
	//아래는 4/24 원래코드!! 주석하고 다시작성!안되면 원복!!
	//주석코드 뭔가 바뀜??!.....
//	@Override,List<MultipartFile> images
//	public int reviewUpdate(ReviewUpdateRequest review) throws IllegalStateException, IOException {
//		int result = mapper.reviewUpdate(review);
//		return result;
	//콘트롤러랑 다르기때문에 당연히 코드확인필요!!!!!!
	//다시 지움!!....주석...
//	@Override
//	public int reviewUpdate(ReviewUpdateRequest review,List<ImgAddRequest> imageList) throws IllegalStateException, IOException {
//		//강제로 씀....
//		
//		//return = mapper.reviewUpdate(review);;
//	
//	}
	//4/24 14:13분 오전에 작업한거 주석처리! 코드 다시 작성!
	//ReviewUpdateRequest 에 변수확인하기!! 파일수정전용코드?
//	@Override
//	public int reviewUpdate(ReviewUpdateRequest review) throws IllegalStateException, IOException {
//		if(review.getImageFile() != null && !review.getImageFile().isEmpty()) {
//			MultipartFile imageFile = review.getImageFile();
//			String fileName = imageFile.getOriginalFilename();
//			String fileRename = Util.fileRename(fileName);
//			String filePath = "/images/review/"+fileRename;
//			imageFile.transferTo(new File("C:/uploadImage/review/"+fileRename));
//			review.setReviewFileName(fileName);
//			review.setReviewFileRename(fileRename);
//			review.setReviewFilePath(filePath);
//		}else {
//			Review existing = mapper.selectOneByNo(review.getReviewNo());
//			//일단1개만 해봅시다! 커밋하기전 여기까지 작성..
//			review.setReviewFileName(existing.getReviewFileName1());
//			review.setReviewFileName(existing.getReviewFileRename1());
//			review.setReviewFileName(existing.getReviewFilePath1());
//			
//		}
//		
//		return  mapper.reviewUpdate(review);
//	}
	
	//리뷰검색
	@Override
	public List<Review> searchListByKeyword(Map<String, String> paramMap,int currentPage) {
		int limit =10;
		int offset =(currentPage-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit); 
		List<Review> searchList = mapper.searchListByKeyword(rowBounds, paramMap);
		return searchList;
	}

	
	
	//검색 2 4/21 18:55 //
	@Override
	public int getTotalCount(Map<String, String> paramMap) {
		int totalCount = mapper.getTotalCountBySearch(paramMap);
		return totalCount;
	}


	//4/22 10:33 분 추가 안되면 지울것detail 작성자!
	@Override
	public List<Review> selectReviewList() {
		List<Review> rList = mapper.selectReviewList();
		return rList;
	}

	//4/24 15:02분 게시판 수정 

	@Override
	public int updateReview(ReviewUpdateRequest review, List<MultipartFile> images) throws IllegalStateException, IOException {
		int result = mapper.updateReview(review);
		if(result == 0) return 0;
		int reviewNo = review.getReviewNo();
		//4/24 복붙!
		if(images != null) {
			for(int i = 0; i < images.size(); i++) {
				if(images.get(i).getSize() > 0) {
					ImgAddRequest img = new ImgAddRequest();
					//img에 파일 정보를 담기!!
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
	public int reviewUpdate(ReviewUpdateRequest review) throws IllegalStateException, IOException{
		//16:09분 제목내용만 수정코드
		int result = mapper.reviewUpdate(review);
		return result;
	}



	//4/24 이미지 파일 수정 만듬...(제목하고 내용만??)  
	//이것도 4/24 14:20 코드 다시 작성위해 주석처리!
//	@Override
//	public int reviewUpdate(ReviewUpdateRequest review, List<MultipartFile> images)
//			throws IllegalStateException, IOException {
//		int result = mapper.reviewUpdate(review);
//		return result;
//	}
}
