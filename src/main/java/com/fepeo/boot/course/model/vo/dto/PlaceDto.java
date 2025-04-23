package com.fepeo.boot.course.model.vo.dto;

import lombok.Data;


@Data
public class PlaceDto {
    private String place_name;
    private String road_address_name;
    private String phone;
    private String x;
    private String y;
    private String place_url;
    private String id; //
    private String grade;
    private int reviewCount;
    private String category_group_code;
    
    
    public PlaceDto() {}
    
	
}
