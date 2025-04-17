package com.fepeo.boot.notice.model.service.logic;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.fepeo.boot.common.util.Util;
import com.fepeo.boot.notice.controller.dto.NoticeAddRequest;
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
		return mapper.insertNotice(notice);
	}

	@Override
	public Notice selecrOneByNo(int noticeNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Notice> selectNoticeList() {
		return mapper.selectNoticeList();
	}

}
