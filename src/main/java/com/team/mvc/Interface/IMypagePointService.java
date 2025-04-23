package com.team.mvc.Interface;

import com.team.mvc.DTO.MyPointDTO;
import com.team.mvc.DTO.UserDTO;

import java.util.List;

public interface IMypagePointService {
    List<MyPointDTO> listMyPointHistory(int userCode);
    UserDTO getMyPointInfo(int userCode);
}
