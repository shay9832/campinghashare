package com.team.mvc.Interface;

import org.apache.ibatis.annotations.Param;
import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.DTO.RegisterStorenDTO;

import java.util.ArrayList;

public interface IRegisterStorenDAO {

    /*select*/
    public ArrayList<RegisterStorenDTO> getList(int equip_code);

    RegisterStorenDTO getEquipInfo(int equip_code);

    public ArrayList<RegisterStorenDTO> list();

    // 장비명으로 평균 신품 가격 조회
    int getAvgNewPriceByEquipName(@Param("equipName") String equipName);

    // 장비명으로 평균 렌탈 가격 조회
    int getAvgRentalPriceByEquipName(@Param("equipName") String equipName);

}
