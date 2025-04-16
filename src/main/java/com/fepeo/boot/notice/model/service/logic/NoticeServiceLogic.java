package com.fepeo.boot.notice.model.service.logic;

import org.springframework.stereotype.Service;

import com.fepeo.boot.notice.controller.dto.NoticeAddRequest;
import com.fepeo.boot.notice.model.service.NoticeService;
import com.fepeo.boot.notice.model.vo.Notice;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NoticeServiceLogic implements NoticeService {

	@Override
	public int insertNotice(NoticeAddRequest notice) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Notice selecrOneByNo(int noticeNo) {
		// TODO Auto-generated method stub
		return null;
	}

}
