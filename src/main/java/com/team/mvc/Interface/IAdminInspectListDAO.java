package com.team.mvc.Interface;

import com.team.mvc.DTO.AdminInspectListDTO;

import java.util.ArrayList;

public interface IAdminInspectListDAO {

    /*select*/

    // 입고반환
    public ArrayList<IAdminInspectListDAO> list();

    //스토렌반환
    public ArrayList<IAdminInspectListDAO> listr();


    /*insert*/
    //검수결과 처리
    public int add(AdminInspectListDTO ai);
}
