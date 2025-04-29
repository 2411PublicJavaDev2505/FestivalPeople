package com.fepeo.boot.report.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.fepeo.boot.report.model.vo.Report;
import com.fepeo.boot.report.model.vo.dto.ReportDTO;

@Service
public interface ReportService {

	int insertReport(ReportDTO report);

	int getTotalCount();

	List<Report> selectReportList(int currentPage);

	Report selectOneByNo(int reportNo);

	int deleteReport(int reportNo);

	int deleteChatroomReport(int chatRoomNo);

	int deleteReviewReport(int reviewNo);

	int deleteCommentReport(int commentNo);

	int getSearchTotalCount(Map<String, String> searchMap);

	List<Report> searchReportList(Map<String, String> searchMap, int currentPage);

}
