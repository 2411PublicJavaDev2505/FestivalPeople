package com.fepeo.boot.notice.model.service;

import java.io.IOException;
import java.util.List;

import com.fepeo.boot.notice.controller.dto.NoticeAddRequest;
import com.fepeo.boot.notice.controller.dto.NoticeUpdateRequest;
import com.fepeo.boot.notice.model.vo.Notice;

public interface NoticeService {

	int insertNotice(NoticeAddRequest notice) throws IllegalStateException, IOException;
	
	Notice selectOneByNo(int noticeNo);

	List<Notice> selectNoticeList(int currentPage);

	int getTotalCount();

	int deleteNotice(int noticeNo);

	int updateNotice(NoticeUpdateRequest notice) throws IllegalStateException, IOException;

	int countNotice(int noticeNo);

}
