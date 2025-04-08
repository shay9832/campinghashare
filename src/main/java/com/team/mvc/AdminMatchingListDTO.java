package com.team.mvc;

import java.util.Date;

public class AdminMatchingListDTO {

    //렌탈ID,렌탈제목,장비코드,장비명,소유자코드,신청자코드,렌탈_시작일,렌탈_종료일,매칭신청일,매칭상태,승인일자

    private int rentalID;
    private String rentalName,equipCode,equipName,ownerCode,applicantCode,matchingCondition;
    private Date rentalStartDate,rentalEndDate,matchingStartDate,completeDate;
}
