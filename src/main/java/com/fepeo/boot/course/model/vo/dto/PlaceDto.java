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
    
    public String getPlace_url() {
    	return place_url;
    }
    
	public String getPlace_name() {
		return place_name;
	}
	public String getRoad_address_name() {
		return road_address_name;
	}
	public String getPhone() {
		return phone;
	}
	public String getX() {
		return x;
	}
	public String getY() {
		return y;
	}
}
