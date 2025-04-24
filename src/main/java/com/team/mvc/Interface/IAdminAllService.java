package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminMainDTO;
import com.team.mvc.DTO.AdminUserReportDTO;

import java.util.List;

public interface IAdminAllService {


    List<AdminUserReportDTO> getList();

    AdminMainDTO count();


}
