package com.team.mvc.Interface;

import com.team.mvc.DTO.DeliveryDTO;
import com.team.mvc.DTO.MyDeliveryDTO;

import java.util.List;

public interface IMypageDeliveryService {

    // 전체 리스트
//    MyDeliveryDTO listByUserCode(int user_code);

    // AJAX용 추가 메소드
    List<DeliveryDTO> getStorageDeliveries(int user_code);
    List<DeliveryDTO> getStorenOwnerDeliveries(int user_code);
    List<DeliveryDTO> getStorenUserDeliveries(int user_code);
    List<DeliveryDTO> getRentalDeliveries(int user_code);
}
