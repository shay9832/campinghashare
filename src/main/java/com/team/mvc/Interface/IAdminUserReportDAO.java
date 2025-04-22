package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminUserReportDTO;

import java.util.List;

public interface IAdminUserReportDAO {

    List<AdminUserReportDTO> getList();

    List<AdminUserReportDTO> getReportContent();
}
