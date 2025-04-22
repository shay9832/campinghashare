package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminDTO;

public interface IAdminService {
    // 관리자 ID로 관리자정보 조회
    AdminDTO getAdminById(String adminId);
}
