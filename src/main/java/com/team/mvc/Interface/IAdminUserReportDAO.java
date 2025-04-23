package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminUserReportDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IAdminUserReportDAO {

    List<AdminUserReportDTO> getList();

    List<AdminUserReportDTO> getReportContent();
}
