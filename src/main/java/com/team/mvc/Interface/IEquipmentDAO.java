package com.team.mvc.Interface;

import com.team.mvc.DTO.EquipmentDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.List;

@Mapper
public interface IEquipmentDAO {

    int insertEquipCode(EquipmentDTO dto);


    List<String> listEquipNamesByBrand(@Param("brandId") int brandId);

    // 장비명 ID 조회
    Integer getEquipNameId(@Param("brandId") int brandId, @Param("equipName") String equipName);

    int insertEquipmentRegistration(EquipmentDTO dto);

    // 회원코드로 장비 리스트 조회 (해당 회원이 가진 일반 장비 리스트)
    ArrayList<EquipmentDTO> listByUserCode(int user_code);

    // 장비명id로 장비명 검색
    String getEquipNameById(int equip_name_id);
}
