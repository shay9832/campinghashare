package com.team.mvc.DTO;

import java.util.Date;

public class AdminCreateCouponDTO {

    // 쿠폰 생성을 위한 DTO
    private String adminId,couponName,couponMonth,issuedDate;
    private Integer couponDiscount,couponTypeId,issuedCouponId;


    //쿠폰 타입을 받기위한 DTO
    private String couponTypeName;



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

    public Integer getCouponDiscount() {
        return couponDiscount;
    }

    public void setCouponDiscount(Integer couponDiscount) {
        this.couponDiscount = couponDiscount;
    }

    public String getCouponMonth() {
        return couponMonth;
    }

    public void setCouponMonth(String couponMonth) {
        this.couponMonth = couponMonth;
    }

    public String getIssuedDate() {
        return issuedDate;
    }

    public void setIssuedDate(String issuedDate) {
        this.issuedDate = issuedDate;
    }

    public Integer getCouponTypeId() {
        return couponTypeId;
    }

    public void setCouponTypeId(Integer couponTypeId) {
        this.couponTypeId = couponTypeId;
    }

    public Integer getIssuedCouponId() {
        return issuedCouponId;
    }

    public void setIssuedCouponId(Integer issuedCouponId) {
        this.issuedCouponId = issuedCouponId;
    }

    public String getCouponTypeName() {
        return couponTypeName;
    }

    public void setCouponTypeName(String couponTypeName) {
        this.couponTypeName = couponTypeName;
    }
}
