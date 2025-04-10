package com.team.mvc.DTO;

import java.util.List;

public class MyDeliveryDTO {
    private List<DeliveryDTO> storageDeliveries; // 보관 배송
    private List<DeliveryDTO> storenOwnerDeliveries; // 스토렌 소유자 배송
    private List<DeliveryDTO> storenUserDeliveries; // 스토렌 사용자 배송
    private List<DeliveryDTO> rentalDeliveries; // 렌탈 배송

    public List<DeliveryDTO> getStorageDeliveries() {
        return storageDeliveries;
    }

    public void setStorageDeliveries(List<DeliveryDTO> storageDeliveries) {
        this.storageDeliveries = storageDeliveries;
    }

    public List<DeliveryDTO> getStorenOwnerDeliveries() {
        return storenOwnerDeliveries;
    }

    public void setStorenOwnerDeliveries(List<DeliveryDTO> storenOwnerDeliveries) {
        this.storenOwnerDeliveries = storenOwnerDeliveries;
    }

    public List<DeliveryDTO> getStorenUserDeliveries() {
        return storenUserDeliveries;
    }

    public void setStorenUserDeliveries(List<DeliveryDTO> storenUserDeliveries) {
        this.storenUserDeliveries = storenUserDeliveries;
    }

    public List<DeliveryDTO> getRentalDeliveries() {
        return rentalDeliveries;
    }

    public void setRentalDeliveries(List<DeliveryDTO> rentalDeliveries) {
        this.rentalDeliveries = rentalDeliveries;
    }
}
