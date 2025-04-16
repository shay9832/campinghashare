package com.team.mvc.DTO;

public class BrandDTO {
    private int brand_Id;
    private String brandName;
    private String reg_date;

    // 기본 생성자
    public BrandDTO() {
    }

    // getter, setter


    public int getBrand_Id() {
        return brand_Id;
    }

    public void setBrand_Id(int brand_Id) {
        this.brand_Id = brand_Id;
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