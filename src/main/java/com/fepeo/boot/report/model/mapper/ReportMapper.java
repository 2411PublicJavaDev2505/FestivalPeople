package com.fepeo.boot.report.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.fepeo.boot.report.model.vo.dto.ReportDTO;

@Mapper
public interface ReportMapper {
	
	int insertReport(ReportDTO dto);

}
