package com.team.mvc.DTO;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public class BrandDTO {
    private int brand_Id;
    private String brand_Name;

    public int getBrandId() {
        return brand_Id;
    }

    public void setBrandId(int brandId) {
        this.brand_Id = brandId;
    }

    public String getBrandName() {
        return brand_Name;
    }

    public void setBrandName(String brandName) {
        this.brand_Name = brandName;
    }
}
