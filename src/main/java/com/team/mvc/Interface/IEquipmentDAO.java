package com.team.mvc.Interface;

import com.team.mvc.DTO.EquipmentDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IEquipmentDAO {

    int insertEquipCode();

    int getLastEquipId();

    int addEquipment(EquipmentDTO dto);

    // 장비명 검색
    Integer searchEquipNameId(@Param("brandId") int brandId, @Param("equipName") String equipName);

    // 브랜드가 '기타'일 경우
    Integer insertEquip(@Param("brandId") int brandId, @Param("equipName") String equipName);

    Integer searchCategoryId(@Param("majorCategory") int majorCategory, @Param("middleCategory") String middleCategory);
}
