package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminDTO;

public interface IAdminDAO {

    // 로그인 처리용 (ID + PW)
    AdminDTO getAdminByIdAndPw(AdminDTO dto);

    // 관리자 등록
    void insertAdmin(AdminDTO dto);

    // USER_CODE 시퀀스 조회
    int getNextUserCode();

    // 중복 ID 확인
    int getAdminCountById(String adminId);
}
