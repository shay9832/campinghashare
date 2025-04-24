package com.team.mvc.Interface;

import com.team.mvc.DTO.RegisterStorenPayDTO;

public interface IRegisterStorenPayDAO {
    void insertStoragePayment(RegisterStorenPayDTO dto);
    void insertAddressLog(RegisterStorenPayDTO dto);
    int insertStorenEntry(RegisterStorenPayDTO dto); // void → int
    RegisterStorenPayDTO getUserAddressInfo(int userCode);
    void insertStorenStoragePayment(RegisterStorenPayDTO dto);

}