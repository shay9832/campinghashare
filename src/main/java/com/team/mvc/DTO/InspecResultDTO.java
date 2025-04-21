// InspecResultDTO.java
package com.team.mvc.DTO;

public class InspecResultDTO {
    private String storenId;
    private String equipmentCategory;
    private String equipmentSubCategory;
    private String brand;
    private String equipmentName;
    private String equipmentSize;
    private String inspectionDate;
    private String equipmentGrade;

    private String inspecItemName;
    private String inspectComment;
    private String inspectResult;
    private int inspecGradeDeduction;

    private String inspecItemDescHigh;
    private String inspecItemDescMid;
    private String inspecItemDescLow;

    private String inspecType;
    private int equipCode;
    private int totalScore;

    public String getStorenId() {
        return storenId;
    }

    public void setStorenId(String storenId) {
        this.storenId = storenId;
    }

    public String getEquipmentCategory() {
        return equipmentCategory;
    }

    public void setEquipmentCategory(String equipmentCategory) {
        this.equipmentCategory = equipmentCategory;
    }

    public String getEquipmentSubCategory() {
        return equipmentSubCategory;
    }

    public void setEquipmentSubCategory(String equipmentSubCategory) {
        this.equipmentSubCategory = equipmentSubCategory;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getEquipmentName() {
        return equipmentName;
    }

    public void setEquipmentName(String equipmentName) {
        this.equipmentName = equipmentName;
    }

    public String getEquipmentSize() {
        return equipmentSize;
    }

    public void setEquipmentSize(String equipmentSize) {
        this.equipmentSize = equipmentSize;
    }

    public String getInspectionDate() {
        return inspectionDate;
    }

    public void setInspectionDate(String inspectionDate) {
        this.inspectionDate = inspectionDate;
    }

    public String getEquipmentGrade() {
        return equipmentGrade;
    }

    public void setEquipmentGrade(String equipmentGrade) {
        this.equipmentGrade = equipmentGrade;
    }

    public String getInspecItemName() {
        return inspecItemName;
    }

    public void setInspecItemName(String inspecItemName) {
        this.inspecItemName = inspecItemName;
    }

    public String getInspectComment() {
        return inspectComment;
    }

    public void setInspectComment(String inspectComment) {
        this.inspectComment = inspectComment;
    }

    public String getInspectResult() {
        return inspectResult;
    }

    public void setInspectResult(String inspectResult) {
        this.inspectResult = inspectResult;
    }

    public int getInspecGradeDeduction() {
        return inspecGradeDeduction;
    }

    public void setInspecGradeDeduction(int inspecGradeDeduction) {
        this.inspecGradeDeduction = inspecGradeDeduction;
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

    public String getInspecType() {
        return inspecType;
    }

    public void setInspecType(String inspecType) {
        this.inspecType = inspecType;
    }

    public int getEquipCode() {
        return equipCode;
    }

    public void setEquipCode(int equipCode) {
        this.equipCode = equipCode;
    }


    public int getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(int totalScore) {
        this.totalScore = totalScore;
    }
}