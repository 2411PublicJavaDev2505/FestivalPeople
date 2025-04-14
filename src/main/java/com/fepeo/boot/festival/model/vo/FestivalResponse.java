package com.fepeo.boot.festival.model.vo;

import java.util.List;

import com.fepeo.boot.festival.model.vo.dto.FestivalItem;

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
                private List<FestivalItem> item;
            }
        }
    }
}