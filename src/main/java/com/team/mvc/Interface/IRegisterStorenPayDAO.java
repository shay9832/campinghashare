package com.team.mvc.Interface;

import com.team.mvc.DTO.RegisterStorenPayDTO;

public interface IRegisterStorenPayDAO {
    RegisterStorenPayDTO getUserAddressInfo(int userCode);
}
