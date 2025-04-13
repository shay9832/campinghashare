package com.team.mvc.DTO;

import java.util.Date;

public class AdminMatchingListDTO {

//    "장비_코드", "스토렌_제목", "스토렌매칭신청자코드", "렌탈_시작일", "렌탈_종료일", "매칭신청일", "승인여부", "승인_일자"

    private int storenId,rentalId,equipCode,storenMatchingReq,rentalMatchingReq;
    private String storenTitle,rentalTitle,approveStatus;
    private Date rentalStart,rentalEnd,matchingStart,approveDate;



    //getter setter 적용


    public int getRentalId() {
        return rentalId;
    }

    public void setRentalId(int rentalId) {
        this.rentalId = rentalId;
    }

    public int getRentalMatchingReq() {
        return rentalMatchingReq;
    }

    public void setRentalMatchingReq(int rentalMatchingReq) {
        this.rentalMatchingReq = rentalMatchingReq;
    }

    public String getRentalTitle() {
        return rentalTitle;
    }

    public void setRentalTitle(String rentalTitle) {
        this.rentalTitle = rentalTitle;
    }

    public int getStorenId() {
        return storenId;
    }

    public void setStorenId(int storenId) {
        this.storenId = storenId;
    }

    public int getEquipCode() {
        return equipCode;
    }

    public void setEquipCode(int equipCode) {
        this.equipCode = equipCode;
    }

    public int getStorenMatchingReq() {
        return storenMatchingReq;
    }

    public void setStorenMatchingReq(int storenMatchingReq) {
        this.storenMatchingReq = storenMatchingReq;
    }

    public String getStorenTitle() {
        return storenTitle;
    }

    public void setStorenTitle(String storenTitle) {
        this.storenTitle = storenTitle;
    }

    public String getApproveStatus() {
        return approveStatus;
    }

    public void setApproveStatus(String approveStatus) {
        this.approveStatus = approveStatus;
    }

    public Date getRentalStart() {
        return rentalStart;
    }

    public void setRentalStart(Date rentalStart) {
        this.rentalStart = rentalStart;
    }

    public Date getRentalEnd() {
        return rentalEnd;
    }

    public void setRentalEnd(Date rentalEnd) {
        this.rentalEnd = rentalEnd;
    }

    public Date getMatchingStart() {
        return matchingStart;
    }

    public void setMatchingStart(Date matchingStart) {
        this.matchingStart = matchingStart;
    }

    public Date getApproveDate() {
        return approveDate;
    }

    public void setApproveDate(Date approveDate) {
        this.approveDate = approveDate;
    }
}
