package com.fepeo.boot.notice.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.fepeo.boot.notice.controller.dto.NoticeAddRequest;
import com.fepeo.boot.notice.controller.dto.NoticeUpdateRequest;
import com.fepeo.boot.notice.model.vo.Notice;

@Mapper
public interface NoticeMapper {

	int insertNotice(NoticeAddRequest notice);

	List<Notice> selectNoticeList(RowBounds rowBounds);

	int getTotalCount();

	Notice selectOneByNo(int noticeNo);

	int deleteNotice(int noticeNo);

	int updateNotice(NoticeUpdateRequest notice);

	int countNotice(int noticeNo);

}
