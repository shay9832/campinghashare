package com.team.mvc.DTO;

public class AdminDTO {

    private String adminId;   // ADMIN_ID (PK)
    private String adminPw;   // ADMIN_PW
    private String adminTel;  // ADMIN_TEL
    private int userCode;     // USER_CODE (FK)

    public AdminDTO() {}

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getAdminPw() {
        return adminPw;
    }

    public void setAdminPw(String adminPw) {
        this.adminPw = adminPw;
    }

    public String getAdminTel() {
        return adminTel;
    }

    public void setAdminTel(String adminTel) {
        this.adminTel = adminTel;
    }

    public int getUserCode() {
        return userCode;
    }

    public void setUserCode(int userCode) {
        this.userCode = userCode;
    }

    @Override
    public String toString() {
        return "AdminDTO{" +
                "adminId='" + adminId + '\'' +
                ", adminPw='" + adminPw + '\'' +
                ", adminTel='" + adminTel + '\'' +
                ", userCode=" + userCode +
                '}';
    }
}
