package com.team.mvc.Interface;

import com.team.mvc.DTO.EquipmentDTO;
import com.team.mvc.DTO.RegisterStorenDTO;

import java.util.ArrayList;

public interface IRegisterStorenDAO {

    /*select*/
    public ArrayList<RegisterStorenDTO> getList(int equip_code);

    RegisterStorenDTO getEquipInfo(int equip_code);

    public ArrayList<RegisterStorenDTO> list();

}
