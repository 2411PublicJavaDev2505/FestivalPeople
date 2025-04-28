package com.fepeo.boot.report.model.service.logic;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;

import com.fepeo.boot.report.model.mapper.ReportMapper;
import com.fepeo.boot.report.model.service.ReportService;
import com.fepeo.boot.report.model.vo.Report;
import com.fepeo.boot.report.model.vo.dto.ReportDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReportServiceLogic implements ReportService{
	
	private final ReportMapper reportMapper;

	@Override
	public int insertReport(ReportDTO report) {
		return reportMapper.insertReport(report);
	}

	@Override
	public int getTotalCount() {
		return reportMapper.getTotalCount();
	}

	@Override
	public List<Report> selectReportList(int currentPage) {
		int limit = 10;
		int offset = (currentPage-1)* limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		return reportMapper.selectReportList(rowBounds);
	}

	@Override
	public Report selectOneByNo(int reportNo) {
		return reportMapper.selectOneByNo(reportNo);
	}

	@Override
	public int deleteReport(int reportNo) {
		return reportMapper.deleteReport(reportNo);
	}

	@Override
	public int deleteChatroomReport(int chatRoomNo) {
		return reportMapper.deleteChatroomReport(chatRoomNo);
	}

	@Override
	public int deleteReviewReport(int reviewNo) {
		return reportMapper.deleteReviewReport(reviewNo);
	}

	@Override
	public int deleteCommentReport(int commentNo) {
		return reportMapper.deleteCommentReport(commentNo);
	}

}
