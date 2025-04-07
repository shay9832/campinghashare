package com.team.mvc.Interface;

import com.team.mvc.DTO.CategoryDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface ICategoryDAO {
    // 대분류 카테고리 목록 조회
    List<CategoryDTO> getMajorCategory();

    // 중분류 카테고리 목록 조회
    List<CategoryDTO> getMiddleCategory(@Param("parentCategoryId") int parentCategoryId);

    // 카테고리 ID로 카테고리 정보 조회
    List<CategoryDTO> getCategoryById(@Param("categoryId") int categoryId);

    // 카테고리 이름으로 카테고리 정보 조회
    List<CategoryDTO> getCategoryByName(@Param("categoryName") String categoryName);
}
