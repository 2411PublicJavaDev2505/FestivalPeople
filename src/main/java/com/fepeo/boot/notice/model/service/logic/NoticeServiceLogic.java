package com.fepeo.boot.notice.model.service.logic;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.common.util.Util;
import com.fepeo.boot.notice.controller.dto.NoticeAddRequest;
import com.fepeo.boot.notice.controller.dto.NoticeUpdateRequest;
import com.fepeo.boot.notice.model.mapper.NoticeMapper;
import com.fepeo.boot.notice.model.service.NoticeService;
import com.fepeo.boot.notice.model.vo.Notice;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceLogic implements NoticeService {

	private final NoticeMapper mapper;
	
	@Override
	public int insertNotice(NoticeAddRequest notice) throws IllegalStateException, IOException {
		if(notice.getFile() != null && !notice.getFile().isEmpty()) {
			MultipartFile file = notice.getFile();
			String filename = file.getOriginalFilename();
			String fileRename = Util.fileRename(filename);
			String filePath = "/images/notice/"+fileRename;
			file.transferTo(new File("C:/uploadImage/notice/"+fileRename));
			notice.setNoticeFileName(filename);
			notice.setNoticeFileRename(fileRename);
			notice.setNoticeFilePath(filePath);
		}
		int result = mapper.insertNotice(notice);
		return notice.getNoticeNo();
	}

	@Override
	public Notice selectOneByNo(int noticeNo) {
		return mapper.selectOneByNo(noticeNo);
	}

	@Override
	public List<Notice> selectNoticeList(int currentPage) {
		int limit =10;
		int offset =(currentPage-1)*limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return mapper.selectNoticeList(rowBounds);
	}

	@Override
	public int getTotalCount() {
		return mapper.getTotalCount();
	}

	@Override
	public int deleteNotice(int noticeNo) {
		return mapper.deleteNotice(noticeNo);
	}

	@Override
	public int updateNotice(NoticeUpdateRequest notice) throws IllegalStateException, IOException {
		if(notice.getFile() != null && !notice.getFile().isEmpty()) {
			MultipartFile file = notice.getFile();
			String filename = file.getOriginalFilename();
			String fileRename = Util.fileRename(filename);
			String filePath = "/images/notice/"+fileRename;
			file.transferTo(new File("C:/uploadImage/notice/"+fileRename));
			notice.setNoticeFileName(filename);
			notice.setNoticeFileRename(fileRename);
			notice.setNoticeFilePath(filePath);
		}else {
			Notice existing = mapper.selectOneByNo(notice.getNoticeNo());
			notice.setNoticeFileName(existing.getNoticeFileName());
			notice.setNoticeFileRename(existing.getNoticeFileRename());
			notice.setNoticeFilePath(existing.getNoticeFilePath());
		}
		return mapper.updateNotice(notice);
	}

	@Override
	public int countNotice(int noticeNo) {
		return mapper.countNotice(noticeNo);
	}

}
