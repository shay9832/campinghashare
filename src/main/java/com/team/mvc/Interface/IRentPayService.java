package com.team.mvc.Interface;

import com.team.mvc.DTO.MyPayDTO;
import org.springframework.web.bind.annotation.RequestParam;

public interface IRentPayService {
    //결제를 위해 필요한 정보 획득(스토렌 렌탈비:storenmatching-rental-pay.action 결제 페이지에서 사용)
    MyPayDTO getMyPayInfo(int transactionId, int user_code, String transactionType);

    //결제하기 (결제 후 해당 PAY_ID 반환 -> 반환값이 -1이 아니고 0보다 커야만 결제가 제대로 이루어진 것)
    Integer insertPay(String methodName, int requestId, int amount, Integer couponId, String payType);

    //결제 완료 출력 위해 필요한 정보 획득
    MyPayDTO getMyPayResultInfo(int payId, int requestId);

    //사용자의 배송주소 수정
    boolean insertAddress(int requestId, String zipCode, String address1, String address2);
}
