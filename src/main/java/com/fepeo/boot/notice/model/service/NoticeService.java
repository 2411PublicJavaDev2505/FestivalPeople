package com.fepeo.boot.notice.model.service;

import com.fepeo.boot.notice.controller.dto.NoticeAddRequest;
import com.fepeo.boot.notice.model.vo.Notice;

public interface NoticeService {

	int insertNotice(NoticeAddRequest notice);
	
	Notice selecrOneByNo(int noticeNo);
}
