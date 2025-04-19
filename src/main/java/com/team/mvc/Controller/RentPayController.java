package com.team.mvc.Controller;

import com.team.mvc.DTO.MyPayDTO;
import com.team.mvc.Interface.IRentPayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@Controller
public class RentPayController {

    @Autowired
    private IRentPayService rentPayService;

    @RequestMapping(value="storenmatching-rental-pay.action")
    public String rentStorenPayInfo(@RequestParam("rentalId") int transactionId
                                , @RequestParam("userCode") int userCode
                                , @RequestParam("type") String type
                                , Model model) {
        System.out.println("=== RentPayController : rentStorenPayInfo() : START ===");
        MyPayDTO myPayDTO = rentPayService.getMyPayInfo(transactionId, userCode, type);
        System.out.println("myUser Adderss1 : " + myPayDTO.getUser().getAddress1());
        System.out.println("myUser Adderss2 : " + myPayDTO.getUser().getAddress2());

        model.addAttribute("user", myPayDTO.getUser());
        model.addAttribute("couponList", myPayDTO.getCoupons());
        model.addAttribute("storen", myPayDTO.getStoren());
        model.addAttribute("matching", myPayDTO.getMatching_request());
        System.out.println("=== RentPayController : rentStorenPayInfo() : END ===");

        return "storenMatching-rental-pay";
    }

    // 결제 처리 & 사용자의 주소 변경 (api 처리)
    @PostMapping(value="/api/payment/storen-rent")
    @ResponseBody
    public Map<String, Object> rentPayment(@RequestParam("methodName") String methodName
                                    , @RequestParam("requestId") int requestId
                                    , @RequestParam("amount") int amount
                                    , @RequestParam(value = "couponId", required = false) Integer couponId
                                    , @RequestParam(value = "zipCode", required = false) String zipCode
                                    , @RequestParam(value = "address1", required = false) String address1
                                    , @RequestParam(value = "address2", required = false) String address2
                                    , @RequestParam(value = "addressChanged") Boolean addressChanged) {
        System.out.println("=== RentPayController : rentPayment() - AJAX : START ===");
        Map<String, Object> result = new HashMap<>();
        Integer payId = null;
        boolean paymentSuccess = false;
        boolean addressSuccess = false;

        try {
            // 결제 프로시저 호출하는 서비스 메소드 호출
            payId = rentPayService.insertPay(methodName, requestId, amount, couponId, "storen-rent");
            paymentSuccess = (payId != null && payId > 0);

            // 주소가 바뀌었다면 주소 변경 처리
            if (addressChanged != null && addressChanged) {
                addressSuccess = rentPayService.insertAddress(requestId, zipCode, address1, address2);
            } else {
                // 주소 변경이 필요 없는 경우는 성공으로 간주
                addressSuccess = true;
            }

            // 결과 상태에 따른 메시지 설정
            result.put("payId", payId);

            if (paymentSuccess && addressSuccess) {
                // 결제 성공 & 주소 변경 성공 (또는 주소 변경 없음)
                result.put("message", "결제가 완료되었습니다." +
                        ((addressChanged != null && addressChanged) ? "\n주소 변경이 완료되었습니다." : ""));
            } else if (paymentSuccess && !addressSuccess) {
                // 결제 성공 & 주소 변경 실패
                result.put("message", "결제는 완료되었으나 주소 변경에 실패했습니다.");
            } else if (!paymentSuccess && addressSuccess) {
                // 결제 실패 & 주소 변경 성공 (또는 주소 변경 없음)
                result.put("message", "결제에 실패했습니다." +
                        ((addressChanged != null && addressChanged) ? "\n주소 변경은 완료되었습니다." : ""));
            } else {
                // 결제 실패 & 주소 변경 실패
                result.put("message", "결제와 주소 변경 모두 실패했습니다.");
            }

        } catch(Exception e){
            e.printStackTrace(); // 로그 찍기
            result.put("payId", payId);
            result.put("message", "오류가 발생했습니다: " + e.getMessage());
        }

        System.out.println("=== RentPayController : rentPayment() - AJAX : END ===");
        return result;
    }


    @RequestMapping(value="storenmatching-rental-pay-complete.action")
    public String rentStorenPayComplete(@RequestParam("payId") int payId
                                        , @RequestParam("requestId") int requestId, Model model){
        System.out.println("=== RentPayController : rentStorenPayComplete() : START ===");
            MyPayDTO myPayDTO = rentPayService.getMyPayResultInfo(payId, requestId);

            model.addAttribute("pay", myPayDTO.getAdmin_payment());
            model.addAttribute("matching", myPayDTO.getMatching_request());

        System.out.println("=== RentPayController : rentStorenPayComplete() : END ===");
        return "storenMatching-rental-pay-complete";
    }

}
