package com.team.mvc.DTO;

import java.util.Date;

public class AdminPayUpdateDTO {

    //결제ID,회원닉네임,결제방법,결제금액,결제일자,취소일자,취소사유,보관ID,스토렌ID,렌탈ID,스토렌렌탈ID,결제유형
    private int payId,payPrice,storageId,storenId,rentalId,storenRentalId;
    private String nickName,payWay,cancelReason,payType;
    private Date payDate,cancelDate;

}


//USER_CODE AS "회원코드",
//NICKNAME AS "회원닉네임",
//PAY_METHOD_NAME AS "결제방법",
//PAY_AMOUNT AS "결제금액",
//PAY_DATE AS "결제일자",
//CANCEL_DATE AS "결제취소일",
//PAY_CANCEL_REASON_NAME AS "결제취소사유",
//STORAGE_ID AS "보관ID",
//STOREN_ID AS "스토렌ID",//STOREN_ID AS "스토렌ID",
//RENTAL_MATCHING_DONE_ID AS "렌탈매칭완료ID",