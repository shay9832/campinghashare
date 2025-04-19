package com.team.mvc.DTO;

public class BrandDTO {
    private int brandId;
    private String brandName;
    private String reg_date;

    // 기본 생성자
    public BrandDTO() {
    }

    // getter, setter


    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getReg_date() {
        return reg_date;
    }

    public void setReg_date(String reg_date) {
        this.reg_date = reg_date;
    }
}