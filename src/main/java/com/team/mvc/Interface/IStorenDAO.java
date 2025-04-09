package com.team.mvc.Interface;

import com.team.mvc.DTO.StorenDTO;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;

public interface IStorenDAO {
    // 회원코드로 스토렌 장비 리스트 조회 (해당 회원이 가진 스토렌 장비 리스트)
    ArrayList<StorenDTO> listByUserCode(@Param("user_code") int user_code);

    // 회원코드와 장비코드로 스토렌 장비 리스트 조회
    ArrayList<StorenDTO> listByUserCodeEquipCode(@Param("user_code") int user_code, @Param("equip_code") int equip_code);

    // 처음 스토렌 신청했을 때의 스토렌 정보 가져오기
    StorenDTO getStorenByEquipCode(@Param("user_code") int user_code, @Param("equip_code") int equip_code);
}
