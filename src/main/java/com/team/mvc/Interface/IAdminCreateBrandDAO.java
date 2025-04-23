package com.team.mvc.Interface;

import com.team.mvc.DTO.BrandDTO;
import com.team.mvc.DTO.CategoryDTO;
import com.team.mvc.DTO.EquipmentDTO;

import java.util.List;

public interface IAdminCreateBrandDAO {

    // 브랜드 관련 메서드
    List<BrandDTO> getBrandList();
    BrandDTO getBrandById(int brandId);
    int insertBrand(BrandDTO brand);
    int updateBrand(BrandDTO brand);
    int deleteBrand(int brandId);

    // 장비명 관련 메서드
    List<EquipmentDTO> getEquipmentListByBrandId(int brandId);
    EquipmentDTO getEquipmentById(int equipNameId);
    int insertEquipment(EquipmentDTO equipment);
    int updateEquipment(EquipmentDTO equipment);
    int deleteEquipment(int equipNameId);

    // 브랜드 삭제 시 연관 장비명 삭제
    int deleteEquipmentByBrandId(int brandId);

    // 카테고리 관련 메서드
    List<CategoryDTO> getCategoryList();

}