package com.team.mvc.Interface;

import com.team.mvc.DTO.StorenDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Mapper
public interface IStorenDAO {
    // 전체 스토렌 장비 리스트 조회
    List<StorenDTO> listStoren();

    // 회원코드로 스토렌 장비 리스트 조회 (해당 회원이 가진 스토렌 장비 리스트)
    ArrayList<StorenDTO> listByUserCode(@Param("user_code") int user_code);

    // 회원코드와 장비코드로 스토렌 장비 리스트 조회
    ArrayList<StorenDTO> listByUserCodeEquipCode(@Param("user_code") int user_code, @Param("equip_code") int equip_code);

    // 처음 스토렌 신청했을 때의 스토렌 정보 가져오기
    StorenDTO getStorenByEquipCode(@Param("user_code") int user_code, @Param("equip_code") int equip_code);


    //매칭 신청 수가 1 이상인 스토렌 장비 리스트 조회
    ArrayList<StorenDTO> listMatchingStorenByUserCode(@Param("user_code") int user_code);
    // 내가 매칭 신청한 스토렌 장비 리스트 조회
    ArrayList<StorenDTO> listMyStorenApplicationsByUserCode(@Param("user_code") int user_code);


    //스토렌id로 해당 스토렌 장비 정보 가져오기
    StorenDTO getStorenByStorenId(@Param("storen_id") int storen_id);

    // 스토렌 장비 검색(키워드)
    List<StorenDTO> searchStorenKeyword(@Param("searchKeyword") String searchKeyword);

    // 스토렌 장비 검색(키워드, 가격 범위, 날짜 범위)
    List<StorenDTO> searchStoren(Map<String, Object> params);


    // storen_id로 렌탈 정보 조회
    StorenDTO getRentalInfoByStorenId(@Param("storen_id") int storen_id);

    // 렌탈 정보 업데이트 (추가해야 하는 메서드)
    int updateStorenRegisterRentalRegister(StorenDTO dto);

    // 평균 신품 가격 조회
    int getAvgNewPrice(@Param("equip_code") int equip_code);

    // 평균 렌탈 가격 조회
    int getAvgRentalPrice(@Param("equip_code") int equip_code);

    // 장비명으로 평균 신품 가격 조회 (추가)
    int getAvgNewPriceByEquipName(@Param("equipName") String equipName);

    // 장비명으로 평균 렌탈 가격 조회 (추가)
    int getAvgRentalPriceByEquipName(@Param("equipName") String equipName);


    // 해당 유저가 가진 스토렌의 장비 코드들만 조회(중복제거)
    List<Integer> listStorenEquipCodes(@Param("userCode") int userCode);

    // 해당 유저가 가진 스토렌 장비의 각 상태의 개수 조회
    Map<String, Object> getStorenStatus(@Param("userCode") int userCode);

    // 해당 유저의 상태별 필터링한 스토렌 목록 조회
    List<StorenDTO> listByUserCodeStatus(@Param("userCode") int userCode, @Param("status") String status);

    // 해당 유저의 다중 상태별 필터링한 스토렌 목록 조회
    List<StorenDTO> listByUserCodeMultiStatus(@Param("userCode") int userCode, @Param("statuses") String[] statuses);


    // 해당 유저의 스토렌 위시리스트(찜 목록) 조회
    List<StorenDTO> listMyWishByUserCode(@Param("userCode") int userCode);
    // 해당 유저의 찜 삭제
    int deleteMyWishByUserCodeStorenId(@Param("userCode") int userCode, @Param("storenId") int storenId);
}
