package com.team.mvc.DTO;

import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDateTime;
import java.util.Date;

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

        // 새로운 배송 시작일
        private LocalDateTime newDeliveryStartDate;

        // 배송 종료일
        private LocalDateTime deliveryEndDate;

        // 검수 결과 처리일
        private LocalDateTime inspectionCompletedDate;

        // 검수 결과 처리 유형
        private String inspectionResultType;

        // 플랫폼 배송 반환 유형
        private Integer platformDeliveryReturnId,platformDeliveryId;

        //플랫폼 배송 유형
        private Integer payId;

        //유저 배송 유형
        private Integer userDeliveryReturnId,userDeliveryId;
        private String waybillEntryDate;

        //렌탈 데이터 유형
        @DateTimeFormat(pattern = "yyyy-MM-dd")
        private String rentalStartDate;
        @DateTimeFormat(pattern = "yyyy-MM-dd")
        private String rentalEndDate;

        private String memo;  // 메모 필드 추가
        private String status; // 배송 상태 필드 추가


        //getter setter 구성


    public Long getDeliveryId() {
        return deliveryId;
    }

    public void setDeliveryId(Long deliveryId) {
        this.deliveryId = deliveryId;
    }

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

    public LocalDateTime getNewDeliveryStartDate() {
        return newDeliveryStartDate;
    }

    public void setNewDeliveryStartDate(LocalDateTime newDeliveryStartDate) {
        this.newDeliveryStartDate = newDeliveryStartDate;
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

    public Integer getPlatformDeliveryReturnId() {
        return platformDeliveryReturnId;
    }

    public void setPlatformDeliveryReturnId(Integer platformDeliveryReturnId) {
        this.platformDeliveryReturnId = platformDeliveryReturnId;
    }

    public Integer getPlatformDeliveryId() {
        return platformDeliveryId;
    }

    public void setPlatformDeliveryId(Integer platformDeliveryId) {
        this.platformDeliveryId = platformDeliveryId;
    }

    public Integer getPayId() {
        return payId;
    }

    public void setPayId(Integer payId) {
        this.payId = payId;
    }

    public Integer getUserDeliveryReturnId() {
        return userDeliveryReturnId;
    }

    public void setUserDeliveryReturnId(Integer userDeliveryReturnId) {
        this.userDeliveryReturnId = userDeliveryReturnId;
    }

    public Integer getUserDeliveryId() {
        return userDeliveryId;
    }

    public void setUserDeliveryId(Integer userDeliveryId) {
        this.userDeliveryId = userDeliveryId;
    }

    public String getWaybillEntryDate() {
        return waybillEntryDate;
    }

    public void setWaybillEntryDate(String waybillEntryDate) {
        this.waybillEntryDate = waybillEntryDate;
    }

    public String getRentalStartDate() {
        return rentalStartDate;
    }

    public void setRentalStartDate(String rentalStartDate) {
        this.rentalStartDate = rentalStartDate;
    }

    public String getRentalEndDate() {
        return rentalEndDate;
    }

    public void setRentalEndDate(String rentalEndDate) {
        this.rentalEndDate = rentalEndDate;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
