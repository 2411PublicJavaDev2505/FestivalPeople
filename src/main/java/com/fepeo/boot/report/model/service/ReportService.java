package com.fepeo.boot.report.model.service;

import org.springframework.stereotype.Service;

import com.fepeo.boot.report.model.vo.dto.ReportDTO;

@Service
public interface ReportService {

	boolean saveReport(ReportDTO dto);

}
