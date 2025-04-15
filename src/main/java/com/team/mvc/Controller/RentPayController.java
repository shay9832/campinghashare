package com.team.mvc.Controller;

import com.team.mvc.DTO.MyPayDTO;
import com.team.mvc.Interface.IRentPayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RentPayController {

    @Autowired
    private IRentPayService rentPayService;

    @RequestMapping(value="storenmatching-rental-pay.action")
    public String rentStorenPay(@RequestParam("rentalId") int transactionId
                                , @RequestParam("userCode") int userCode
                                , @RequestParam("type") String type
                                , Model model) {
        MyPayDTO myPayDTO = rentPayService.getMyPayInfo(transactionId, userCode, type);
        System.out.println("myUser Adderss1 : " + myPayDTO.getUser().getAddress1());
        System.out.println("myUser Adderss2 : " + myPayDTO.getUser().getAddress2());

        model.addAttribute("user", myPayDTO.getUser());
        model.addAttribute("couponList", myPayDTO.getCoupons());
        model.addAttribute("storen", myPayDTO.getStoren());
        model.addAttribute("matching", myPayDTO.getMatching_request());

        return "storenMatching-rental-pay";
    }

    @RequestMapping(value="storenmatching-rental-pay-complete.action")
    public String rentStorenPayComplete() {
        return "storenMatching-rental-pay-complete";
    }

}
