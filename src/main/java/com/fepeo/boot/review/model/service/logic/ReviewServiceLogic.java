package com.fepeo.boot.review.model.service.logic;


import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.common.util.Util;
import com.fepeo.boot.review.controller.dto.ImgAddRequest;
import com.fepeo.boot.review.controller.dto.ReviewAddRequest;
import com.fepeo.boot.review.model.mapper.ReviewMapper;
import com.fepeo.boot.review.model.service.ReviewService;
import com.fepeo.boot.review.model.vo.Review;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewServiceLogic implements ReviewService {
	
	//아래것도 적는게 맞는지 확인필요!지워줄것!!!
	//private final SqlSession session;
	
	private final ReviewMapper mapper;
	
	//파일업로드 추가 4/17 17:23~!
	private String webPath ="/images/review/";
	private String folderPath = "C:/uploadImage/review/";
	
	//insertReview(ReviewAddRequest review,MultipartFile images) 원래코드
	// 수정코드! 파일업로드파일 코드작성 4/17 17:25분!!코드 수정하고 추가해줌!!
	// ***review에서 imgdto만들어준다!!!!일단 코드 적기! 4/17 19:19 
	//
//	@Override
//	public int insertReview(ReviewAddRequest review,List<MultipartFile> images) 
//			throws IllegalStateException, IOException {
//		int result = mapper.insertReview(review);
//		//게시글 등록 실패시!!return 밑으로 코드 진행 안된다!!
//				if(result == 0) return 0;
//				//게시글 번호 꺼내기!!
//				int reviewNo = review.getReviewNo();
//				List<ImgAddRequest> imageList = new ArrayList<ImgAddRequest>();
//				//4/11 코드 추가해줌!그리고 if 안에 코드넣어주고 아래 4/11
//				if(images != null) {
//					for(int i = 0; i < images.size(); i++) {
//						if(images.get(i).getSize() > 0) {
//							ImgAddRequest img = new ImgAddRequest();
//							//img에 파일 정보를 담기!!
//							img.setReviewNo(reviewNo);
//							
//							
//							String reviewFileName1 = images.get(i).getOriginalFilename();
//							String reviewFileRename1 = Util.fileRename(reviewFileName1);
//							String reviewFileName2 = images.get(i).getOriginalFilename();
//							String reviewFileRename2 = Util.fileRename(reviewFileName2);
//							String reviewFileName3 = images.get(i).getOriginalFilename();
//							String reviewFileRename3 = Util.fileRename(reviewFileName3);
//							
//							img.setReviewFileName1(reviewFileName1);
//							img.setReviewFileRename1(reviewFileRename1);
//							img.setReviewFilePath1(webPath+reviewFileRename1);
//							img.setReviewFileName2(reviewFileName2);
//							img.setReviewFileRename2(reviewFileRename2);
//							img.setReviewFilePath2(webPath+reviewFileRename2);
//							img.setReviewFileName3(reviewFileName3);
//							img.setReviewFileRename3(reviewFileRename3);
//							img.setReviewFilePath3(webPath+reviewFileRename3);
//							img.setImageFile(images.get(i));
//							
//							//img를 imageList에 추가!!
//							imageList.add(img);
//							//1:06분 15초부터 코드적기!
//						}//여기부터 아래코드 4/11강의때 한칸 올려줌!!***
//					}//images -> imageList 처리 작업종료 
//					//1.처리후 ImageList에 정보를 DB에 Insert 해야함!!
//					//2.실제 파일저장!!
//					if(!imageList.isEmpty()) {
//						//1. imageList정보를 DB에 insert해야함.
//						result = mapper.insertReviewImageList(imageList);
//						//2. 실제 파일 저장!!
//						for(ImgAddRequest img: imageList) {
//							img.getImageFile().transferTo(new File(folderPath+img.getReviewFileName1()));
//							img.getImageFile().transferTo(new File(folderPath+img.getReviewFileName2()));
//							img.getImageFile().transferTo(new File(folderPath+img.getReviewFileName3()));
//							
//						}
//					}
//				}
//				return result;
//		return mapper.insertReview(review); 원래코드!!
//	}
	
	
	//detail
	@Override
	public Review selectOneByNo(int reviewNo) {
		Review review = mapper.selectOneByNo(reviewNo);
		return review;
	}

	//원복중 다시 만듬(4/17:09:33)등록확인후 주석처리!정리되면 지울것!!
//	@Override
//	public List<Review> selectReviewList() {
//		List<Review> rList = mapper.selectReviewList();
//		return rList;
//	}
	
	//원복하고 4/17 10:02분 여기부터시작!
	
	@Override
	public List<Review> selectReviewList(int currentPage) {
		int limit =10;
		int offset =(currentPage-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit); 
		List<Review> rList = mapper.selectReviewList(rowBounds);
		return rList;

//		int limit =10;
//		int offset =(currentPage-1)*limit;
//		RowBounds rowBounds = new RowBounds(offset, limit); 
//		List<Review> rList = mapper.selectReviewList(rowBounds);
//		return rList;
		
	}

	//토탈카운트!!
	@Override
	public int getTotalCount() {
		int totalCount = mapper.getTotalCount();
		return totalCount;
	}

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

	@Override
	public int reviewCount(int reviewNo) {
		return mapper.reviewCount(reviewNo);
	}
}
