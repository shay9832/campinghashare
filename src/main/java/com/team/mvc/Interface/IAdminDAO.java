package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminDTO;
import org.apache.ibatis.annotations.Param;

public interface IAdminDAO {

    // 로그인 처리용 (ID + PW)
    AdminDTO getAdminByIdAndPw(AdminDTO dto);

    // 관리자 ID로 정보 조회
    AdminDTO getAdminById(String adminId);

    // 관리자 등록
    void insertAdmin(AdminDTO dto);

    // USER_CODE 시퀀스 조회
    int getNextUserCode();

    // 가입 시 유저 코드 삽입
    void insertUserCode(int userCode);

    // 중복 ID 확인
    int getAdminCountById(String adminId);
}
