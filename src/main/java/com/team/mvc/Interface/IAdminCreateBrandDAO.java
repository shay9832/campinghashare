package com.team.mvc.Interface;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.team.mvc.DTO.BrandDTO;
import com.team.mvc.DTO.CategoryDTO;
import com.team.mvc.DTO.EquipmentDTO;

/**
 * 브랜드 및 장비명 관리를 위한 DAO 클래스
 */
@Repository
public class IAdminCreateBrandDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.team.mvc.Interface.IAdminCreateBrandDAO";

    // 브랜드 관련 메서드
    /**
     * 모든 브랜드 목록을 조회
     */
    public List<BrandDTO> getBrandList() {
        return sqlSession.selectList(NAMESPACE + ".getBrandList");
    }

    /**
     * 특정 브랜드 ID로 브랜드 정보 조회
     */
    public BrandDTO getBrandById(int brandId) {
        return sqlSession.selectOne(NAMESPACE + ".getBrandById", brandId);
    }

    /**
     * 새로운 브랜드 등록
     */
    public int insertBrand(BrandDTO brand) {
        return sqlSession.insert(NAMESPACE + ".insertBrand", brand);
    }

    /**
     * 기존 브랜드 정보 수정
     */
    public int updateBrand(BrandDTO brand) {
        return sqlSession.update(NAMESPACE + ".updateBrand", brand);
    }

    /**
     * 브랜드 삭제
     */
    public int deleteBrand(int brandId) {
        return sqlSession.delete(NAMESPACE + ".deleteBrand", brandId);
    }

    // 장비명 관련 메서드
    /**
     * 특정 브랜드에 속한 장비명 목록 조회
     */
    public List<EquipmentDTO> getEquipmentListByBrandId(int brandId) {
        return sqlSession.selectList(NAMESPACE + ".getEquipmentListByBrandId", brandId);
    }

    /**
     * 특정 장비명 ID로 장비 정보 조회
     */
    public EquipmentDTO getEquipmentById(int equipNameId) {
        return sqlSession.selectOne(NAMESPACE + ".getEquipmentById", equipNameId);
    }

    /**
     * 새로운 장비명 등록
     */
    public int insertEquipment(EquipmentDTO equipment) {
        return sqlSession.insert(NAMESPACE + ".insertEquipment", equipment);
    }

    /**
     * 기존 장비명 정보 수정
     */
    public int updateEquipment(EquipmentDTO equipment) {
        return sqlSession.update(NAMESPACE + ".updateEquipment", equipment);
    }

    /**
     * 장비명 삭제
     */
    public int deleteEquipment(int equipNameId) {
        return sqlSession.delete(NAMESPACE + ".deleteEquipment", equipNameId);
    }

    // 카테고리 관련 메서드
    /**
     * 모든 카테고리 목록 조회
     */
    public List<CategoryDTO> getCategoryList() {
        return sqlSession.selectList(NAMESPACE + ".getCategoryList");
    }

    /**
     * 특정 부모 카테고리에 속한 하위 카테고리 목록 조회
     */
    public List<CategoryDTO> getSubCategoriesByParentId(int parentCategoryId) {
        return sqlSession.selectList(NAMESPACE + ".getSubCategoriesByParentId", parentCategoryId);
    }
}