package com.fepeo.boot.festival.model.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class FestivalResponse {
    private Response response;

    @Getter @Setter
    public static class Response {
        private Header header;
        private Body body;

        @Getter @Setter
        public static class Header {
            private String resultCode;
            private String resultMsg;
        }

        @Getter @Setter
        public static class Body {
            private Items items;
            private int numOfRows;
            private int pageNo;
            private int totalCount;

            @Getter @Setter
            public static class Items {
                private List<com.fepeo.boot.festival.model.vo.dto.FestivalItem> item;
            }
            
            @Getter @Setter
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
        }
    }
}