package com.team.mvc.Interface;

import com.team.mvc.DTO.BrandDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface IBrandDAO {
    List<BrandDTO> getBrands();

    List<BrandDTO> getBrandById(@Param("brandId") int brandId);

    List<BrandDTO> getBrandByName(@Param("brandName") String brandName);
}
