package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminMainDTO;
import com.team.mvc.DTO.AdminUserReportDTO;

import java.util.List;

public interface IAdminMainDAO {

    /*select*/
    public AdminMainDTO count();


    // admin-userReport 에서 신고된 게시물을 불러오기위한 메소드
}
