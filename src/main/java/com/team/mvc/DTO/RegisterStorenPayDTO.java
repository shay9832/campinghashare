package com.team.mvc.DTO;

public class RegisterStorenPayDTO {
    private int equipCode;
    private int userCode;
    private String equipSize;
    private int storageDays;
    private int finalStorageCost;
    private String userName;
    private String userTel;
    private String zipcode;
    private String address1;
    private String address2;
    private int storenId;

    public String getAddress2() {
        return address2;
    }

    public void setAddress2(String address2) {
        this.address2 = address2;
    }

    public String getAddress1() {
        return address1;
    }

    public void setAddress1(String address1) {
        this.address1 = address1;
    }

    public String getZipcode() {
        return zipcode;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public String getUserTel() {
        return userTel;
    }

    public void setUserTel(String userTel) {
        this.userTel = userTel;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getFinalStorageCost() {
        return finalStorageCost;
    }

    public void setFinalStorageCost(int finalStorageCost) {
        this.finalStorageCost = finalStorageCost;
    }

    public int getStorageDays() {
        return storageDays;
    }

    public void setStorageDays(int storageDays) {
        this.storageDays = storageDays;
    }

    public String getEquipSize() {
        return equipSize;
    }

    public void setEquipSize(String equipSize) {
        this.equipSize = equipSize;
    }

    public int getUserCode() {
        return userCode;
    }

    public void setUserCode(int userCode) {
        this.userCode = userCode;
    }

    public int getEquipCode() {
        return equipCode;
    }

    public void setEquipCode(int equipCode) {
        this.equipCode = equipCode;
    }

    public int getStorenId() {
        return storenId;
    }

    public void setStorenId(int storenId) {
        this.storenId = storenId;
    }
}