package com.team.mvc.Interface;

import com.team.mvc.DTO.EquipmentDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;

@Mapper
public interface IEquipmentDAO {

    int insertEquipCode();

    int getLastEquipId();

    int insertEquipment(EquipmentDTO dto);

    // 브랜드가 '기타'일 경우
    Integer insertEquip(@Param("brandId") int brandId, @Param("equipName") String equipName);

    Integer searchCategoryId(@Param("majorCategory") int majorCategory, @Param("middleCategory") String middleCategory);




    // 회원코드로 장비 리스트 조회 (해당 회원이 가진 일반 장비 리스트)
    ArrayList<EquipmentDTO> listByUserCode(int user_code);

    // 장비명id로 장비명 검색
    String getEquipNameById(int equip_name_id);

}
