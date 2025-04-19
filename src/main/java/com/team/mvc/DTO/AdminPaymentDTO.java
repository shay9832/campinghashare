package com.team.mvc.DTO;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 관리자 결제 정보 DTO 클래스
 */
public class AdminPaymentDTO {
    private int paymentId;      // 결제 ID
    private int userCode;       // 회원 코드
    private String memberNickname; // 회원 닉네임
    private String paymentMethod;  // 결제 방법
    private BigDecimal payAmount;  // 결제 금액
    private String formattedAmount; // 화면 표시용 포맷팅된 금액
    private Date paymentDate;    // 결제 일자
    private Date cancelDate;     // 취소 일자
    private String cancelReason; // 취소 사유
    private Integer storageId;   // 보관 ID
    private Integer storenId;    // 스토렌 ID
    private Integer rentalId;    // 렌탈 ID (렌탈매칭완료ID와 같음)
    private Integer storenRentalId; // 스토렌렌탈 ID (스토렌매칭완료ID와 같음)
    private String paymentType;  // 결제 유형 (렌탈, 보관, 스토렌)
    private String status;       // 상태 (결제완료, 결제취소, 결제대기)

    // Getters and Setters
    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getUserCode() {
        return userCode;
    }

    public void setUserCode(int userCode) {
        this.userCode = userCode;
    }

    public String getMemberNickname() {
        return memberNickname;
    }

    public void setMemberNickname(String memberNickname) {
        this.memberNickname = memberNickname;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public BigDecimal getPayAmount() {
        return payAmount;
    }

    public void setPayAmount(BigDecimal payAmount) {
        this.payAmount = payAmount;
    }

    public String getFormattedAmount() {
        return formattedAmount;
    }

    public void setFormattedAmount(String formattedAmount) {
        this.formattedAmount = formattedAmount;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public Date getCancelDate() {
        return cancelDate;
    }

    public void setCancelDate(Date cancelDate) {
        this.cancelDate = cancelDate;
    }

    public String getCancelReason() {
        return cancelReason;
    }

    public void setCancelReason(String cancelReason) {
        this.cancelReason = cancelReason;
    }

    public Integer getStorageId() {
        return storageId;
    }

    public void setStorageId(Integer storageId) {
        this.storageId = storageId;
    }

    public Integer getStorenId() {
        return storenId;
    }

    public void setStorenId(Integer storenId) {
        this.storenId = storenId;
    }

    public Integer getRentalId() {
        return rentalId;
    }

    public void setRentalId(Integer rentalId) {
        this.rentalId = rentalId;
    }

    public Integer getStorenRentalId() {
        return storenRentalId;
    }

    public void setStorenRentalId(Integer storenRentalId) {
        this.storenRentalId = storenRentalId;
    }

    public String getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(String paymentType) {
        this.paymentType = paymentType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}