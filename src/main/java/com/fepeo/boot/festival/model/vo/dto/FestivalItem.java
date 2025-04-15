package com.fepeo.boot.festival.model.vo.dto;



import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class FestivalItem {
	private String contentid;
	private String title;
    private String eventstartdate;
    private String eventenddate;
    private String firstimage;
    private String tel;
    private String addr1;
    private String addr2;
    private String mapx;
    private String mapy;

}
