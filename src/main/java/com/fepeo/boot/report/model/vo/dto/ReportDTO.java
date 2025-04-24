package com.fepeo.boot.report.model.vo.dto;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReportDTO {
	 
	 private List<String> reasons;
	 private String otherText;
}
