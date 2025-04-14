package com.team.mvc.Interface;

import com.team.mvc.DTO.UserDTO;
import org.apache.ibatis.annotations.Param;

public interface IUserDAO {

    // 로그인: USER_ID + USER_PW 일치 사용자 반환
    UserDTO getUserByIdAndPw(UserDTO dto);

    // 신규 사용자 등록
    void insertUser(UserDTO dto);

    // 닉네임 로그 등록
    void insertNicknameLog(UserDTO dto);

    // USER_CODE 시퀀스 조회
    int getNextUserCode();

    // USER_ID 중복 여부 확인
    int getUserCountById(String userId);

    // 닉네임 중복 여부 확인
    int getNicknameCount(String nickname);

    // 이름, 전화번호, 아이디로 사용자 존재 여부 확인
    int getUserCountByIdNameTel(@Param("userId") String userId,
                                @Param("userName") String userName,
                                @Param("userTel") String userTel);

    // 비밀번호 업데이트
    void updateUserPassword(@Param("userId") String userId,
                            @Param("newPassword") String newPassword);



    // 유저코드로 유저 정보 가져오기
    UserDTO getUserByUserCode(@Param("userCode") int userCode);
}
