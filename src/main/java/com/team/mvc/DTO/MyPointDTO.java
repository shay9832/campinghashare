package com.team.mvc.DTO;

public class MyPointDTO {
    private String created_date;                //포인트를 받은 날짜
    private String point_reason;                //포인트 변동 유형
    private int point_change;                   //변동 포인트(음수라면 감점)
    private int total_point;                    //누적 포인트

    public String getCreated_date() {
        return created_date;
    }

    public void setCreated_date(String created_date) {
        this.created_date = created_date;
    }

    public String getPoint_reason() {
        return point_reason;
    }

    public void setPoint_reason(String point_reason) {
        this.point_reason = point_reason;
    }

    public int getPoint_change() {
        return point_change;
    }

    public void setPoint_change(int point_change) {
        this.point_change = point_change;
    }

    public int getTotal_point() {
        return total_point;
    }

    public void setTotal_point(int total_point) {
        this.total_point = total_point;
    }
}
