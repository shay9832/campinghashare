package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminBoardUpdateDTO;

import java.util.List;

public interface IAdminBoardUpdateDAO {

    /*select*/
    List<AdminBoardUpdateDTO> getBoardList();
    List<AdminBoardUpdateDTO> getLabelList();
}
