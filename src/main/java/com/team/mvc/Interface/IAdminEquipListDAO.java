package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminEquipListDTO;

import java.util.List;

public interface IAdminEquipListDAO {

    /*select*/
    List<AdminEquipListDTO> getList();

    List<AdminEquipListDTO> getLists();

}
