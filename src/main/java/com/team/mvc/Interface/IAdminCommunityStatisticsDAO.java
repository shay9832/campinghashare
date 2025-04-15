package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminCommunityStatisticsDTO;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

public interface IAdminCommunityStatisticsDAO {

    /*select*/
    List<AdminCommunityStatisticsDTO> getList();

}
