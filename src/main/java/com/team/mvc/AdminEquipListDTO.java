package com.team.mvc;

public class AdminEquipListDTO {

    //장비코드,장비유형,장비명,소유자명,카테고리명,장비상태

    public int getEquipCode() {
        return equipCode;
    }

    public void setEquipCode(int equipCode) {
        this.equipCode = equipCode;
    }

    public String getEquipType() {
        return equipType;
    }

    public void setEquipType(String equipType) {
        this.equipType = equipType;
    }

    public String getEquipName() {
        return equipName;
    }

    public void setEquipName(String equipName) {
        this.equipName = equipName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName;
    }

    public String getEquipCondition() {
        return equipCondition;
    }

    public void setEquipCondition(String equipCondition) {
        this.equipCondition = equipCondition;
    }

    private int equipCode;
    private String equipType,equipName,userName,cateName,equipCondition;
}
