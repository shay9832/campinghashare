package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminEventUpdateDTO;
import com.team.mvc.DTO.AdminMatchingListDTO;

import java.util.List;

public interface IAdminMatchingListDAO {

    /*select*/
    List<AdminMatchingListDTO> getList();
    List<AdminMatchingListDTO> getLists();
}
