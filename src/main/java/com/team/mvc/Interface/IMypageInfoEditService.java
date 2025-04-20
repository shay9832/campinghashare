package com.team.mvc.Interface;

import com.team.mvc.DTO.UserDTO;

public interface IMypageInfoEditService {
    String getUserIdByUserCode(int UserCode);
    boolean checkPassword(int UserCode, String inputPassword);
    UserDTO getUserInfoByUserCode(int UserCode);
    void updateMemberInfo(int  UserCode, String newNickname, String newEmail);
}
