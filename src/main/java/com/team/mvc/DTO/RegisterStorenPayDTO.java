package com.team.mvc.DTO;

public class RegisterStorenPayDTO {

    private String userName;     // U.USER_NAME AS userName
    private String userTel;      // U.USER_TEL AS userTel
    private String zipcode;      // A.ZIPCODE AS zipcode
    private String address1;     // A.ADDRESS1 AS address1
    private String address2;     // A.ADDRESS2 AS address2

    // getter/setter
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getUserTel() { return userTel; }
    public void setUserTel(String userTel) { this.userTel = userTel; }

    public String getZipcode() { return zipcode; }
    public void setZipcode(String zipcode) { this.zipcode = zipcode; }

    public String getAddress1() { return address1; }
    public void setAddress1(String address1) { this.address1 = address1; }

    public String getAddress2() { return address2; }
    public void setAddress2(String address2) { this.address2 = address2; }
}
