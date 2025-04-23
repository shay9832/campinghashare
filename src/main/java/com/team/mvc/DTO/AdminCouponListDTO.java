package com.team.mvc.DTO;

import java.util.Date;

public class AdminCouponListDTO {

    private Integer ownedCouponId;   // 보유쿠폰ID
    private String userCode;        // 회원코드
    private String nickname;        // 회원닉네임
    private String couponName;      // 쿠폰이름
    private String couponTypeName;  // 쿠폰종류
    private Integer couponDiscount; // 쿠폰할인율
    private Integer couponMonth;    // 쿠폰유효개월수
    private Date issuedDate;      // 쿠폰발행일
    private Date expiryDate;      // 쿠폰만료일
    private Date completedDate;   // 쿠폰사용완료일


    //쿠폰
    public Integer couponTypeId;   // 쿠폰 종류 ID


    //getter setter 구성


    public Integer getOwnedCouponId() {
        return ownedCouponId;
    }

    public void setOwnedCouponId(Integer ownedCouponId) {
        this.ownedCouponId = ownedCouponId;
    }

    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getCouponName() {
        return couponName;
    }

    public void setCouponName(String couponName) {
        this.couponName = couponName;
    }

    public String getCouponTypeName() {
        return couponTypeName;
    }

    public void setCouponTypeName(String couponTypeName) {
        this.couponTypeName = couponTypeName;
    }

    public Integer getCouponDiscount() {
        return couponDiscount;
    }

    public void setCouponDiscount(Integer couponDiscount) {
        this.couponDiscount = couponDiscount;
    }

    public Integer getCouponMonth() {
        return couponMonth;
    }

    public void setCouponMonth(Integer couponMonth) {
        this.couponMonth = couponMonth;
    }

    public Date getIssuedDate() {
        return issuedDate;
    }

    public void setIssuedDate(Date issuedDate) {
        this.issuedDate = issuedDate;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public Date getCompletedDate() {
        return completedDate;
    }

    public void setCompletedDate(Date completedDate) {
        this.completedDate = completedDate;
    }

    public Integer getCouponTypeId() {
        return couponTypeId;
    }

    public void setCouponTypeId(Integer couponTypeId) {
        this.couponTypeId = couponTypeId;
    }
}
