package com.fepeo.boot.report.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.fepeo.boot.report.model.vo.Report;
import com.fepeo.boot.report.model.vo.dto.ReportDTO;

@Mapper
public interface ReportMapper {
	
	int insertReport(ReportDTO dto);

	int getTotalCount();

	List<Report> selectReportList(RowBounds rowBounds);

}
