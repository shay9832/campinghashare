package com.team.mvc.DTO;

public class UserDTO {
    private Integer userCode;
    private String userId;
    private String password;
    private String userName;
    private String nickname;
    private String userTel;
    private String userEmail;               //이메일 추가(null일 때는 '미입력')
    private String emailConsent;            //이메일 수신동의 추가(1일 때만 '동의', 아닐 땐 '미동의')
    private int totalPoint;                 //현재 누적 포인트
    private int totalTrust;                 //현재 누적 신뢰도
    private String zipCode;                 //우편번호
    private String address1;                //주소1
    private String address2;                //주소2 (주소 상세)
    private String adminId;
    private boolean admin;

    private String userGrade;               //회원 등급
    private int nicknameChange;             //닉네임 변경 횟수
    private int totalProfit;                //총 수익

    public UserDTO() {}

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getUserTel() {
        return userTel;
    }

    public void setUserTel(String userTel) {
        this.userTel = userTel;
    }

    public Integer getUserCode() { return userCode; }

    public void setUserCode(Integer userCode) { this.userCode = userCode; }

    @Override
    public String toString() {
        return "UserDTO{" +
                "userId='" + userId + '\'' +
                ", password='" + password + '\'' +
                ", userName='" + userName + '\'' +
                ", nickname='" + nickname + '\'' +
                ", userTel='" + userTel + '\'' +
                ", userCode=" + userCode +
                '}';
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getEmailConsent() {
        return emailConsent;
    }

    public void setEmailConsent(String emailConsent) {
        this.emailConsent = emailConsent;
    }

    public int getTotalPoint() {
        return totalPoint;
    }

    public void setTotalPoint(int totalPoint) {
        this.totalPoint = totalPoint;
    }

    public int getTotalTrust() {
        return totalTrust;
    }

    public void setTotalTrust(int totalTrust) {
        this.totalTrust = totalTrust;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public boolean isAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }

    public String getUserGrade() {
        return userGrade;
    }

    public void setUserGrade(String userGrade) {
        this.userGrade = userGrade;
    }

    public int getNicknameChange() {
        return nicknameChange;
    }

    public void setNicknameChange(int nicknameChange) {
        this.nicknameChange = nicknameChange;
    }

    public int getTotalProfit() {
        return totalProfit;
    }

    public void setTotalProfit(int totalProfit) {
        this.totalProfit = totalProfit;
    }
}
