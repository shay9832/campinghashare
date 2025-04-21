package com.team.mvc.DTO;

import java.util.Date;

public class AdminUserListDTO {

    private String userCode;        // 회원코드
    private String userId;          // 회원_ID
    private String userName;        // 회원_이름
    private String userTel;         // 회원_전화번호
    private String userEmail;       // 회원_이메일
    private String signupType;      // 가입유형
    private Date createdDate;       // 회원가입일
    private String currentNickname; // 현재_닉네임
    private String currentRank;     // 현재_등급
    private Integer totalPoints;    // 총_보유_포인트
    private Integer postCount;      // 게시물_수
    private Integer replyCount;     // 댓글_수
    private Integer bookmarkCount;  // 북마크_수
    private Integer recommendCount; // 추천_수
    private Integer equipmentCount; // 장비등록_수
    private Integer rentalCount;    // 렌탈_등록_수
    private Integer storenCount;    // 스토렌_등록_수
    private Integer storageCount;   // 보관_등록_수
    private Double avgSatisfactionScore; // 평균_만족도_점수
    private Integer couponCount;    // 보유_쿠폰_수
    private String currentAddress;  // 현재_주소
    private String currentDetailAddress; // 현재_상세주소
    private String userStatus;      // 회원_상태
    private Date exitDate;          // 탈퇴일자


    // Getter와 Setter 메서드
    public String getUserCode() {
        return userCode;
    }

    public void setUserCode(String userCode) {
        this.userCode = userCode;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserTel() {
        return userTel;
    }

    public void setUserTel(String userTel) {
        this.userTel = userTel;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getSignupType() {
        return signupType;
    }

    public void setSignupType(String signupType) {
        this.signupType = signupType;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getCurrentNickname() {
        return currentNickname;
    }

    public void setCurrentNickname(String currentNickname) {
        this.currentNickname = currentNickname;
    }

    public String getCurrentRank() {
        return currentRank;
    }

    public void setCurrentRank(String currentRank) {
        this.currentRank = currentRank;
    }

    public Integer getTotalPoints() {
        return totalPoints;
    }

    public void setTotalPoints(Integer totalPoints) {
        this.totalPoints = totalPoints;
    }

    public Integer getPostCount() {
        return postCount;
    }

    public void setPostCount(Integer postCount) {
        this.postCount = postCount;
    }

    public Integer getReplyCount() {
        return replyCount;
    }

    public void setReplyCount(Integer replyCount) {
        this.replyCount = replyCount;
    }

    public Integer getBookmarkCount() {
        return bookmarkCount;
    }

    public void setBookmarkCount(Integer bookmarkCount) {
        this.bookmarkCount = bookmarkCount;
    }

    public Integer getRecommendCount() {
        return recommendCount;
    }

    public void setRecommendCount(Integer recommendCount) {
        this.recommendCount = recommendCount;
    }

    public Integer getEquipmentCount() {
        return equipmentCount;
    }

    public void setEquipmentCount(Integer equipmentCount) {
        this.equipmentCount = equipmentCount;
    }

    public Integer getRentalCount() {
        return rentalCount;
    }

    public void setRentalCount(Integer rentalCount) {
        this.rentalCount = rentalCount;
    }

    public Integer getStorenCount() {
        return storenCount;
    }

    public void setStorenCount(Integer storenCount) {
        this.storenCount = storenCount;
    }

    public Integer getStorageCount() {
        return storageCount;
    }

    public void setStorageCount(Integer storageCount) {
        this.storageCount = storageCount;
    }

    public Double getAvgSatisfactionScore() {
        return avgSatisfactionScore;
    }

    public void setAvgSatisfactionScore(Double avgSatisfactionScore) {
        this.avgSatisfactionScore = avgSatisfactionScore;
    }

    public Integer getCouponCount() {
        return couponCount;
    }

    public void setCouponCount(Integer couponCount) {
        this.couponCount = couponCount;
    }

    public String getCurrentAddress() {
        return currentAddress;
    }

    public void setCurrentAddress(String currentAddress) {
        this.currentAddress = currentAddress;
    }

    public String getCurrentDetailAddress() {
        return currentDetailAddress;
    }

    public void setCurrentDetailAddress(String currentDetailAddress) {
        this.currentDetailAddress = currentDetailAddress;
    }

    public String getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(String userStatus) {
        this.userStatus = userStatus;
    }

    public Date getExitDate() {
        return exitDate;
    }

    public void setExitDate(Date exitDate) {
        this.exitDate = exitDate;
    }

}
