package com.team.mvc.Interface;

import com.team.mvc.DTO.MyRentEquipDTO;


public interface IMypageRentEquipService {
    // 내가 대여한 장비 - 스토렌 탭에서 필요한 정보를 따로 정의한 상위 DTO로 반환하는 메소드
    MyRentEquipDTO listRentStorenInfo(int userCode);
}
