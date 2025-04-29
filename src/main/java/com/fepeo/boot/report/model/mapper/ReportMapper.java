package com.fepeo.boot.report.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.fepeo.boot.report.model.vo.Report;
import com.fepeo.boot.report.model.vo.dto.ReportDTO;

@Mapper
public interface ReportMapper {
	
	int insertReport(ReportDTO dto);

	int getTotalCount();

	List<Report> selectReportList(RowBounds rowBounds);

	Report selectOneByNo(int reportNo);

	int deleteReport(int reportNo);

	int deleteChatroomReport(int chatRoomNo);

	int deleteReviewReport(int reviewNo);

	int deleteCommentReport(int commentNo);

	int getSearchTotalCount(Map<String, String> searchMap);

	List<Report> searchReportList(Map<String, String> searchMap, RowBounds rowBounds);

}
