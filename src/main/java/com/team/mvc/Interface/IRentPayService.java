package com.team.mvc.Interface;

import com.team.mvc.DTO.MyPayDTO;
import org.springframework.web.bind.annotation.RequestParam;

public interface IRentPayService {
    //결제 정보 획득(스토렌 렌탈비:storenmatching-rental-pay.action 결제 페이지에서 사용)
    MyPayDTO getMyPayInfo(int transactionId, int user_code, String transactionType);

    boolean payResult(int pay_method_id, int transaction_id, int pay_amount);
}
