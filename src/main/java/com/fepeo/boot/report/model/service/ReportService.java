package com.fepeo.boot.report.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fepeo.boot.report.model.vo.Report;
import com.fepeo.boot.report.model.vo.dto.ReportDTO;

@Service
public interface ReportService {

	int insertReport(ReportDTO report);

	int getTotalCount();

	List<Report> selectReportList(int currentPage);

}
