package com.team.mvc.DTO;

import java.util.Date;

public class AdminPayUpdateDTO {

    //결제ID,회원닉네임,결제방법,결제금액,결제일자,취소일자,취소사유,보관ID,스토렌ID,렌탈ID,스토렌렌탈ID,결제유형
    private int payId,payPrice,storageId,storenId,rentalId,storenRentalId;
    private String nickName,payWay,cancelReason,payType;
    private Date payDate,cancelDate;

}
