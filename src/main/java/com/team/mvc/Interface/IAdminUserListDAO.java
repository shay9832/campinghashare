package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminUserListDTO;

import java.util.List;

public interface IAdminUserListDAO {

    /*select*/
    List<AdminUserListDTO> getList();
}
