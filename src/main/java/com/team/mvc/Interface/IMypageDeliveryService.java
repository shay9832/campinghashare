package com.team.mvc.Interface;

import com.team.mvc.DTO.DeliveryDTO;

import java.util.List;

public interface IMypageDeliveryService {

    List<DeliveryDTO> getStorageDeliveries(int user_code);
    List<DeliveryDTO> getStorenOwnerDeliveries(int user_code);
    List<DeliveryDTO> getStorenUserDeliveries(int user_code);
    List<DeliveryDTO> getRentalDeliveries(int user_code);
}
