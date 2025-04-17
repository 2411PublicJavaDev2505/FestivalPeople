package com.fepeo.boot.notice.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.notice.controller.dto.NoticeAddRequest;

@Mapper
public interface NoticeMapper {

	int insertNotice(NoticeAddRequest notice);

}
