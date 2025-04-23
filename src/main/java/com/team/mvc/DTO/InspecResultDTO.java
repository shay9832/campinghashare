package com.team.mvc.DTO;

import java.util.Date;
import java.util.List;

public class InspecResultDTO {
    private int equipId;
    private String equipName;
    private String brandName;
    private int originalPrice;
    private String majorCategory;
    private String middleCategory;
    private String equipSize;
    private String gradeName;
    private Date inspectionDate; // 검수 날짜 필드
    private List<InspecItemDetail> itemList;

    public int getEquipId() { return equipId; }
    public void setEquipId(int equipId) { this.equipId = equipId; }

    public String getEquipName() { return equipName; }
    public void setEquipName(String equipName) { this.equipName = equipName; }

    public String getBrandName() { return brandName; }
    public void setBrandName(String brandName) { this.brandName = brandName; }

    public int getOriginalPrice() { return originalPrice; }
    public void setOriginalPrice(int originalPrice) { this.originalPrice = originalPrice; }

    public String getMajorCategory() { return majorCategory; }
    public void setMajorCategory(String majorCategory) { this.majorCategory = majorCategory; }

    public String getMiddleCategory() { return middleCategory; }
    public void setMiddleCategory(String middleCategory) { this.middleCategory = middleCategory; }

    public String getEquipSize() { return equipSize; }
    public void setEquipSize(String equipSize) { this.equipSize = equipSize; }

    public String getGradeName() { return gradeName; }
    public void setGradeName(String gradeName) { this.gradeName = gradeName; }

    public List<InspecItemDetail> getItemList() { return itemList; }
    public void setItemList(List<InspecItemDetail> itemList) { this.itemList = itemList; }

    public Date getInspectionDate() { return inspectionDate; }
    public void setInspectionDate(Date inspectionDate) { this.inspectionDate = inspectionDate; }

    public static class InspecItemDetail {
        private String itemName;
        private String gradeName;
        private int deduction;
        private String comment;
        private String inspecItemDescHigh;
        private String inspecItemDescMid;
        private String inspecItemDescLow;

        public String getItemName() { return itemName; }
        public void setItemName(String itemName) { this.itemName = itemName; }

        public String getGradeName() { return gradeName; }
        public void setGradeName(String gradeName) { this.gradeName = gradeName; }

        public int getDeduction() { return deduction; }
        public void setDeduction(int deduction) { this.deduction = deduction; }

        public String getComment() { return comment; }
        public void setComment(String comment) { this.comment = comment; }

        public String getInspecItemDescHigh() { return inspecItemDescHigh; }
        public void setInspecItemDescHigh(String inspecItemDescHigh) { this.inspecItemDescHigh = inspecItemDescHigh; }

        public String getInspecItemDescMid() { return inspecItemDescMid; }
        public void setInspecItemDescMid(String inspecItemDescMid) { this.inspecItemDescMid = inspecItemDescMid; }

        public String getInspecItemDescLow() { return inspecItemDescLow; }
        public void setInspecItemDescLow(String inspecItemDescLow) { this.inspecItemDescLow = inspecItemDescLow; }
    }
}