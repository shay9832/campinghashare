package com.team.mvc.Interface;

import com.team.mvc.DTO.StorenDTO;
import com.team.mvc.DTO.UserDTO;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface IMypageMainService {
    // 마이페이지 메인 상단 유저정보 구하기
    UserDTO getUserDTO(int userCode);

    // 마이페이지 메인 중간 등록장비내역(가장 최근 등록한 3건)
    LinkedHashMap<String, Object> getMyEquipmentMap(int userCode);

    // 마이페이지 메인 중간 대여장비내역(가장 최근 등록한 3건)
    LinkedHashMap<String, Object> getRentEquipmentMap(int userCode);

    // 마이페이지 메인 중간 내가 작성한 글과 내가 작성한 댓글 구하기(가장 최근 등록한 3건씩)
    Map<String, Object> getPostCommentMap(int userCode);

    // 마이페이지 메인 하단 장비 이용 내역(즉시 확인 필요, 거래 현황 화살표) 카운트 구하기
    Map<String, Map<String, Object>> getMyEquipmentStatus(int userCode);

    // 마이페이지 메인 하단 찜 내역 구하기
    List<StorenDTO> getMyWishlist(int userCode);
}
