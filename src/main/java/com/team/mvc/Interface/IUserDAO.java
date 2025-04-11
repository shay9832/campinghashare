package com.team.mvc.Interface;

import com.team.mvc.DTO.UserDTO;
import org.apache.ibatis.annotations.Param;

public interface IUserDAO {
    UserDTO login(UserDTO dto);
    void register(UserDTO dto);
    int idCheck(String userId);
    int nicknameCheck(String nickname);

    int verifyUser(@Param("userId") String userId,
                   @Param("userName") String userName,
                   @Param("userTel") String userTel);

    void updatePassword(@Param("userId") String userId,
                        @Param("newPassword") String newPassword);

    int getNextUserCode();
    void insertNicknameLog(UserDTO dto);
}
