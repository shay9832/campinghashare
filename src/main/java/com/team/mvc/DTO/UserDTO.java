package com.team.mvc.DTO;

public class UserDTO {
    private int userCode;
    private String userId;
    private String password;
    private String userName;
    private String nickname;
    private String userTel;
    private String userEmail;               //이메일 추가(null일 때는 '미입력')
    private String emailConsent;            //이메일 수신동의 추가(1일 때만 '동의', 아닐 땐 '미동의')
    private int totalPoint;                 //현재 누적 포인트
    private int totalTrust;                 //현재 누적 신뢰도

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

    public int getUserCode() {
        return userCode;
    }

    public void setUserCode(int userCode) {
        this.userCode = userCode;
    }

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
}
