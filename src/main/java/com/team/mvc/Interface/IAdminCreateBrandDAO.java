package com.team.mvc.Interface;

import com.team.mvc.DTO.BrandDTO;
import com.team.mvc.DTO.CategoryDTO;
import com.team.mvc.DTO.EquipmentDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 브랜드 및 장비명 관리를 위한 DAO 클래스
 */
@Mapper
public interface IAdminCreateBrandDAO {

    // 브랜드 관련 메서드
    /**
     * 모든 브랜드 목록을 조회
     */
    List<BrandDTO> getBrandList();

    /**
     * 특정 브랜드 ID로 브랜드 정보 조회
     */
    BrandDTO getBrandById(@Param("brandId") int brandId);

    /**
     * 새로운 브랜드 등록
     */
    int insertBrand(BrandDTO brand);

    /**
     * 기존 브랜드 정보 수정
     */
    int updateBrand(BrandDTO brand);

    /**
     * 브랜드 삭제
     */
    int deleteBrand(@Param("brandId") int brandId);

    // 장비명 관련 메서드
    /**
     * 특정 브랜드에 속한 장비명 목록 조회
     */
    List<EquipmentDTO> getEquipmentListByBrandId(@Param("brandId") int brandId);

    /**
     * 특정 장비명 ID로 장비 정보 조회
     */
    EquipmentDTO getEquipmentById(@Param("equip_name_id") int equipNameId);

    /**
     * 새로운 장비명 등록
     */
    int insertEquipment(EquipmentDTO equipment);

    /**
     * 기존 장비명 정보 수정
     */
    int updateEquipment(EquipmentDTO equipment);

    /**
     * 장비명 삭제
     */
    int deleteEquipment(@Param("equip_name_id") int equipNameId);

    // 카테고리 관련 메서드
    /**
     * 모든 카테고리 목록 조회
     */
    List<CategoryDTO> getCategoryList();

    /**
     * 특정 부모 카테고리에 속한 하위 카테고리 목록 조회
     */
    List<CategoryDTO> getSubCategoriesByParentId(@Param("parent_category_id") int parentCategoryId);
}
