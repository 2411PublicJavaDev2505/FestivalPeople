package com.fepeo.boot.notice.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.notice.controller.dto.NoticeAddRequest;
import com.fepeo.boot.notice.model.vo.Notice;

@Mapper
public interface NoticeMapper {

	int insertNotice(NoticeAddRequest notice);

	List<Notice> selectNoticeList();

}
