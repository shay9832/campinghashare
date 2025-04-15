package com.team.mvc.DTO;

import java.time.LocalDateTime;

public class AdminDeliveryUpdateDTO {

    /**
     * 배송 관련 정보를 담는 DTO 클래스 (변수만 선언)
     */

        // 배송 종류 (스토렌_최초입고, 보관_최초입고, 렌탈_발송, 스토렌_매칭발송, 스토렌_매칭반납, 스토렌_최종반환, 보관_최종반환, 렌탈_반납)
        private String deliveryType;

        // 발송인 ID (USER_CODE 또는 RENTAL_MATCHING_REQUESTER_ID)
        private Long senderId;

        // 수취인 ID (USER_CODE 또는 RENTAL_MATCHING_REQUESTER_ID)
        private Long receiverId;

        // 스토렌 ID
        private Long storenId;

        // 보관 ID
        private Long storageId;

        // 렌탈 매칭 완료 ID
        private Long rentalMatchingDoneId;

        // 렌탈 ID
        private Long rentalId;

        // 배송 ID (PLATFORM_DELIVERY_ID, USERS_DELIVERY_ID, PLATFORM_DELIVERY_RETURN_ID,
        // STOREN_LAST_RETURN_ID, STORAGE_LAST_RETURN_ID, USERS_DELIVERY_RETURN_ID)
        private Long deliveryId;

        // 장비명
        private String equipmentName;

        // 운송사 이름
        private String carrierName;

        // 운송장 번호
        private String waybillNumber;

        // 배송 시작일
        private LocalDateTime deliveryStartDate;

        // 배송 종료일
        private LocalDateTime deliveryEndDate;

        // 검수 결과 처리일
        private LocalDateTime inspectionCompletedDate;

        // 검수 결과 처리 유형
        private String inspectionResultType;


        //getter setter 구성


    public String getDeliveryType() {
        return deliveryType;
    }

    public void setDeliveryType(String deliveryType) {
        this.deliveryType = deliveryType;
    }

    public Long getSenderId() {
        return senderId;
    }

    public void setSenderId(Long senderId) {
        this.senderId = senderId;
    }

    public Long getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(Long receiverId) {
        this.receiverId = receiverId;
    }

    public Long getStorenId() {
        return storenId;
    }

    public void setStorenId(Long storenId) {
        this.storenId = storenId;
    }

    public Long getStorageId() {
        return storageId;
    }

    public void setStorageId(Long storageId) {
        this.storageId = storageId;
    }

    public Long getRentalMatchingDoneId() {
        return rentalMatchingDoneId;
    }

    public void setRentalMatchingDoneId(Long rentalMatchingDoneId) {
        this.rentalMatchingDoneId = rentalMatchingDoneId;
    }

    public Long getRentalId() {
        return rentalId;
    }

    public void setRentalId(Long rentalId) {
        this.rentalId = rentalId;
    }

    public Long getDeliveryId() {
        return deliveryId;
    }

    public void setDeliveryId(Long deliveryId) {
        this.deliveryId = deliveryId;
    }

    public String getEquipmentName() {
        return equipmentName;
    }

    public void setEquipmentName(String equipmentName) {
        this.equipmentName = equipmentName;
    }

    public String getCarrierName() {
        return carrierName;
    }

    public void setCarrierName(String carrierName) {
        this.carrierName = carrierName;
    }

    public String getWaybillNumber() {
        return waybillNumber;
    }

    public void setWaybillNumber(String waybillNumber) {
        this.waybillNumber = waybillNumber;
    }

    public LocalDateTime getDeliveryStartDate() {
        return deliveryStartDate;
    }

    public void setDeliveryStartDate(LocalDateTime deliveryStartDate) {
        this.deliveryStartDate = deliveryStartDate;
    }

    public LocalDateTime getDeliveryEndDate() {
        return deliveryEndDate;
    }

    public void setDeliveryEndDate(LocalDateTime deliveryEndDate) {
        this.deliveryEndDate = deliveryEndDate;
    }

    public LocalDateTime getInspectionCompletedDate() {
        return inspectionCompletedDate;
    }

    public void setInspectionCompletedDate(LocalDateTime inspectionCompletedDate) {
        this.inspectionCompletedDate = inspectionCompletedDate;
    }

    public String getInspectionResultType() {
        return inspectionResultType;
    }

    public void setInspectionResultType(String inspectionResultType) {
        this.inspectionResultType = inspectionResultType;
    }
}
