package com.team.mvc.Interface;

import com.team.mvc.DTO.DeliveryDTO;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;

public interface IDeliveryDAO {
    // 회원코드로 스토렌 장비 리스트 조회 (해당 회원이 가진 스토렌 장비 리스트)
    ArrayList<DeliveryDTO> listByUserCode(@Param("user_code") int user_code);

}
