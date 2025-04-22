package com.team.mvc.DTO;

import java.util.Date;

public class AdminMainDTO {

        // 회원 관련
        private Integer newUserCount;
        private Integer totalUserCount;

        // 결제 관련
        private Integer storenPaymentCount;
        private Integer storenPaymentAmount;
        private Integer storagePaymentCount;
        private Integer storagePaymentAmount;
        private Integer rentalPaymentCount;
        private Integer rentalPaymentAmount;

        // 합계
        private Integer totalPaymentCount;
        private Integer totalPaymentAmount;

        // 검수 관련
        private Integer inspectionCount;

        // 신고 관련
        private Integer postReportCount;
        private Integer commentReportCount;
        private Integer rentalCommentReportCount;
        private Integer totalReportCount;

        // 집계 일자
        private String statsDate;



        //getter setter 구성

    public Integer getNewUserCount() {
        return newUserCount;
    }

    public void setNewUserCount(Integer newUserCount) {
        this.newUserCount = newUserCount;
    }

    public Integer getTotalUserCount() {
        return totalUserCount;
    }

    public void setTotalUserCount(Integer totalUserCount) {
        this.totalUserCount = totalUserCount;
    }

    public Integer getStorenPaymentCount() {
        return storenPaymentCount;
    }

    public void setStorenPaymentCount(Integer storenPaymentCount) {
        this.storenPaymentCount = storenPaymentCount;
    }

    public Integer getStorenPaymentAmount() {
        return storenPaymentAmount;
    }

    public void setStorenPaymentAmount(Integer storenPaymentAmount) {
        this.storenPaymentAmount = storenPaymentAmount;
    }

    public Integer getStoragePaymentCount() {
        return storagePaymentCount;
    }

    public void setStoragePaymentCount(Integer storagePaymentCount) {
        this.storagePaymentCount = storagePaymentCount;
    }

    public Integer getStoragePaymentAmount() {
        return storagePaymentAmount;
    }

    public void setStoragePaymentAmount(Integer storagePaymentAmount) {
        this.storagePaymentAmount = storagePaymentAmount;
    }

    public Integer getRentalPaymentCount() {
        return rentalPaymentCount;
    }

    public void setRentalPaymentCount(Integer rentalPaymentCount) {
        this.rentalPaymentCount = rentalPaymentCount;
    }

    public Integer getRentalPaymentAmount() {
        return rentalPaymentAmount;
    }

    public void setRentalPaymentAmount(Integer rentalPaymentAmount) {
        this.rentalPaymentAmount = rentalPaymentAmount;
    }

    public Integer getTotalPaymentCount() {
        return totalPaymentCount;
    }

    public void setTotalPaymentCount(Integer totalPaymentCount) {
        this.totalPaymentCount = totalPaymentCount;
    }

    public Integer getTotalPaymentAmount() {
        return totalPaymentAmount;
    }

    public void setTotalPaymentAmount(Integer totalPaymentAmount) {
        this.totalPaymentAmount = totalPaymentAmount;
    }

    public Integer getInspectionCount() {
        return inspectionCount;
    }

    public void setInspectionCount(Integer inspectionCount) {
        this.inspectionCount = inspectionCount;
    }

    public Integer getPostReportCount() {
        return postReportCount;
    }

    public void setPostReportCount(Integer postReportCount) {
        this.postReportCount = postReportCount;
    }

    public Integer getCommentReportCount() {
        return commentReportCount;
    }

    public void setCommentReportCount(Integer commentReportCount) {
        this.commentReportCount = commentReportCount;
    }

    public Integer getRentalCommentReportCount() {
        return rentalCommentReportCount;
    }

    public void setRentalCommentReportCount(Integer rentalCommentReportCount) {
        this.rentalCommentReportCount = rentalCommentReportCount;
    }

    public Integer getTotalReportCount() {
        return totalReportCount;
    }

    public void setTotalReportCount(Integer totalReportCount) {
        this.totalReportCount = totalReportCount;
    }

    public String getStatsDate() {
        return statsDate;
    }

    public void setStatsDate(String statsDate) {
        this.statsDate = statsDate;
    }
}
