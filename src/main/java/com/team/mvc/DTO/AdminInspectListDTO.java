package com.team.mvc.DTO;

public class AdminInspectListDTO {


    private int equipCode;
    private String inspectName, equipName, categoryName, inspectList, adminId, inspectResult, inspectComment, inspectState;


    private Integer platformDeliveryId, platformDeliveryReturnId, equipGradeId;



    private int inspecItemId;
    private String inspecItemName;
    private String inspecItemDescHigh;
    private String inspecItemDescMid;
    private String inspecItemDescLow;
    private int inspecGradeId;
    private String inspecGradeName;
    private int inspecGradeDeduction;




    //getter setter구성

    public Integer getPlatformDeliveryId() {
        return platformDeliveryId;
    }

    public void setPlatformDeliveryId(Integer platformDeliveryId) {
        this.platformDeliveryId = platformDeliveryId;
    }

    public Integer getPlatformDeliveryReturnId() {
        return platformDeliveryReturnId;
    }

    public void setPlatformDeliveryReturnId(Integer platformDeliveryReturnId) {
        this.platformDeliveryReturnId = platformDeliveryReturnId;
    }

    public Integer getEquipGradeId() {
        return equipGradeId;
    }

    public void setEquipGradeId(Integer equipGradeId) {
        this.equipGradeId = equipGradeId;
    }


    public int getEquipCode() {
        return equipCode;
    }

    public void setEquipCode(int equipCode) {
        this.equipCode = equipCode;
    }

    public String getInspectName() {
        return inspectName;
    }

    public void setInspectName(String inspectName) {
        this.inspectName = inspectName;
    }

    public String getEquipName() {
        return equipName;
    }

    public void setEquipName(String equipName) {
        this.equipName = equipName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getInspectList() {
        return inspectList;
    }

    public void setInspectList(String inspectList) {
        this.inspectList = inspectList;
    }

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getInspectResult() {
        return inspectResult;
    }

    public void setInspectResult(String inspectResult) {
        this.inspectResult = inspectResult;
    }

    public String getInspectComment() {
        return inspectComment;
    }

    public void setInspectComment(String inspectComment) {
        this.inspectComment = inspectComment;
    }

    public String getInspectState() {
        return inspectState;
    }

    public void setInspectState(String inspectState) {
        this.inspectState = inspectState;
    }


    public int getInspecItemId() {
        return inspecItemId;
    }

    public void setInspecItemId(int inspecItemId) {
        this.inspecItemId = inspecItemId;
    }

    public String getInspecItemName() {
        return inspecItemName;
    }

    public void setInspecItemName(String inspecItemName) {
        this.inspecItemName = inspecItemName;
    }

    public String getInspecItemDescHigh() {
        return inspecItemDescHigh;
    }

    public void setInspecItemDescHigh(String inspecItemDescHigh) {
        this.inspecItemDescHigh = inspecItemDescHigh;
    }

    public String getInspecItemDescMid() {
        return inspecItemDescMid;
    }

    public void setInspecItemDescMid(String inspecItemDescMid) {
        this.inspecItemDescMid = inspecItemDescMid;
    }

    public String getInspecItemDescLow() {
        return inspecItemDescLow;
    }

    public void setInspecItemDescLow(String inspecItemDescLow) {
        this.inspecItemDescLow = inspecItemDescLow;
    }

    public int getInspecGradeId() {
        return inspecGradeId;
    }

    public void setInspecGradeId(int inspecGradeId) {
        this.inspecGradeId = inspecGradeId;
    }

    public String getInspecGradeName() {
        return inspecGradeName;
    }

    public void setInspecGradeName(String inspecGradeName) {
        this.inspecGradeName = inspecGradeName;
    }

    public int getInspecGradeDeduction() {
        return inspecGradeDeduction;
    }

    public void setInspecGradeDeduction(int inspecGradeDeduction) {
        this.inspecGradeDeduction = inspecGradeDeduction;
    }
}