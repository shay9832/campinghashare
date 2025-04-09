package com.team.mvc.Interface;

import com.team.mvc.DTO.EquipmentDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface IEquipmentDAO {

    int insertEquipCode(EquipmentDTO dto);

    // 장비명 ID 조회
    Integer getEquipNameId(@Param("brandId") int brandId, @Param("equipName") String equipName);

    int insertEquipmentRegistration(EquipmentDTO dto);
}
