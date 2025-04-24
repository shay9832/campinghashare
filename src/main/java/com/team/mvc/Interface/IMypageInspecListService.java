package com.team.mvc.Interface;

import com.team.mvc.DTO.DeliveryDTO;
import com.team.mvc.DTO.MypageInspecListDTO;

import java.util.List;

public interface IMypageInspecListService {
    // 스토렌 입고검수목록만 불러주는 메소드
    List<MypageInspecListDTO> listStorenStoreInspec(int user_code);
    // 스토렌 반납검수목록만 불러주는 메소드
    List<MypageInspecListDTO> listStorenReturnInspec(int user_code);
    // 보관 입고검수목록만 불러주는 메소드
    List<MypageInspecListDTO> listStorageStoreInspec(int user_code);

    //id로 스토렌 검색
    List<MypageInspecListDTO> getInspecByStorenId(int storenId);
}
