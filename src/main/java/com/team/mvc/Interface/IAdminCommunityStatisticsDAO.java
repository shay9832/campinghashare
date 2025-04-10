package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminCommunityStatisticsDTO;

import java.util.List;

public interface IAdminCommunityStatisticsDAO {

    /*select*/
    List<AdminCommunityStatisticsDTO> getList();
}
