package com.team.mvc.Interface;

import com.team.mvc.DTO.MyDeliveryDTO;

public interface IMypageDeliveryService {

    // 전체 리스트
    MyDeliveryDTO listByUserCode(int user_code);
}
