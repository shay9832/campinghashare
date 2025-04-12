package com.team.mvc.DTO;

import java.util.Date;

public class AdminCreateCouponDTO {

    private String adminId,couponName,couponDiscount,couponMonth;
    private int couponTypeId;
    private Date couponDate;



    //getter setter 구성

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getCouponName() {
        return couponName;
    }

    public void setCouponName(String couponName) {
        this.couponName = couponName;
    }

    public String getCouponDiscount() {
        return couponDiscount;
    }

    public void setCouponDiscount(String couponDiscount) {
        this.couponDiscount = couponDiscount;
    }

    public String getCouponMonth() {
        return couponMonth;
    }

    public void setCouponMonth(String couponMonth) {
        this.couponMonth = couponMonth;
    }

    public int getCouponTypeId() {
        return couponTypeId;
    }

    public void setCouponTypeId(int couponTypeId) {
        this.couponTypeId = couponTypeId;
    }

    public Date getCouponDate() {
        return couponDate;
    }

    public void setCouponDate(Date couponDate) {
        this.couponDate = couponDate;
    }
}
