package com.team.mvc.Interface;

import com.team.mvc.DTO.StorenDTO;

import java.util.ArrayList;

public interface IStorenDAO {
    // 회원코드로 스토렌 장비 리스트 조회 (해당 회원이 가진 스토렌 장비 리스트)
    ArrayList<StorenDTO> listByUserCode(int user_code);
}
