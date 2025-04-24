package com.fepeo.boot.report.model.service.logic;

import org.springframework.stereotype.Service;

import com.fepeo.boot.report.model.mapper.ReportMapper;
import com.fepeo.boot.report.model.service.ReportService;
import com.fepeo.boot.report.model.vo.dto.ReportDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReportServiceLogic implements ReportService{
	
	private final ReportMapper reportMapper;
	
	@Override
	public boolean saveReport(ReportDTO dto) {
		return reportMapper.insertReport(dto)> 0;
	}

}
