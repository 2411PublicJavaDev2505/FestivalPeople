package com.fepeo.boot.festival.model.vo;

import java.util.List;

import com.fepeo.boot.festival.model.vo.dto.FestivalItem;

public class FestivalResponse {
    private Response response;

    public Response getResponse() {
        return response;
    }

    public void setResponse(Response response) {
        this.response = response;
    }

    public static class Response {
        private Body body;

        public Body getBody() {
            return body;
        }

        public void setBody(Body body) {
            this.body = body;
        }

        public static class Body {
            private Items items;

            public Items getItems() {
                return items;
            }

            public void setItems(Items items) {
                this.items = items;
            }

            public static class Items {
                private List<FestivalItem> item;

                public List<FestivalItem> getItem() {
                    return item;
                }

                public void setItem(List<FestivalItem> item) {
                    this.item = item;
                }
            }
        }
    }
}
