package com.fepeo.boot.notice.model.service;

import java.io.IOException;

import com.fepeo.boot.notice.controller.dto.NoticeAddRequest;
import com.fepeo.boot.notice.model.vo.Notice;

public interface NoticeService {

	int insertNotice(NoticeAddRequest notice) throws IllegalStateException, IOException;
	
	Notice selecrOneByNo(int noticeNo);
}
