package com.team.mvc.Interface;

import com.team.mvc.DTO.DeliveryDTO;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;

public interface IDeliveryDAO {
    // 회원코드로 모든 배송내역 조회 (해당 회원이 가진 스토렌 장비 리스트)
    ArrayList<DeliveryDTO> listByUserCode(@Param("user_code") int user_code);

    // 회원코드로 보관 배송만 조회
    ArrayList<DeliveryDTO> listStorageByUserCode(@Param("user_code") int user_code);

    // 회원코드로 스토렌 소유자 배송만 조회
    ArrayList<DeliveryDTO> listStorenOwnerByUserCode(@Param("user_code") int user_code);
    // 회원코드로 스토렌 사용자 배송만 조회
    ArrayList<DeliveryDTO> listStorenUserByUserCode(@Param("user_code") int user_code);

    // 회원코드로 렌탈 소유자 배송만 조회
    ArrayList<DeliveryDTO> listRentalByUserCode(@Param("user_code") int user_code);

}
