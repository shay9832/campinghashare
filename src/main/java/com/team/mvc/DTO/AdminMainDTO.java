package com.team.mvc.DTO;

import java.util.Date;

public class AdminMainDTO {

        // 회원 관련
        private int newUserCount;
        private int totalUserCount;

        // 결제 관련
        private int storenPaymentCount;
        private long storenPaymentAmount;
        private int storagePaymentCount;
        private long storagePaymentAmount;
        private int rentalPaymentCount;
        private long rentalPaymentAmount;

        // 합계
        private int totalPaymentCount;
        private long totalPaymentAmount;

        // 검수 관련
        private int inspectionCount;

        // 신고 관련
        private int postReportCount;
        private int commentReportCount;
        private int rentalCommentReportCount;
        private int totalReportCount;

        // 집계 일자
        private Date statsDate;

        public int getNewUserCount() {
            return newUserCount;
        }

        public void setNewUserCount(int newUserCount) {
            this.newUserCount = newUserCount;
        }

        public int getTotalUserCount() {
            return totalUserCount;
        }

        public void setTotalUserCount(int totalUserCount) {
            this.totalUserCount = totalUserCount;
        }

        public int getStorenPaymentCount() {
            return storenPaymentCount;
        }

        public void setStorenPaymentCount(int storenPaymentCount) {
            this.storenPaymentCount = storenPaymentCount;
        }

        public long getStorenPaymentAmount() {
            return storenPaymentAmount;
        }

        public void setStorenPaymentAmount(long storenPaymentAmount) {
            this.storenPaymentAmount = storenPaymentAmount;
        }

        public int getStoragePaymentCount() {
            return storagePaymentCount;
        }

        public void setStoragePaymentCount(int storagePaymentCount) {
            this.storagePaymentCount = storagePaymentCount;
        }

        public long getStoragePaymentAmount() {
            return storagePaymentAmount;
        }

        public void setStoragePaymentAmount(long storagePaymentAmount) {
            this.storagePaymentAmount = storagePaymentAmount;
        }

        public int getRentalPaymentCount() {
            return rentalPaymentCount;
        }

        public void setRentalPaymentCount(int rentalPaymentCount) {
            this.rentalPaymentCount = rentalPaymentCount;
        }

        public long getRentalPaymentAmount() {
            return rentalPaymentAmount;
        }

        public void setRentalPaymentAmount(long rentalPaymentAmount) {
            this.rentalPaymentAmount = rentalPaymentAmount;
        }

        public int getTotalPaymentCount() {
            return totalPaymentCount;
        }

        public void setTotalPaymentCount(int totalPaymentCount) {
            this.totalPaymentCount = totalPaymentCount;
        }

        public long getTotalPaymentAmount() {
            return totalPaymentAmount;
        }

        public void setTotalPaymentAmount(long totalPaymentAmount) {
            this.totalPaymentAmount = totalPaymentAmount;
        }

        public int getInspectionCount() {
            return inspectionCount;
        }

        public void setInspectionCount(int inspectionCount) {
            this.inspectionCount = inspectionCount;
        }

        public int getPostReportCount() {
            return postReportCount;
        }

        public void setPostReportCount(int postReportCount) {
            this.postReportCount = postReportCount;
        }

        public int getCommentReportCount() {
            return commentReportCount;
        }

        public void setCommentReportCount(int commentReportCount) {
            this.commentReportCount = commentReportCount;
        }

        public int getRentalCommentReportCount() {
            return rentalCommentReportCount;
        }

        public void setRentalCommentReportCount(int rentalCommentReportCount) {
            this.rentalCommentReportCount = rentalCommentReportCount;
        }

        public int getTotalReportCount() {
            return totalReportCount;
        }

        public void setTotalReportCount(int totalReportCount) {
            this.totalReportCount = totalReportCount;
        }

        public Date getStatsDate() {
            return statsDate;
        }

        public void setStatsDate(Date statsDate) {
            this.statsDate = statsDate;
        }
    }
