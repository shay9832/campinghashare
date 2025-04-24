package com.team.mvc.DTO;

public class CouponDTO {
    int coupon_id;   //보유쿠폰ID
    int user_code;  //회원코드
    String nickname;    //회원닉네임
    String coupon_name;     //쿠폰이름
    String coupon_type;     //쿠폰종류
    int coupon_discount;    //쿠폰할인율
    int coupon_month;       //쿠폰유효개월수
    String coupon_created_date; //쿠폰발행일
    String coupon_end_date;     //쿠폰사용가능일(쿠폰만료일)
    String coupon_used_date;    //쿠폰사용일

    public int getCoupon_id() {
        return coupon_id;
    }

    public void setCoupon_id(int coupon_id) {
        this.coupon_id = coupon_id;
    }

    public int getUser_code() {
        return user_code;
    }

    public void setUser_code(int user_code) {
        this.user_code = user_code;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getCoupon_name() {
        return coupon_name;
    }

    public void setCoupon_name(String coupon_name) {
        this.coupon_name = coupon_name;
    }

    public String getCoupon_type() {
        return coupon_type;
    }

    public void setCoupon_type(String coupon_type) {
        this.coupon_type = coupon_type;
    }

    public int getCoupon_discount() {
        return coupon_discount;
    }

    public void setCoupon_discount(int coupon_discount) {
        this.coupon_discount = coupon_discount;
    }

    public int getCoupon_month() {
        return coupon_month;
    }

    public void setCoupon_month(int coupon_month) {
        this.coupon_month = coupon_month;
    }

    public String getCoupon_created_date() {
        return coupon_created_date;
    }

    public void setCoupon_created_date(String coupon_created_date) {
        this.coupon_created_date = coupon_created_date;
    }

    public String getCoupon_end_date() {
        return coupon_end_date;
    }

    public void setCoupon_end_date(String coupon_end_date) {
        this.coupon_end_date = coupon_end_date;
    }

    public String getCoupon_used_date() {
        return coupon_used_date;
    }

    public void setCoupon_used_date(String coupon_used_date) {
        this.coupon_used_date = coupon_used_date;
    }
}
