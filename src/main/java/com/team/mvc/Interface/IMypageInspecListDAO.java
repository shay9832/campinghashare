package com.team.mvc.Interface;

import com.team.mvc.DTO.MypageInspecListDTO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IMypageInspecListDAO {
    // 해당 회원의 전체 검수내역 출력 - ajax 처리로 각 탭 선택 시 각각의 내역을 불러올 예정이므로 전체 내역 출력은 필요없음
    //List<MypageInspecListDTO> listByUserCode(@Param("user_code") int user_code);

    // 해당 회원의 스토렌 입고 검수내역 출력
    List<MypageInspecListDTO> listStorenStoreByUserCode(@Param("user_code") int user_code);
    // 해당 회원의 스토렌 반납 검수내역 출력
    List<MypageInspecListDTO> listStorenReturnByUserCode(@Param("user_code") int user_code);

    // 해당 회원의 보관 입고 검수내역 출력
    List<MypageInspecListDTO> listStorageStoreByUserCode(@Param("user_code") int user_code);

    // id로 스토렌 검색
    List<MypageInspecListDTO> getInspecByStorenId(@Param("userCode") int userCode, @Param("storenId") int storenId);

}
